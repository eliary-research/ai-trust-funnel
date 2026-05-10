-- L1 paper query templates
-- Database: prism (Spanner instance: currot-spanner-prod-bab)
-- Schema verified 2026-05-03; re-verified 2026-05-11 at v0.3.0 publication:
--   spectrum_session.status enum is 'answering' / 'submitted' / 'complete'
--   ('analyzed' is empty in production; 'submitted' carries the analysis-complete role
--   with score_ait populated). Counts at 2026-05-11 freeze (data window 4/27–5/10):
--   3,899 total / 1,566 with score_ait / 3,890 with free_answer_1.
--
-- Patch history (see v0.3.1 commit log):
--   v0.1   (2026-05-03): initial template; used 'analyzed' status, ROW_NUMBER,
--                         SUM(COUNT(*)) OVER ()
--   v0.3.1 (2026-05-11): Q1+Q6 predicates extended to include 'submitted'.
--                         Q2 rewritten with CTE pattern (Spanner UNIMPLEMENTED on
--                         window-aggregate-of-aggregate).
--                         Q4 rewritten session-level with MAX-JOIN pattern (Spanner
--                         UNIMPLEMENTED on ROW_NUMBER; user_id is null on pre-verify
--                         sessions, so user-level DISTINCT collapses 1,566 analyzed
--                         sessions into ~67 distinct user_ids).
-- Use these queries during 2026-05-08 → 2026-05-14 cleanup window.
--
-- ============================================================================
-- Run order:
--   1. Q0  Sanity check (verify schema + counts before paper writing)
--   2. Q1  Funnel stage transition counts
--   3. Q2  score_ait distribution
--   4. Q3  score_ait × funnel stage
--   5. Q4  Conversion by AI segment (THE central empirical claim)
--   6. Q5  Free-answer aggregate properties (length/edits, no raw text)
--   7. Q6  AI provider failure × stage transition correlation
--
-- All queries are READ ONLY. Write paths are out of scope here.
-- ============================================================================


-- ----------------------------------------------------------------------------
-- Q0  Sanity check
-- Confirms population sizes match assumptions in the paper draft. If totals
-- diverge by >5% from prior estimates (Lucid 2,733 sessions / 950 analyzed),
-- update the paper's Empirical section before submitting.
-- ----------------------------------------------------------------------------
SELECT
  COUNT(*)                                    AS total_sessions,
  COUNTIF(status = 'answering')               AS answering_now,
  COUNTIF(status = 'submitted')               AS submitted,
  COUNTIF(status = 'analyzed')                AS analyzed,
  COUNTIF(status = 'complete')                AS complete_count,
  COUNT(score_ait)                            AS with_score_ait,
  COUNT(free_answer_1)                        AS with_free1,
  ROUND(AVG(score_ait), 3)                    AS avg_score_ait,
  ROUND(STDDEV(score_ait), 3)                 AS std_score_ait
FROM spectrum_session;


-- ----------------------------------------------------------------------------
-- Q1  4-stage funnel transition counts
-- Maps to Section 5.1 (4-stage funnel decomposition).
-- Stage 1 = session start. Stage 2 = reach analyze. Stage 3 = phone-verify
-- (signup). The cross-table JOIN with prism_user provides Stage 3 count.
-- ----------------------------------------------------------------------------
WITH session_users AS (
  SELECT
    s.user_id,
    s.session_id,
    s.status,
    s.created_at,
    (s.status IN ('analyzed', 'submitted', 'complete')) AS reached_analysis,
    (pu.user_id IS NOT NULL)               AS phone_verified
  FROM spectrum_session s
  LEFT JOIN prism_user pu ON pu.user_id = s.user_id
)
SELECT
  COUNT(*)                                              AS stage1_starts,
  COUNTIF(reached_analysis)                             AS stage2_analyzed,
  COUNTIF(phone_verified)                               AS stage3_phone_verified,
  ROUND(100.0 * COUNTIF(reached_analysis) / COUNT(*), 2) AS pct_start_to_analyze,
  ROUND(100.0 * COUNTIF(phone_verified) / COUNT(*), 2)  AS pct_start_to_verify,
  ROUND(100.0 * COUNTIF(phone_verified AND reached_analysis)
                / NULLIF(COUNTIF(reached_analysis), 0), 2) AS pct_complete_to_verify
FROM session_users;


-- ----------------------------------------------------------------------------
-- Q2  score_ait distribution
-- Maps to Section 5.3 (4 AI-attitude items response distribution).
-- Buckets in 0.5 increments across the 1-7 scale.
-- Output: distribution shape for Figure 3 (histogram).
-- ----------------------------------------------------------------------------
-- v0.3.1: Rewritten with CTE pattern. Spanner UNIMPLEMENTED on
-- `SUM(COUNT(*)) OVER ()` (window-aggregate-of-aggregate).
WITH bucketed AS (
  SELECT
    CAST(FLOOR(score_ait * 2) / 2 AS FLOAT64) AS ait_bucket,
    COUNT(*)                                  AS sessions
  FROM spectrum_session
  WHERE score_ait IS NOT NULL
  GROUP BY ait_bucket
),
tot AS (SELECT SUM(sessions) AS total FROM bucketed)
SELECT
  b.ait_bucket,
  b.sessions,
  ROUND(100.0 * b.sessions / t.total, 2) AS pct
FROM bucketed b CROSS JOIN tot t
ORDER BY b.ait_bucket;


-- ----------------------------------------------------------------------------
-- Q3  score_ait × funnel stage
-- Verifies that score_ait is computable only from analyze-stage sessions
-- (this is structural — score_ait is derived from analysis, so by definition
-- it is null for status = 'answering').
-- The interesting comparison is across analyzed sub-statuses.
-- ----------------------------------------------------------------------------
SELECT
  status,
  COUNT(*)                              AS sessions,
  COUNT(score_ait)                      AS with_ait,
  ROUND(AVG(score_ait), 3)              AS avg_ait,
  ROUND(STDDEV(score_ait), 3)           AS std_ait,
  ROUND(MIN(score_ait), 3)              AS min_ait,
  ROUND(MAX(score_ait), 3)              AS max_ait
FROM spectrum_session
GROUP BY status
ORDER BY sessions DESC;


-- ----------------------------------------------------------------------------
-- Q4  Conversion by AI segment   ← CENTRAL EMPIRICAL CLAIM (Section 5.4)
-- Buckets users into AI-positive (≥ 5), AI-neutral (3–5), AI-skeptical (≤ 3)
-- and computes phone-verify conversion at the analyze→signup gate.
-- Hypothesis ranking implication:
--   - If conversion rate is similar across segments → H1 (residual AI
--     resistance) is NOT dominant; H2/H3/H4 candidates rise in prior.
--   - If AI-positive conversion is markedly higher → H1 is dominant.
--   - Threshold values (5 / 3) are placeholders; final cutoffs in the paper
--     should be set at the empirical 33rd / 67th percentile of score_ait.
-- ----------------------------------------------------------------------------
-- v0.3.1: Rewritten session-level. Two reasons:
--   (a) Original user-level form via ROW_NUMBER fails on Spanner with
--       `UNIMPLEMENTED: Unsupported built-in function: ROW_NUMBER`;
--   (b) `user_id` is null on pre-verify spectrum sessions (only post-phone-verify
--       sessions have populated user_id), so user-level DISTINCT collapses 1,566
--       analyzed sessions into ~67 distinct user_ids.
-- The session-level pattern below treats each analyzed session as the unit; "verified"
-- = same session's user_id is populated (= the session's user has phone-verified).
WITH session_ait AS (
  SELECT
    session_id,
    user_id,
    score_ait,
    CASE
      WHEN score_ait <= 3 THEN 'AI_skeptical'
      WHEN score_ait >= 5 THEN 'AI_positive'
      ELSE 'AI_neutral'
    END AS segment
  FROM spectrum_session
  WHERE score_ait IS NOT NULL
    AND status IN ('analyzed', 'submitted', 'complete')
)
SELECT
  segment,
  COUNT(*)                                                  AS sessions,
  COUNTIF(user_id IS NOT NULL)                              AS verified,
  ROUND(100.0 * COUNTIF(user_id IS NOT NULL) / COUNT(*), 2) AS conversion_pct,
  ROUND(AVG(score_ait), 3)                                  AS avg_ait
FROM session_ait
GROUP BY segment
ORDER BY avg_ait DESC;


-- ----------------------------------------------------------------------------
-- Q5  Free-answer aggregate properties (privacy-preserving, NO raw text)
-- Maps to Section 4 Methodology + Section 5.3 (in-test trust calibration).
-- Per-item length and (planned) edit counts. Free text is held private; only
-- aggregate length statistics + completion rates leave the platform.
-- Future: compute per-item self-disclosure score (uses prism_answer column),
--         which requires joining to prism_answer.
-- ----------------------------------------------------------------------------
SELECT
  -- per-item completion rate (proxy for "did the user attempt this item")
  COUNTIF(free_answer_1 IS NOT NULL AND CHAR_LENGTH(free_answer_1) > 0)
    AS attempted_fa1,
  COUNTIF(free_answer_2 IS NOT NULL AND CHAR_LENGTH(free_answer_2) > 0)
    AS attempted_fa2,
  COUNTIF(free_answer_3 IS NOT NULL AND CHAR_LENGTH(free_answer_3) > 0)
    AS attempted_fa3,
  COUNTIF(free_answer_4 IS NOT NULL AND CHAR_LENGTH(free_answer_4) > 0)
    AS attempted_fa4,

  -- per-item median length (privacy-preserving — no text leaks)
  -- Note: APPROX_QUANTILES not available on Spanner GoogleSQL;
  --       compute median client-side after extracting per-row length.
  ROUND(AVG(CHAR_LENGTH(free_answer_1)), 1) AS avg_len_fa1,
  ROUND(AVG(CHAR_LENGTH(free_answer_2)), 1) AS avg_len_fa2,
  ROUND(AVG(CHAR_LENGTH(free_answer_3)), 1) AS avg_len_fa3,
  ROUND(AVG(CHAR_LENGTH(free_answer_4)), 1) AS avg_len_fa4,

  COUNT(*) AS sessions_with_any
FROM spectrum_session
WHERE free_answer_1 IS NOT NULL
   OR free_answer_2 IS NOT NULL
   OR free_answer_3 IS NOT NULL
   OR free_answer_4 IS NOT NULL;


-- ----------------------------------------------------------------------------
-- Q6  AI provider failure × stage transition correlation
-- Maps to Section 5.5. We expect failure rate to be (mildly) correlated
-- with mid-flow drops. If correlation is strong, "AI flake" is a confound
-- for H1 (residual AI resistance); document this in Limitations.
-- ----------------------------------------------------------------------------
WITH provider_daily AS (
  SELECT
    DATE(created_at, 'UTC')                AS d,
    COUNT(*)                                AS calls,
    COUNTIF(NOT success)                    AS failures,
    ROUND(100.0 * COUNTIF(NOT success) / COUNT(*), 2) AS failure_pct
  FROM prism_provider_event
  WHERE created_at >= TIMESTAMP('2026-04-18')
  GROUP BY d
),
session_daily AS (
  SELECT
    DATE(created_at, 'UTC')                                 AS d,
    COUNT(*)                                                 AS starts,
    COUNTIF(status IN ('analyzed','submitted','complete'))               AS analyzed,
    ROUND(100.0 * COUNTIF(status IN ('analyzed','submitted','complete')) / COUNT(*), 2)
                                                             AS reach_pct
  FROM spectrum_session
  WHERE created_at >= TIMESTAMP('2026-04-18')
  GROUP BY d
)
SELECT
  s.d,
  s.starts,
  s.analyzed,
  s.reach_pct,
  p.calls         AS ai_calls,
  p.failures      AS ai_failures,
  p.failure_pct   AS ai_failure_pct
FROM session_daily s
LEFT JOIN provider_daily p USING (d)
ORDER BY s.d;


-- ============================================================================
-- Notes for the cleanup window
-- ----------------------------------------------------------------------------
-- 1. Run Q0 first; if any count is materially different from the 5/3 snapshot
--    (2,737 / 950 / 2,728 / etc.), pause and reconcile before writing.
--
-- 2. score_ait threshold cutoffs in Q4 (≤3 / ≥5) are placeholders; replace
--    with empirical 33rd/67th percentiles computed from Q2 distribution.
--    The paper should justify whichever cutoff is used.
--
-- 3. Free-text answers are NEVER exported. Only aggregate length/edit/completion
--    statistics. Document this in the Privacy section of the manuscript.
--
-- 4. If score_ait turns out NOT to be the 4-item AI attitude composite — i.e.
--    if it represents something else in the analysis output JSON — fall back
--    to extracting a composite directly from raw_answers JSON. Example:
--      JSON_VALUE(raw_answers, '$.q_ai_1') etc.
--    Schema: spectrum_session.raw_answers is JSON; key naming is implementation-
--    defined and should be checked against backend code (lucid/api source).
--
-- 5. Q6 may show a confound with the 5/3 surge (~2,000/day projected vs prior
--    150-200/day plateau). If reach_pct drops on 5/3 due to AI rate-limiting,
--    document explicitly and argue that the H1-vs-H2 separability holds even
--    after controlling for AI provider load.
-- ============================================================================

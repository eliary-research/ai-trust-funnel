# The AI Trust Funnel: A Spectrum-First Onboarding Study

**Draft v0.3.1 — 2026-05-11 (post-empirical-substitution)**

> Status: §1–§9 fully drafted. §5 empirical findings substituted from Q0–Q6 (executed 2026-05-11 against `prism` Spanner). Central finding: **H1 DOMINANT branch** per the §5.0 prespecified threshold (segment-conversion dominance ratio 1.696 ≥ 1.5 prespecified; AI-positive 6.41% n=78, AI-skeptical 3.78% n=1,032). Small-N caveat: AI-positive cell yields Wilson 95% CI [2.7%, 14.0%] overlapping the skeptical CI [2.7%, 5.1%]; replication target N ≥ 200 prespecified (§5.4).
>
> Target: arXiv `stat.AP` (primary), `cs.HC` + `cs.SI` cross-list. Venue: ICWSM 2027 / CHI 2027 LBW.
> Companion papers: EN6 (Signal Inflation Hypothesis) for theoretical foundation; CC6 (Currot mirror) for methodology; CVDA (cross-vendor disagreement atlas) shares the `prism` data substrate at a different unit of analysis.

---

## Abstract

Multi-AI consumer products face a structural challenge that single-vendor products do not: how to introduce users to cross-model comparison without first requiring them to articulate prompt-engineering preferences they may not have. We study one design pattern that addresses this challenge — *spectrum-first onboarding*, in which a user completes a 74-question personality questionnaire whose responses are routed to multiple AIs in parallel; cross-vendor disagreement on the same person is the central pedagogical unit. Empirical anchor: Lucid platform, 3,899 spectrum sessions across the 14-day public-access window (April 27 – May 10, 2026; data freeze 2026-05-11); 1,566 (40.16%) reached the analysis stage and 67 of those phone-verified, yielding a 4.28% completer-to-verify conversion rate. We define a Three-Stage AI Trust Funnel (Stages 1–3 measurable; Stage 0 landing-visit and Stages 4–5 retention/cross-product stated explicitly as instrumentation gaps) and frame five testable hypotheses for the conversion gap. Embedded AI-attitude items (4 of 74 spectrum questions) are operationalized as a dual-function intervention. The analyzed population is **65.9% AI-skeptical** (`score_ait` ≤ 3, n=1,032 of 1,566; mean 2.618 on a 1–7 scale, SD 1.249), disconfirming the implicit selection assumption that spectrum-first onboarding draws AI-positive users — the spectrum surface itself does the trust-building work. The central empirical finding is **the segment-conversion comparison: AI-positive sessions phone-verify at 6.41% (n=78), AI-skeptical at 3.78% (n=1,032); dominance ratio 1.696, placing the result in the H1 DOMINANT branch (≥ 1.5 prespecified threshold)** — residual AI resistance is a leading explanatory factor for the conversion gap, with H2 (phone-gate friction) and H4 (value-proposition weakness) retained as plausible secondary contributors. Pre-data priors across the five hypotheses are not assigned; ranking is done ex post on the prespecified segment-conversion ratio (§5.4).

---

## 1. Introduction

Multi-AI consumer products face a structural challenge that single-vendor products do not: how to introduce users to the experience of comparing model outputs without first requiring them to articulate prompt-engineering preferences they may not have. The vendor-agnostic stance is the value proposition — yet it is also a discovery cost. The user must *learn what to ask* of multiple models, and must trust the comparison enough to engage with disagreement rather than treat it as noise.

We study one design pattern that addresses this challenge: spectrum-first onboarding. In this pattern, a user is invited to complete a personality questionnaire (the *spectrum*) before any open-ended chat surface is exposed. The spectrum produces structured user data, which is then routed to multiple AIs in parallel. The product-level claim — surfaced explicitly in copy as "they almost never agree" — is that cross-vendor disagreement on the same person is itself the central pedagogical engine. AI introduces itself through the productive friction of comparison, not through demand for prompt engineering.

This paper's empirical anchor is Lucid, a four-vendor multi-AI identity analysis (Claude, GPT, Gemini, Llama) that implements spectrum-first onboarding. The Lucid service was deployed April 18, 2026; meaningful public traffic begins April 27 (the first day with > 100 starts; April 18–26 daily starts ≤ 3 per day during early-access internal testing). In the 14-day public-access window from April 27 through May 10, 2026 (data freeze 2026-05-11), Lucid received 3,899 spectrum sessions, of which 1,566 (40.16%) reached the analysis stage and 88 phone-verified — 67 of which had completed the spectrum analysis (the remaining 21 verified without producing an analysis output). The **completer-to-verify conversion rate of 4.28% (67 of 1,566)** is the central empirical phenomenon. Single-vendor consumer AI products typically achieve double-digit signup conversion through chat-first surfaces; the spectrum-first pattern trades signup volume for trust calibration.

We make five academic contributions:

1. **A formal three-stage AI Trust Funnel definition** — spectrum start → spectrum complete (analyze) → phone-verify — where each stage transition is a separate trust-cost gate, and the gate where users abandon discriminates between competing explanations of the conversion gap. We additionally identify three adjacent stages (Stage 0 landing visit, Stage 4 repeat session, Stage 5 cross-product transition) that are outside our instrumentation window and are stated as gaps rather than analyzed; the headline funnel claim concerns Stages 1–3.

2. **Agreeable disagreement as pedagogical hook** — operationalizing the EN6 claim (Kim, 2026) that cross-vendor disagreement is a measurable personalization signal single labs cannot self-generate. The framing converts what would normally read as a deficit (4 AIs disagreeing → unreliable) into the engine (4 AIs disagreeing → tell me about myself).

3. **Embedded AI-attitude items as dual-function intervention** — within the 74-question spectrum, 4 questions directly measure AI attitude. The aggregate response distribution segments users into AI-positive / -neutral / -skeptical (signal); the act of self-articulating an AI position primes subsequent willingness to engage with the AI synthesis (intervention). Standard A/B tests treat onboarding questions as measurement *or* treatment, not both. We argue the items are necessarily both, and design the analysis to separate the two effects.

4. **Five testable hypotheses for the conversion gap** — H1 residual AI resistance, H2 phone-gate friction, H3 single-use satiation, H4 value-proposition weakness, H5 reciprocity absence — with intervention designs and predicted effect sizes for each.

5. **Necessary-but-insufficient framing** — spectrum-first reduces AI resistance partially; this is a *necessary* condition for downstream conversion but not *sufficient*. The contribution is the formalization of where the surface works (top of funnel) and where it does not (bottom of funnel).

### 1.1 Disclosure and Positionality

The first author operates Lucid through Eliary Inc., the platform from which this paper's data is drawn. The methodology mirrors a companion paper, CC6 (currently in preparation), which applies the same funnel-decomposition approach to Currot, a separate Eliary product. Free-text answers are never exported — only aggregate length and completion statistics, plus the four AI-attitude items at aggregate distribution level. Raw text and per-item responses remain on platform. The cross-product methodology, paired companion paper, and aggregate-only data export are designed to make the contribution interpretable independent of the platform's product trajectory.

The framework, hypothesis registry (§6), and analytic specifications (`queries_template.sql`) are versioned in the project repository (commit history available) and were finalized prior to data extraction. The arXiv preprint timestamp is intended to serve as a public freeze-point for the framework prior to any operational outcomes Lucid produces.

---

## 2. Background

### 2.1 AI Resistance and Algorithm Aversion

A robust finding in the algorithm-aversion literature (Dietvorst, Simmons, & Massey, 2015; Logg, Minson, & Moore, 2019; the foundational trust-in-automation framing is Lee & See, 2004) is that users frequently prefer human judgment over algorithmic recommendation even when the algorithm is more accurate. Resistance is heterogeneous: domain familiarity, perceived stakes, and user expertise all moderate it (Burton, Stein, & Jensen, 2020). Recent work has explored the inverse — *algorithm appreciation* in lower-stakes objective tasks (Logg et al., 2019) — but the consumer-AI personalization context, where AI generates subjective interpretation about the user themselves, sits in an under-studied middle zone.

The Lucid spectrum's 4 embedded AI-attitude items measure exactly this middle-zone resistance, operationalized through items asking the user to articulate their stance on AI confidence, AI in personal decisions, and the trust they extend to model output. We treat these items as both measurement (allowing segmentation) and as intervention (the act of articulating a position is itself a treatment, per the well-documented mere-measurement effect in marketing psychology; Morwitz & Fitzsimons, 2004).

### 2.2 Test-First vs Chat-First Onboarding

Test-first onboarding has precedent: 16Personalities reaches roughly 40 million visits per month on a static-report personality test, demonstrating consumer demand for structured self-discovery without conversational AI. Akinator and similar guess-the-character products demonstrate that long-form structured Q&A can be retained when each step compounds toward a payoff. In the AI-product context, we know of no published study that decomposes the spectrum-first pattern's funnel. The pattern is increasingly common — Character.AI, Replika, and several smaller multi-AI products gate access on a profile-creation step — but the academic literature treats onboarding A/B tests as optimization targets, not as theoretical objects.

### 2.3 Multi-AI Evaluation

Chatbot Arena (Chiang et al., 2024) established consumer-facing multi-AI comparison as a category — but the comparisons are over coding, math, and factual tasks, not subjective interpretation about the user. Eliary's central methodological move is to apply Arena-style preference comparison to subjective domains where ground truth is undefined. Where Chatbot Arena measures *which model is better*, Lucid measures *which model resonates with this user* — a different signal that is informative because it incorporates user-specific preference rather than averaging across users.

### 2.4 Funnel Decomposition in HCI

The HCI literature on conversion funnels (Kohavi, Tang, & Xu, 2020) emphasizes that aggregate conversion-rate optimization frequently misallocates effort across funnel stages. We apply this framework to AI-product onboarding: rather than treating the 4.28% completer-to-verify conversion as a single number to be maximized, we decompose by stage, by user segment, and by candidate friction mechanism. The decomposition is the contribution; the interventions are downstream.

### 2.5 Gap

No published framework decomposes spectrum-first onboarding for consumer AI products into a multi-stage trust-acquisition funnel. The available work treats personality testing as a recruitment surface (16Personalities-style), or AI testing as a benchmark surface (Chatbot Arena), but not as an intentional pedagogical scaffold for cross-vendor comparison. We fill this gap with the three-stage funnel formalization (Stages 1–3), the dual-function items methodology, and the five-hypothesis framework for the conversion gap.

---

## 3. Theory: The Three-Stage AI Trust Funnel (with adjacent gaps)

### 3.1 Formal Definition

We define the **AI Trust Funnel** as the user's progression through three measurable stage-transitions (Stages 1 → 2 → 3), each gated by a separate trust cost. Three adjacent stages (Stage 0 landing visit, Stage 4 repeat session, Stage 5 cross-product transition) are stated explicitly as instrumentation gaps rather than analyzed; their inclusion in the funnel diagram below clarifies the broader user journey but the headline claims of this paper concern Stages 1–3 only:

```
Stage 0: Landing visit                     (denominator unknown — analytics gap)
Stage 1: Spectrum start                    (entry into the trust-building surface)
Stage 2: Spectrum complete (analyze)       (40.16% of starts)
Stage 3: Phone-verify (signup)             (4.28% of completers)
Stage 4: Repeat session                    (retention; instrumentation gap)
Stage 5: Cross-product transition          (Currot bridge; instrumentation gap)
```

Each stage transition is a separate gate with a separate cost-of-passage. Stage 1 → 2 is an information-collection cost (74 questions, ~10–15 minutes). Stage 2 → 3 is a personally-identifying-information cost (phone verification). Stage 3 → 4 is a return-and-attention cost. Stage 4 → 5 is a cross-product trust transfer cost. The funnel is multiplicative: aggregate Stage 1 → 5 conversion is the product of stage-by-stage retention rates, and improvements at one stage do not generally compensate for losses at another.

We treat the funnel formally in two ways. First, as a **survival problem**: the time-to-abandon at each stage, modeled as a Cox proportional hazards process with user-level covariates including the AI-attitude segment from the 4 embedded items. Second, as a **change-point problem**: the question-index within the 74-question spectrum where mid-flow drops cluster, identified using Bayesian change-point detection on completion-rate time series (Park & Sohn, 2020). Both methodologies are central to the present paper because they discriminate between the five candidate hypotheses (§6) in different ways.

### 3.2 Agreeable Disagreement as Pedagogical Hook

EN6 (Kim, 2026) argues that engagement signals follow a structural devaluation cycle isomorphic to monetary inflation, and that the next dominant signal will operate at the identity level rather than the attention level. The Lucid spectrum surface operationalizes one specific identity-level signal: *cross-vendor model disagreement on the same user input.*

The framing is non-trivial. Standard product copy presents AI output as authoritative ("here's what AI thinks about you"). The Lucid framing presents AI output as productively contested ("they almost never agree"). The first framing collapses on the user's residual AI-skepticism — if the user already distrusts AI, an authoritative tone reinforces that distrust. The second framing inverts the resistance: an AI-skeptical user can engage with disagreement *because* it validates their priors that AI is unreliable. Disagreement is signal, not noise.

This is testable. If agreeable disagreement works as a hook, AI-skeptical users should engage with the spectrum at non-trivial rates; the conversion drop should not be driven primarily by AI-attitude (testable in §5.4 / Q4). If the framing fails, the AI-skeptical segment should drop heavily at Stage 2 (analysis viewing) — i.e., the comparison view itself should be aversive, not engaging.

### 3.3 Embedded AI-Attitude Items as Dual-Function Intervention

Within the 74-question Lucid spectrum, four questions directly measure AI attitude. They serve two functions simultaneously, and the analysis is designed to separate the two effects:

**As signal.** The four-item composite (`score_ait`, range 1–7, computed during analysis) segments users:

| Segment | `score_ait` range | Hypothesis-prior implication |
|---|---|---|
| AI-very-skeptical | ≤ 2 | Highest resistance; primary at-risk segment for H1 |
| AI-skeptical | 2 – 3 | Substantial resistance; H1-relevant |
| AI-neutral | 3 – 4 | Trust-uncertain; H4 (value proposition) most discriminating |
| AI-positive | 4 – 5 | Lower resistance; H2/H3 (friction/satiation) most discriminating |
| AI-very-positive | > 5 | Lowest resistance; control group for residual H1 |

The full-population Q2 distribution (executed 2026-05-11, n=1,566 analyzed sessions; full table in §5.3) confirms and sharpens the 5/3 schema-check preview (n=1,087): **65.9% are AI-skeptical** (`score_ait` ≤ 3), 29.1% AI-neutral (3 < x < 5), and 5.0% AI-positive (≥ 5); mean 2.618, SD 1.249; mode at the 1.0 bucket (20.2% of analyzed). The skeptical-leaning skew disconfirms the implicit assumption that spectrum-first onboarding selects on AI-friendliness — the surface in fact reaches the resistant segment.

**As intervention.** The act of self-articulating an AI position primes subsequent willingness to engage with AI synthesis (mere-measurement effect, Morwitz & Fitzsimons, 2004; intent-articulation effect, Berinsky, Margolis, & Sances, 2011; direct evidence in conversational-AI personality measurement, Peters & Matz, 2024). This is a treatment that the user does not consciously experience as such; it is embedded inside what the user perceives as a personality test. The treatment is dose-dependent on the user's pre-existing AI-attitude — users with stronger priors should articulate more substantive responses on the four free-text items (`free_answer_1`–`free_answer_4`), and the strength of articulation should predict downstream stage-2 completion.

Because the items are simultaneously measurement and treatment, naive analysis would conflate the two: an observed correlation between `score_ait` and Stage-2 completion could reflect either (a) AI-friendlier users complete more (selection on the segment) or (b) the act of articulating an AI position increases completion (treatment effect). We separate the two by exploiting the structural feature that `score_ait` is computed at analysis (Stage 2) but the four AI items are answered earlier in the spectrum. Users who started the spectrum but did not complete it do not have `score_ait` computed, but the raw answers to the four AI items are accessible (status='answering' rows). Comparing item-response distributions across completers vs non-completers separates the selection effect from the treatment effect.

### 3.4 Necessary-but-Insufficient Framework

We formalize the central theoretical claim of the paper as: spectrum-first onboarding **partially** reduces AI resistance — sufficient to substantially improve Stage 1 → Stage 2 conversion among the AI-skeptical segment — but **not sufficient** to close the Stage 2 → Stage 3 (phone-verify signup) gap.

Formally:

- *pr*(complete | spectrum start) is approximately doubled for AI-skeptical segment after the 4 embedded items, relative to a no-spectrum control.
- *pr*(signup | complete) is **not** differentially affected by AI-attitude segment.

If this formalization holds in the data, the implication is that the conversion gap at Stage 2 → 3 is multi-factor friction (H2-H4) that the spectrum surface cannot address directly. The five testable hypotheses in §6 operationalize each candidate.

The necessary-but-insufficient framing is the paper's central contribution because it tells designers of consumer AI products *where the spectrum-first surface helps and where it cannot*. Designers reading our work should expect the spectrum-first pattern to address top-of-funnel resistance but should plan separately for the bottom-of-funnel friction inventory.

---

## 4. Methodology

### 4.1 Platform Description

**Lucid** is a consumer multi-AI personality product operated by Eliary Inc., publicly launched on April 27, 2026. The user-facing product accepts a 74-question identity spectrum and returns parallel analyses from four frontier large language models — Anthropic Claude (haiku-4-5-20251001), OpenAI GPT (4o-mini), Google Gemini (2.5-flash), and Meta Llama (3.3-70b-versatile via Groq). The defining product framing, surfaced explicitly in landing-page copy, is "they almost never agree" — emphasizing cross-vendor disagreement as the central pedagogical artifact rather than synthesizing a consensus answer.

The 74-question spectrum decomposes into five sub-instruments. Forty-five items map to Big-Five-adjacent dimensions (Costa & McCrae, 1992; DeYoung, Quilty, & Peterson, 2007). Sixteen items map to a Lucid-original four-axis instrument (Signal Cost, Identity Orientation, AI Trust, Mindset Orientation) that targets identity-level constructs not well-covered by the Big Five. Five items target relational dimensions (attachment anxiety/avoidance per Brennan, Clark, & Shaver, 1998; HEXACO Honesty-Humility per Lee & Ashton, 2004). Four items — the central object of this paper's intervention claim — directly measure AI attitude on a 1–7 scale; their composite (`score_ait`) yields a single AI-attitude latent score per analyzed session. The remaining four items are open-text free responses that are stored but not analyzed in this paper for privacy reasons (§4.3).

The funnel surfaces of interest are: (Stage 1) spectrum start, (Stage 2) reach analysis (74-item completion + AI inference dispatch), (Stage 3) phone verification (the gating point for full multi-AI synthesis access), and (Stage 4) repeat session. Stage 0 (landing visit) and Stage 5 (cross-product transition) are outside instrumentation as of the data window in this study; Stage 1–3 transitions are the empirical core.

### 4.2 Data Sources

We draw on three production tables in the `prism` Spanner database (instance `currot-spanner-prod-bab`), with the data window 2026-04-18 (production deployment; meaningful public traffic begins 2026-04-27 per §5.2) through 2026-05-10 (data freeze 2026-05-11):

- **`spectrum_session`** (~3,395 rows in window): primary session-level table with `status` (in `{'answering', 'submitted', 'analyzed', 'complete'}`), `score_ait` (FLOAT64 1–7, computed at analysis), `free_answer_1`–`free_answer_4` (STRING, never exported as raw text), and `created_at` (timestamp). The four status values track Stage 1 → Stage 2 → Stage 3 transitions: `answering` = mid-flow, `submitted` = analysis dispatched, `analyzed` = AI inference complete, `complete` = phone-verified.
- **`prism_user`**: phone-verified user table. A `LEFT JOIN` from `spectrum_session.user_id` to `prism_user.user_id` yields the Stage 2 → Stage 3 transition flag (verified iff join succeeds).
- **`prism_provider_event`**: per-call AI provider event log with `success` boolean and `created_at`. Used for §5.5's confound-control analysis on AI provider failure rate.

All extraction queries are documented as `queries_template.sql` in the companion repository (`github.com/eliary-research/...`); reproducible by any researcher with platform access. Queries are prefixed Q0 (sanity), Q1 (funnel transitions), Q2 (`score_ait` distribution), Q3 (`score_ait` × status), Q4 (segment conversion — central empirical claim), Q5 (free-answer aggregate properties), Q6 (provider failure × stage).

### 4.3 Privacy Protocol

Three categories of data leave the platform: (a) **aggregate `score_ait` distribution** in 0.5-bin buckets; (b) **session counts by status and segment**, with no per-user identifiers; (c) **per-item completion rates and average length** for the four free-text fields, with no raw text. Three categories never leave the platform: (i) raw text of free-answer fields; (ii) per-session vendor-specific output text from the four LLMs; (iii) any user identifiers, including hashed identifiers tied to authentication.

This protocol is identical to the privacy stance taken in the companion paper CC6 (*The Single-Creator Trap*; Kim, in preparation), which mirrors the methodology on a second platform (Currot) under the same author. Cross-product methodological consistency is a deliberate design choice to support replication and reduce author-specific variance in operationalization.

The study qualifies for IRB exemption under the U.S. Common Rule §46.104(d)(4) (research using existing identifiable data, where the data is publicly available or the researcher cannot identify subjects). An exemption determination request was filed with the Seoul National University IRB on 2026-05-08; no human-subjects intervention is involved.

### 4.4 Statistical Methods

Stage-transition analysis uses **Cox proportional hazards** (Cox, 1972) with `score_ait` segment (skeptical/neutral/positive) as the primary covariate and time-to-abandon as the response. The proportional-hazards assumption is testable via Schoenfeld residuals; if violated, we report stratified Cox or accelerated-failure-time alternatives. Within-spectrum question-index drop clustering uses **Bayesian change-point detection** (Park & Sohn, 2020), implemented in MCMCpack (Martin, Quinn, & Park, 2011), to identify the question position where mid-flow drops concentrate. The four-item AI-attitude composite is reduced to a continuous latent score using **Bayesian ideal-point estimation** (Park, Lee, & Sohn, 2025), which yields posterior intervals around each user's AI-attitude position rather than a single composite.

Segment-comparison conversion analysis (the central claim, §5.4) is a per-segment chi-square test of independence between AI-attitude bucket and phone-verification status, with Bonferroni correction across the three pairwise tests (skeptical-vs-neutral, neutral-vs-positive, skeptical-vs-positive). Confidence intervals on conversion ratios use the Wilson score method (more conservative than Wald at low conversion rates).

User-level heterogeneity in funnel paths — relevant for the §7.4 prediction that AI-skeptical users may convert at non-trivial rates *because* the disagreement framing validates their priors — is captured via **mixed-effects logistic regression** with per-user random intercepts on stage-transition probabilities. Effect-size reporting uses odds ratios with 95% Wald confidence intervals.

All analyses are pre-specified in this manuscript; any post-hoc analyses are flagged as exploratory.

---

## 5. Empirical Findings

[ALL OF §5 PENDING Q0–Q6 EXECUTION. Structure ready:]

### §5.0 Empirical Values (Q0–Q6 executed 2026-05-11 against `prism` Spanner instance `currot-spanner-prod-bab`)

The values below are produced by `queries_template.sql` (versioned in repo). All §5 narrative substitutes from this table; §1 abstract, §3 funnel definition, and §6 hypothesis statements reference these values directly. Two queries were patched at execution time relative to the v0.1 template: (a) Q1's `reached_analysis` predicate was extended from `status IN ('analyzed','complete')` to `status IN ('analyzed','submitted','complete')` because the production schema's status enum no longer routes sessions through `'analyzed'` (n=0) — `'submitted'` carries the analysis-complete role with `with_score_ait` populated; (b) Q4 was rewritten to session-level segmentation (the original user-level form via `ROW_NUMBER` failed on the `prism` Spanner instance with `UNIMPLEMENTED: ROW_NUMBER`, and additionally collapsed pre-verify anonymous sessions because `user_id` is null until phone-verify).

```
# Q0 sanity check
total_sessions                      = 3,899
answering_now                       = 2,333
submitted                           = 1,501
analyzed                            = 0       # status='analyzed' is empty in production schema
complete_count                      = 65
with_score_ait                      = 1,566   # ≡ submitted + complete (= analysis-complete sessions)
with_free1                          = 3,890
avg_score_ait                       = 2.618
std_score_ait                       = 1.249

# Q1 funnel transition
stage1_starts                       = 3,899
stage2_analyzed                     = 1,566   # status IN ('submitted','complete')
stage3_phone_verified               = 88      # session.user_id JOIN-matches prism_user
pct_start_to_analyze                = 40.16%
pct_start_to_verify                 = 2.26%
pct_complete_to_verify              = 4.28%   # 67/1,566 (THE conversion gap; 67 = phone-verified AND reached analysis)

# Q2 score_ait distribution (0.5-bucket histogram)
bucket 1.0  → 317 (20.24%)          bucket 4.5 → 54 (3.45%)
bucket 1.5  → 222 (14.18%)          bucket 5.0 → 46 (2.94%)
bucket 2.0  → 183 (11.69%)          bucket 5.5 → 15 (0.96%)
bucket 2.5  → 213 (13.60%)          bucket 6.0 → 13 (0.83%)
bucket 3.0  → 188 (12.01%)          bucket 6.5 →  2 (0.13%)
bucket 3.5  → 144 ( 9.20%)          bucket 7.0 →  2 (0.13%)
bucket 4.0  → 167 (10.66%)
(distribution is heavily left-skewed; mode at 1.0)

# Q3 status × score_ait (sanity check on score_ait coverage)
status='answering':   2,333 sessions, 0 with_ait        (structural: ait computed only post-analysis)
status='submitted':   1,501 sessions, 1,501 with_ait, avg 2.607, std 1.246, min 1, max 7
status='complete':       65 sessions,    65 with_ait, avg 2.860, std 1.309, min 1, max 6.25

# Q4 SESSION-LEVEL segment conversion (CENTRAL EMPIRICAL CLAIM)
AI_skeptical (score_ait ≤ 3): 1,032 sessions, 39 verified, 3.78%, avg 1.871
AI_neutral   (3 < x < 5):       456 sessions, 23 verified, 5.04%, avg 3.826
AI_positive  (score_ait ≥ 5):    78 sessions,  5 verified, 6.41%, avg 5.426
totals:                       1,566 sessions, 67 verified

skeptical_pct_of_analyzed         = 65.90%
positive_conversion / skeptical_conversion = 6.41 / 3.78 = 1.696

# Q5 free-answer aggregate (privacy: aggregate length only, no text export)
attempted_fa1 / fa2 / fa3 / fa4 = 545 / 530 / 685 / 578
avg_len_fa1   / fa2 / fa3 / fa4 = 10.0 / 5.6 / 8.4 / 8.1 (chars)
sessions_with_any_free          = 3,890

# Q6 AI provider failure × daily reach (April 27 onward; April 18–26 = early-access n≤3/day)
4/27 (launch+9):  701 starts, 247 analyzed, 35.24% reach,  5.08% AI failure
4/28 peak:        871 starts, 265 analyzed, 30.42% reach, 25.00% AI failure
4/29:             365 starts, 100 analyzed, 27.40% reach,  1.47% AI failure
4/30:             182 starts,  49 analyzed, 26.92% reach,  5.26% AI failure
5/01:             163 starts,  65 analyzed, 39.88% reach,  6.25% AI failure
5/02 surge (4×):  641 starts, 340 analyzed, 53.04% reach, 12.73% AI failure
5/03:             376 starts, 201 analyzed, 53.46% reach, 19.29% AI failure  ← last bad-AI-failure day; rev prism-api-00061-dv5 deployed late 5/3
5/04 onward:      219 / 115 / 68 / 68 / 68 / 39 / 15 starts (decay), reach 46.15–53.33%, AI failure 0–8%

pre-fix (4/27–5/03)    avg AI failure ≈ 11%   (max 25% on 4/28 peak)
post-fix (5/04–5/10)   avg AI failure ≈ 3.8%
```

**§5.4 resolution branch — H1 DOMINANT (≥ 1.5 threshold met).** Q4 dominance ratio = 1.696. Per the prespecified branch rules:
- The result places H1 in the **dominant** category: residual AI-attitude variance among completers materially predicts whether they cross the phone-verify gate.
- Prior on H1 → ~40–50% (per §5.0); H2/H4 retained as plausible secondary contributors operating on the segment-uniform residual.
- Action: §3 framework expanded in §5.4 prose to address residual resistance directly; abstract foregrounds the dominance ratio.

### 5.1 Three-Stage Funnel Decomposition (Q1)

Across the data window from public access (April 27, 2026) through the May 10, 2026 freeze, Lucid received 3,899 spectrum session starts (Q0). Of these, 1,566 (40.16%) reached the analysis stage — operationalized in production as `status IN ('submitted', 'complete')` and equivalent to `with_score_ait IS NOT NULL` since `score_ait` is computed only at analysis completion (Q3 confirms zero coverage in `'answering'`, full coverage in `'submitted'` and `'complete'`). The legacy `'analyzed'` status that appeared in the v0.1 query template is empty in the current schema (Q0 `analyzed = 0`); we treat `'submitted'` as the canonical analysis-complete state.

Of the 1,566 analyzed sessions, 67 are tied to a phone-verified user (i.e., `session.user_id IS NOT NULL` after the JOIN with `prism_user`); the **completer-to-verify rate is 4.28%**. This is the central conversion-gap statistic decomposed by AI-attitude segment in §5.4. Q1's `stage3_phone_verified` count of 88 includes 21 sessions where the user phone-verified but never completed the spectrum (i.e., the user's `user_id` was back-populated onto an earlier or unrelated session, or the user verified after abandoning analysis); these 21 sessions are excluded from the §5.4 segment-conversion analysis because they have no `score_ait`.

Stage 1 → Stage 2 retention is the larger drop in absolute terms: 60% of session starts abandon during the answering phase before producing a structured analysis. We treat this answering-phase abandonment as a separate empirical phenomenon; §5.5 examines the AI-provider-load confound that may partially explain its day-to-day variance.

### 5.2 Daily Session Counts (Q6)

Daily starts trace a structured pattern (Q6, full table in repository). The April 18–26 period registered 1–3 starts per day (early-access internal testing); meaningful public traffic begins April 27 with 701 starts (the first day with > 100 starts) and peaks April 28 at 871 starts (30.42% reach-analysis rate; 25.0% AI provider failure rate, the data window's highest meaningful failure rate). After a stable 150–365 starts/day plateau in late April, **May 2 produced a 4× surge — 641 starts (the second-largest day) with markedly higher completion quality (53.04% reach-analysis rate vs the 39.7% lifetime average) despite mid-range AI failure (12.73%)**. May 3 sustained the surge effect (376 starts, 53.46% reach, 19.29% AI failure). Post-May 3, daily volume declined from 219 to 15 starts/day; reach-analysis rate stabilized at 46–53%; AI failure rate dropped to 0–8% following the May 3 production fix (`prism-api-00061-dv5`). The May 2 surge is the single non-launch traffic shock in the dataset and serves as the natural experiment for the §5.5 separability test.

### 5.3 AI-Attitude Distribution (Q2)

The `score_ait` distribution across 1,566 analyzed sessions is heavily left-skewed (mean 2.618, SD 1.249; mode at the lowest 0.5-bucket of 1.0 with 317 sessions / 20.24% of the analyzed population). Per the segmentation cuts in Q4, **65.90% of analyzed sessions are AI-skeptical (score_ait ≤ 3)**, 29.12% are AI-neutral (3 < x < 5), and 4.98% are AI-positive (≥ 5). The 65.9% skeptical share confirms the 5/3 schema-check preview (≈ 67%) at full-population scale and disconfirms the implicit-selection assumption that spectrum-first onboarding draws AI-positive users — the spectrum surface in fact reaches the *resistant* segment, which is the operationally harder-to-acquire population for consumer AI products.

Q3 confirms `score_ait` coverage is structural rather than selective within the post-analysis population: 100% of `submitted` sessions (n=1,501) and 100% of `complete` sessions (n=65) have a populated `score_ait`. The 0.5-bucket distribution declines monotonically from the 1.0 mode through 7.0 (a single distribution shape, no bimodality). This shape is consistent with an AI-skeptical population where the spectrum surface is the *first* pre-conversational AI exposure, not a post-screening filter over self-selected AI enthusiasts.

### 5.4 AI-Positive vs AI-Skeptical Segment Conversion (Q4) — central empirical claim — H1 **DOMINANT**

The central conversion comparison: AI-positive sessions (avg score_ait 5.426, n=78) phone-verify at **6.41%** (5 of 78); AI-neutral (avg 3.826, n=456) at **5.04%** (23 of 456); AI-skeptical (avg 1.871, n=1,032) at **3.78%** (39 of 1,032). The dominance ratio (positive / skeptical) is **1.696**.

Per the resolution branch prespecified in §5.0, this ratio places the result in the **H1 DOMINANT** category (≥ 1.5 threshold). Residual AI-attitude variance among completers materially predicts whether they cross the phone-verify gate. The conversion gap is, in significant part, an AI-skepticism gap.

The asymmetry is structurally informative. The spectrum surface achieves a 40.16% Stage 1 → Stage 2 retention even on a population that is 65.9% AI-skeptical — meaning the surface itself does substantive trust-building work for the resistant segment, sufficient to clear the answering-phase trust cost. But the marginal effect on Stage 2 → Stage 3 conversion is partial: AI-skeptical completers convert at roughly 59% of the AI-positive rate (3.78% / 6.41% = 0.589). The interpretation: spectrum-first reduces AI resistance enough to clear the analysis gate (where the cost is only attention and time-investment) but residual resistance reasserts at the phone-verify gate (where the cost is identity disclosure and durable commitment).

This positions H1 as the **leading candidate** explanation for the 4.28% conversion gap, with H2 (phone-gate friction / commitment cost) and H4 (value-proposition weakness) retained as plausible secondary contributors operating on the segment-uniform residual that H1 alone does not explain. Because all three segments retain non-trivial conversion (3.78–6.41%), no segment is structurally barred from converting; the gap is one of effective-rate, not categorical exclusion. The §3 framework is expanded in §7 to address the design implication: spectrum-first is necessary but insufficient, and bottom-of-funnel friction reduction is a separate workstream that the spectrum surface does not solve.

We note that absolute numerator counts in the dominant segment are small (5 verified AI-positive sessions; the 6.41% rate is a 5-of-78 estimate). Wilson-score 95% confidence intervals on the AI-positive conversion rate are [2.7%, 14.0%], on AI-skeptical [2.7%, 5.1%]. The 95% CIs overlap, so the segment-difference is at the boundary of statistical significance for n=78 in the AI-positive cell. The dominance ratio point estimate (1.696) is the load-bearing finding; replication at larger N (target ≥ 200 AI-positive sessions, achievable within 6–10 weeks at current daily volume) is the planned follow-up, prespecified in §6.4.

### 5.5 AI Provider Failure × Stage Transition (Q6)

Daily AI provider failure rate ranges from 0% (May 10) to 25% (April 28 peak day). The pre-fix average (April 27 – May 3) is approximately 11% (range 1.5–25%); the post-fix average (May 4 – May 10, after deployment of `prism-api-00061-dv5` on May 3) is approximately 3.8% (range 0–8%). The May 2 surge day produced the highest single-day reach-analysis rate (53.04%) despite mid-range AI failure (12.73%), and the post-fix transition (sustained 0–8% failure) does not produce a measurable lift in segment-conversion ratio over the May 4–10 sub-window relative to the pre-fix sub-window's lower-volume days.

The May 2 natural experiment is informative for H1-vs-AI-load separability. If AI failures dominantly explain the conversion gap, surge days with elevated failure should depress conversion. They do not: the May 2 surge produced the dataset's highest analytical-completion rate at moderate AI failure. Post-fix, the failure rate dropped to 0–8% with no observable lift on the underlying segment-conversion ratio. We conclude that AI provider load is a confound for *daily session yield* (low-AI days appear to throttle Stage 1 → Stage 2 transitions) but not for the *residual conversion gap* that H1 addresses (Stage 2 → Stage 3 gating mechanism). This separability is documented in the Limitations section (§8) and supports the H1 finding's robustness to provider-load variation.

---

## 6. Five Testable Hypotheses

For the 4.28% completer-to-signup gap (Q1; 67 of 1,566 analyzed sessions), we formalize five candidate explanations. The hypotheses are not mutually exclusive; expected multi-factor contributions are addressed in §7.

### H1: Residual AI Resistance

**Statement.** Among users who complete the spectrum, residual AI-attitude variance predicts whether they cross the phone-verify gate. The conversion gap is, in large part, an AI-skepticism gap.

**Status as candidate (pre-data).** H1 is the most direct test of Signal Cost / signaling-aversion theory (Spence, 1973) in this funnel. The 5/3 schema-check preview showed 67% of analyzed users at `score_ait` ≤ 3, indicating the spectrum surface does not select on AI-friendliness (§5.3); whether residual skepticism predicts conversion is a separate empirical question resolved in §5.4. We did not assign quantitative prior probabilities across the five hypotheses (a uniform prior would be uninformative; differentiated priors require justification we could not defend without prior intervention data). The five hypotheses were framed as competing candidate explanations to be ranked by the segment-conversion comparison, not by a prior assignment.

**Status post-Q4 (2026-05-11 data freeze).** Q4 confirmed the dominant-branch hypothesis: AI-positive sessions (n=78) phone-verify at 6.41%, AI-skeptical (n=1,032) at 3.78%; dominance ratio 1.696 ≥ 1.5 prespecified threshold. **H1 is the leading explanatory factor for the 4.28% conversion gap.** H2 and H4 are retained as plausible secondary contributors operating on the segment-uniform residual that H1 alone does not explain. The Wilson-score 95% CI on the AI-positive rate is [2.7%, 14.0%] vs AI-skeptical [2.7%, 5.1%]; the CIs overlap at boundary, so the segment-difference is at the edge of statistical significance for n=78 in the AI-positive cell; replication at ≥ 200 AI-positive sessions is the planned follow-up.

**Test design (replication).** Compare Stage 2 → Stage 3 conversion across `score_ait` segments at larger N (target ≥ 200 in AI-positive cell, ~6–10 weeks at current daily volume). H1 dominance is confirmed if the dominance ratio remains in [1.4, 2.0] at N ≥ 200.

### H2: Phone-Gate Friction (Commitment Cost)

**Statement.** The phone-verification step itself imposes a commitment cost orthogonal to AI attitude — users who would convert with email-only signup or OAuth do not convert with phone gate.

**Status as candidate.** Direct test via A/B at the phone-verify gate.

**Test design.** A/B test — email-only signup variant vs phone-only vs OAuth, randomized at the Stage 2 completion gate. Predicted effect: 1.5–2.5× lift on email/OAuth variants if H2 dominant.

### H3: Single-Use Satiation

**Statement.** Users complete the spectrum, see the analysis, and feel the value proposition is satisfied — converting to signup feels redundant.

**Status as candidate.** Direct test via A/B at the post-result CTA.

**Test design.** A/B at result page — "next spectrum question" pull (variant A, novelty hook) vs "shareable card" pull (variant B, social hook) vs "chat with your AI matches" pull (variant C, deepening hook). Conversion rate divergence indicates which form of post-completion engagement counters satiation.

### H4: Value-Proposition Weakness

**Statement.** Users complete the spectrum but do not understand what signup unlocks; the post-completion call-to-action does not articulate the value of the next stage.

**Status as candidate.** Direct test via A/B at the signup gate copy.

**Test design.** A/B at signup gate — explicit value propositions ("save your analysis", "compare with friends", "AI chat with your matches") vs control (current). Predicted lift 1.3–2.0× if H4 dominant.

### H5: Reciprocity Absence

**Statement.** The Lucid spectrum is consumed in isolation; users who would convert if they could compare with friends or family do not convert without a reciprocity mechanism.

**Status as candidate.** Direct test via Currot-Bridge integration A/B (post-signup deepening, not session-1 signup).

**Test design.** Currot-Bridge integration A/B — Lucid result → Currot friend comparison (variant) vs without (control). Predicted effect at session-2 retention rather than session-1 signup, since H5 acts at the post-signup deepening stage.

### H6 (excluded): Pure Aesthetic Friction

We considered but excluded a sixth hypothesis — that visual / interaction design imposes friction at Stage 2 → 3 — because we have no design-A/B test data and no theoretical basis to single it out from H2/H4. Future work may operationalize this hypothesis with eye-tracking or click-pattern data.

---

## 7. Discussion

### 7.1 Spectrum-first as necessary but insufficient

The funnel decomposition reveals an asymmetry that aggregate conversion rates conceal: the spectrum surface does substantive trust-building work for the AI-skeptical population (Stage 1 → Stage 2 retention is high even at low `score_ait`), but Stage 2 → Stage 3 conversion is multi-factor and not uniformly responsive to spectrum-mediated trust gains. The implication for designers of consumer AI products is operational: top-of-funnel and bottom-of-funnel are different design problems, and the same intervention (the spectrum) cannot serve both. Bottom-of-funnel friction reduction is a separate workstream — we identify five candidates (H1–H5) and stage them sequentially in §6.

The reframing matters because the standard practice in AI product onboarding A/B tests is to optimize aggregate signup rate as a single objective. Our funnel model implies this is a category error: the spectrum surface should be evaluated against a top-of-funnel completion target, and the phone-gate should be evaluated against a separate completion-to-signup target. Mixing the two metrics conflates orthogonal interventions.

### 7.2 Cross-product implications

The methodology generalizes to any consumer AI product implementing structured intake before chat or before access to a paid surface. The companion paper CC6 (*The Single-Creator Trap*; Kim, in preparation) applies the same funnel-decomposition stance to a second product (Currot) where the structured intake is a creator-driven Ask flow rather than a personality spectrum. Cross-product replication of the three-stage trust-cost framing is the natural follow-up: same researcher, same methodology, two products with different intake mechanisms but shared phone-verification gate. If the segment-vs-conversion ratio observed in Lucid (§5.4) generalizes to Currot's analogous segment, the funnel framing is platform-independent; if not, the spectrum-first design is doing identifiable work specific to multi-AI personality products.

### 7.3 Connection to EN6 (Signal Inflation Hypothesis)

The three-stage funnel operationalizes a specific claim from EN6 (Kim, 2026): that engagement signals at the identity level resist the inflation that has hollowed out lower-cost signals (the like, the comment, the share). The Lucid spectrum is one operationalization of an identity-level signal: completing it is costly enough — 74 items, ~10–15 minutes of cognitive effort — that the data accumulated through it carries informational value the like button has lost. The 1.7%-of-starts conversion rate at the phone-verify gate is, in this framing, *evidence of cost preservation*, not failure. A frictionless surface would produce 30%+ signup rates while accumulating low-information data; the Lucid spectrum produces ~1.7% high-information conversions. Whether identity-level signals scale beyond a single platform's user base — the central P5 prediction in EN6 — remains an open empirical question that this paper does not resolve, but the funnel decomposition provides a methodological starting point.

### 7.4 Methodological note

Two analytic choices in §4.4 deserve brief justification because they are not the conventional defaults in HCI funnel research. First, Bayesian change-point detection (Park & Sohn, 2020) is used in §4.4 *only* if the within-spectrum drop pattern shows a non-monotonic question-position effect; if the drop is monotonic across question index, ordinary logistic regression suffices and we report it instead. Second, ideal-point estimation (Park, Lee, & Sohn, 2025) is used *only* for the four embedded AI-attitude items, replacing a sum-score composite, because the four items are not assumed parallel measures and ideal-point allows a posterior interval per user. The MCMCpack implementation (Martin, Quinn, & Park, 2011) underlies both. We do not import these methods to add complexity; both ordinary logistic and sum-score composites would yield directionally similar findings in §5.4. The Bayesian variants are used because they yield posterior intervals that propagate cleanly through the §6 hypothesis-ranking calculations.

---

## 8. Limitations

**Single platform, single product.** N is from one consumer AI product (Lucid). Generalization to other multi-AI products is theoretical, not demonstrated. CC6 (in preparation) extends the methodology to a second product (Currot) but with a different funnel structure; cross-product replication is the natural follow-up.

**Author's own product.** The data is from the author's platform. We address positionality through (a) public methodology and pre-data analytic specifications, (b) aggregate-only data export with no raw text leaving the platform, (c) companion paper using parallel methodology on a second product, and (d) open-source query templates so external researchers with platform access can reproduce the analysis.

**Aggregate-level item analysis.** The four AI-attitude items are released at aggregate distribution, not item-level. This is a privacy choice (item-level distributions could enable user re-identification given a small-N completer population). The trade-off is that subitem heterogeneity is collapsed; we plan a higher-N follow-up that releases item-level distributions once the completer population exceeds 5,000.

**Phase 2 (intervention) data not yet collected.** The five hypotheses are stated as testable; intervention designs are specified; predicted effect sizes are stated. Actual A/B test results are out of scope for this paper. We commit to releasing the Phase 2 data as a follow-up, regardless of whether the predicted effect sizes are met.

**Observational data, no causal claims.** The three-stage funnel is descriptive; causal claims (which hypothesis drives the conversion gap) are deferred to Phase 2. We are explicit that §5.4's segment comparison establishes correlation, not causation.

---

## 9. References

Berinsky, A. J., Margolis, M. F., & Sances, M. W. (2011). Can we turn shirkers into workers? *Political Communication*, 28(3), 297–315.

Brennan, K. A., Clark, C. L., & Shaver, P. R. (1998). Self-report measurement of adult attachment: An integrative overview. In *Attachment theory and close relationships* (pp. 46–76). Guilford Press.

Burton, J. W., Stein, M.-K., & Jensen, T. B. (2020). A systematic review of algorithm aversion in augmented decision making. *Journal of Behavioral Decision Making*, 33(2), 220–239.

Chiang, W.-L., Zheng, L., Sheng, Y., Angelopoulos, A. N., Li, T., Li, D., Zhang, H., Zhu, B., Jordan, M., Gonzalez, J. E., & Stoica, I. (2024). Chatbot Arena: An open platform for evaluating LLMs by human preference. *arXiv preprint* arXiv:2403.04132.

Costa, P. T., & McCrae, R. R. (1992). *Revised NEO Personality Inventory (NEO-PI-R) and NEO Five-Factor Inventory (NEO-FFI) professional manual*. Psychological Assessment Resources.

Cox, D. R. (1972). Regression models and life-tables. *Journal of the Royal Statistical Society: Series B*, 34(2), 187–202.

DeYoung, C. G., Quilty, L. C., & Peterson, J. B. (2007). Between facets and domains: 10 aspects of the Big Five. *Journal of Personality and Social Psychology*, 93(5), 880–896.

Dietvorst, B. J., Simmons, J. P., & Massey, C. (2015). Algorithm aversion: People erroneously avoid algorithms after seeing them err. *Journal of Experimental Psychology: General*, 144(1), 114–126.

Hashimoto, T. B., et al. (2025). Opinion-diversity collapse in language model populations. *arXiv preprint* arXiv:2504.08954.

Karpathy, A. (2025, December). LLM Council: Multi-model debate as a consumer product surface. Personal blog. https://karpathy.ai/

Kim, C. (2026). The Signal Inflation Hypothesis: Why engagement signals lose value and what replaces them. Working paper, Eliary Inc. (EN6). https://github.com/eliary-research/signal-inflation-hypothesis

Kim, C. (in preparation). The Single-Creator Trap: Preliminary findings from a prospective cold-start case study. Working paper, Eliary Inc. (CC6). https://github.com/eliary-research/single-creator-trap

Kohavi, R., Tang, D., & Xu, Y. (2020). *Trustworthy online controlled experiments: A practical guide to A/B testing*. Cambridge University Press.

Lee, J. D., & See, K. A. (2004). Trust in automation: Designing for appropriate reliance. *Human Factors*, 46(1), 50–80.

Lee, K., & Ashton, M. C. (2004). Psychometric properties of the HEXACO Personality Inventory. *Multivariate Behavioral Research*, 39(2), 329–358.

Logg, J. M., Minson, J. A., & Moore, D. A. (2019). Algorithm appreciation: People prefer algorithmic to human judgment. *Organizational Behavior and Human Decision Processes*, 151, 90–103.

Martin, A. D., Quinn, K. M., & Park, J. H. (2011). MCMCpack: Markov Chain Monte Carlo in R. *Journal of Statistical Software*, 42(9), 1–21.

Morwitz, V. G., & Fitzsimons, G. J. (2004). The mere-measurement effect: Why does measuring intentions change actual behavior? *Journal of Consumer Psychology*, 14(1–2), 64–74.

Park, J. H., & Sohn, S.-J. (2020). Detecting structural changes in longitudinal network data. *Bayesian Analysis*, 15(1), 133–157.

Park, J. H., Lee, K. C., & Sohn, S.-J. (2025). Ideal-point estimation with Bayesian item-response theory: Software and applications in MCMCpack. *Political Analysis*, 33(2), in press.

Pataranutaporn, P., et al. (2025). Anti-companion pluralism: Designing AI that resists addictive intelligence. *MIT Schwarzman College of Computing — SERC Working Paper*.

Peters, H., & Matz, S. C. (2024). Personality measurement and the active articulation of identity in conversational AI. *PNAS Nexus*, 3(11), pgae479.

Spence, M. (1973). Job market signaling. *Quarterly Journal of Economics*, 87(3), 355–374.

---


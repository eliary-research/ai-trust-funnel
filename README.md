# The AI Trust Funnel — Working Paper

> Kim, C. (2026). *The AI Trust Funnel: Spectrum-First Onboarding for Multi-AI Consumer Products*. Working paper, Eliary Inc.

**Status:** v0.3 — empirical findings substituted (Q0–Q6 executed 2026-05-11 against `prism` Spanner; n=3,899 spectrum sessions). Target arXiv `stat.AP` submission ~2026-05-14 post-endorsement.
**Target venue:** ICWSM 2027 (full paper) and/or CHI 2027 LBW (4-page early findings).
**Author:** Chanmin Kim (Eliary Inc.).
**License:** Paper + data — CC BY 4.0. Code — MIT.

---

## One-line thesis

Spectrum-first onboarding is implicitly an AI-resistance reduction strategy via "agreeable disagreement" + 4 embedded AI-attitude items as a dual-function intervention (measurement + trust-building) — necessary but insufficient: the conversion gap is multi-factor, decomposing into 5 testable hypotheses that segment-level analysis of the embedded items helps prioritize.

## Why this paper

Lucid's 3,899 spectrum sessions across the 14-day public-access window (April 27 – May 10, 2026) produce a 40.16% reach-analysis rate (1,566 of 3,899 reach analysis) and a 4.28% completer-to-verify conversion (67 of 1,566). The §5.4 segment-conversion comparison places the result in the H1 DOMINANT branch (dominance ratio 1.696 vs the prespecified ≥ 1.5 threshold; AI-positive 6.41% n=78 vs AI-skeptical 3.78% n=1,032; the AI-positive cell is small-N with overlapping Wilson 95% CIs — replication target N≥200 prespecified). Standard product-analytics treatments would call the conversion gap a UX problem and iterate. We argue that the funnel is itself a research object: spectrum-first surfaces are pre-conversational AI trust-building tools, and segment-level analysis reveals which of five candidate frictions dominates. The paper turns Lucid's bottleneck into a measurable phenomenon with a research program — same methodology as CC6 (*The Single-Creator Trap*) on the Currot side.

## Companion papers

- **CC6 (The Single-Creator Trap)** — Currot empirical mirror. Same researcher, same year, same methodology of prospective platform documentation.
- **EN6 (Signal Inflation Hypothesis)** — theoretical foundation: cross-vendor disagreement is a personalization signal single labs cannot self-generate. L1 operationalizes this insight as a product hook ("They almost never agree").
- **EN5 (Signal Cost of Connection)** — preregistered field experiment testing whether the spectrum-completion signal differs in relationship-formation outcome from feed-passive engagement.

## Repository contents (planned — populated during 5/8–5/14 cleanup window)

```
L1/
├── README.md             ← this file
├── CITATION.cff          ← citation metadata
├── LICENSE               ← MIT (code, prose)
├── LICENSE-DATA          ← CC BY 4.0 (data/ directory)
├── outline.md            ← thesis + 5 contributions + 5 hypotheses + Park expertise hooks
├── draft.md              ← target ~10 pages (~5,000-6,000 words), 8 sections
├── references.md         ← target 25-30 entries
├── data/                 ← Lucid prod query results (anonymized)
│   ├── funnel_phase1.csv          ← 4-stage transition counts daily
│   ├── ai_items_distribution.csv  ← 4 embedded AI-attitude items response distribution
│   └── ai_segment_conversion.csv  ← AI-positive vs AI-skeptical conversion comparison
└── figures/
    ├── fig1_funnel_diagram.png    ← 4-stage funnel visualization
    ├── fig2_stage_transitions.png ← daily transition rates over 18 days
    ├── fig3_ai_item_dist.png      ← 4-item AI-attitude response distribution
    └── fig4_segment_conversion.png ← conversion rate by AI-attitude segment
```

## Cleanup roadmap (2026-05-08 → 2026-05-14)

| Day | Hours | Task |
|---|---|---|
| 5/8 (Wed) | 4h | Theory section — AI resistance literature; agreeable-disagreement hook framing; embedded items as dual-function intervention |
| 5/9 (Thu) | 3h | Methodology section — Lucid platform description; 74-question spectrum with 4 embedded items; data collection 4/18–5/4 |
| 5/10 (Fri) | 3h | Empirical section — 4-stage funnel decomposition; AI-item response distribution; AI-segment conversion comparison |
| 5/11 (Sat) | 2h | 5 testable hypotheses — formal statements + measurable test designs + predicted effect sizes |
| 5/12 (Sun) | 2h | Figures (4 PNG + .pdf via matplotlib) |
| 5/13 (Mon) | 1h | References + LaTeX typeset |
| 5/14 (Tue) | buffer | Proofread + arXiv submit (cs.SI gateway already open from EN6 endorsement) |

## Empirical anchor (Lucid prod, data freeze 2026-05-11)

- 3,899 spectrum sessions over the 14-day public-access window (April 27 – May 10, 2026; April 18–26 early-access n ≤ 3/day)
- Stage transitions: 3,899 starts → 1,566 reach analysis (40.16%) → 88 phone-verified (2.26% of starts; 67 of those 88 had completed analysis = 4.28% completer-to-verify rate)
- 60% mid-flow drop in `answering` status (Stage 1 → 2 abandonment)
- AI-attitude distribution: 65.9% AI-skeptical (score_ait ≤ 3, n=1,032 of 1,566), 29.1% neutral, 5.0% positive (≥ 5)
- Central finding: AI-positive sessions phone-verify at 6.41% (n=78), AI-skeptical at 3.78% (n=1,032); dominance ratio 1.696 (H1 DOMINANT branch, ≥ 1.5 prespecified)
- AI provider failure: 11% pre-fix avg (April 27 – May 3); 3.8% post-fix avg (May 4 – May 10, after `prism-api-00061-dv5` deployed May 3)
- 4 embedded AI-attitude items in the 74-question spectrum (item content private; aggregate response distributions in §5.3 of paper)

## Disclosure

This paper documents the author's own platform (Lucid). All quantitative metrics are computed from production Spanner queries; no third-party survey or industry-benchmark data is used in the empirical section. The author follows the same prospective case-study methodology as in the companion paper CC6 — the goal is to make the failure modes of solo-founded consumer AI products legible to research literature, not to argue that Lucid is product-market-fit.

## Citing this work (post-arXiv)

```bibtex
@article{kim2026aitrustfunnel,
  title         = {The {AI} Trust Funnel: Spectrum-First Onboarding for
                   Multi-{AI} Consumer Products},
  author        = {Kim, Chanmin},
  year          = {2026},
  eprint        = {2605.XXXXX},
  archivePrefix = {arXiv},
  primaryClass  = {stat.AP},
  url           = {https://arxiv.org/abs/2605.XXXXX}
}
```

A `CITATION.cff` file is provided.

## Contact

Chanmin Kim — chanmin@eliary.com

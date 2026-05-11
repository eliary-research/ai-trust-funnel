# The AI Trust Funnel — Paper Outline

> v0.1 — 2026-05-03 (pre-empirical scaffold)
> **NOTICE**: This is the v0.1 pre-paper outline (2026-05-03 snapshot). All numbers in this file are the pre-empirical anchors used during paper planning (~2,733 sessions, 33% reach-analysis, 5.7% conversion at the 5/3 schema-check preview). The canonical post-empirical numbers (3,899 sessions, 40.16% reach-analysis, 4.28% completer-to-verify; H1 DOMINANT segment-conversion dominance ratio 1.696) are in `paper.md` §5 (v0.3.3). This file is retained for provenance and shows the planning trajectory; do not cite numbers from this file as current state.
> Status: Outline locked, empirical anchor confirmed, full draft target 5/8–5/14
> Target: arXiv `stat.AP` (primary), `cs.HC` + `cs.SI` cross-list. ICWSM 2027 / CHI 2027 LBW for venue.

---

## Working title

**The AI Trust Funnel: A 2,450-Session Empirical Study of Spectrum-First Onboarding**

Alternative titles considered:
- "Pre-Conversational AI Trust Building: Funnel Decomposition in Multi-AI Personality Tests"
- "Test-First as AI Resistance Reduction: An Empirical Funnel Decomposition"

**Decision (2026-05-03)**: lead with title containing the empirical anchor (N) — establishes scope quickly for reviewers; "agreeable disagreement" framing surfaces in the abstract rather than the title to avoid product-marketing voice.

---

## Refined γ thesis

Spectrum-first onboarding for multi-AI consumer products operates as a pre-conversational trust-building surface through two mechanisms operating simultaneously:

1. **Agreeable disagreement.** Cross-vendor model disagreement, when surfaced explicitly ("They almost never agree"), functions as a curiosity hook — turning what single-lab products would treat as noise into the central pedagogical engine. AI introduces itself through the productive friction of comparison, not through demand for direct prompt-engineering.

2. **Embedded AI-attitude items as dual-function intervention.** Among the 74 questions in the Lucid spectrum, four are direct AI-attitude items that (a) measure baseline user resistance to AI personalization at session start, and (b) prompt the user to articulate that resistance in their own words — converting attitude into self-disclosed text. This articulation is a treatment, not just a measurement.

These two mechanisms together reduce AI resistance partially — a *necessary* condition for downstream conversion. They are not *sufficient*. The conversion gap (5.7% of completers, 2.0% of session starts) is multi-factor, decomposing into five candidate frictions that the embedded-item segmentation can begin to prioritize.

The paper's contribution is not a fix for the gap. It is the formalization of the funnel, the documentation of the gap as a measurable phenomenon, and the derivation of five testable hypotheses with intervention designs.

---

## Five academic contributions

### Contribution 1 — A 4-stage AI Trust Funnel formal definition

```
Stage 0: Visit landing                  (denominator unknown — analytics gap)
Stage 1: Spectrum start                 (entry into the trust-building surface)
Stage 2: Spectrum complete (analyze)    (33% of starts in current data)
Stage 3: Phone-verify (signup)          (5.7% of completers, 2.0% of starts)
Stage 4: Repeat session                 (retention; instrumentation gap)
Stage 5: Cross-product transition       (Currot bridge; instrumentation gap)
```

Each stage transition is a separate trust-cost gate. We treat the funnel formally as a survival problem (time-to-abandon at each stage) and a change-point problem (where in the questionnaire flow do drops cluster).

### Contribution 2 — Agreeable disagreement as pedagogical hook

Building on EN6's claim that cross-vendor disagreement is a measurable personalization signal single labs cannot self-generate, we operationalize the claim in product copy ("They almost never agree") and measure whether this framing produces measurable curiosity engagement (session-start rate from landing) versus the standard "Take this AI personality test" framing. The framing converts what would normally be a deficit (4 AIs disagreeing → unreliable) into the engine (4 AIs disagreeing → tell me about myself).

### Contribution 3 — Embedded AI-attitude items as dual-function intervention

Within the 74-question spectrum, 4 questions directly measure AI attitude. Their dual function:

- **Signal**: aggregate response distribution segments users into AI-positive (4-item composite ≥ ceiling threshold), AI-skeptical (≤ floor threshold), and AI-neutral. This segmentation becomes the discriminating variable in Contribution 4.
- **Intervention**: the act of self-articulating an AI-attitude position — in one's own words, in response to specific prompts — primes subsequent willingness to engage with the AI synthesis. This is a well-documented effect in marketing psychology (Morwitz & Fitzsimons 2004) and political communication (Berinsky et al. 2011), here applied to AI consumer products.

The methodology is novel for AI-product onboarding: standard A/B tests treat onboarding questions as measurement OR treatment, not both. We argue the items are necessarily both, and design the analysis to separate the two effects.

### Contribution 4 — Five testable hypotheses for the conversion gap

For the 5.7% completer-to-signup gap, we formally state five candidate explanations:

| H | Hypothesis | A priori probability | Test design |
|---|---|---|---|
| H1 | Residual AI resistance | 20% (a priori); revised to ~15% post-segment analysis | Compare conversion rate of AI-positive vs AI-skeptical segment at completion gate; H1 dominant if ratio > 1.5×. |
| H2 | Phone-gate friction (commitment cost) | 30% | A/B test: email-only signup variant vs phone-only vs OAuth. Predicted effect: 1.5–2.5× lift if H2 dominant. |
| H3 | Single-use satiation | 15% | A/B at result page: "next spectrum question" pull (variant A) vs "shareable card" pull (variant B) vs "chat with your AI matches" pull (variant C). Conversion rate divergence indicates satiation type. |
| H4 | Value-proposition weakness | 25% | A/B at signup gate: explicit value propositions vs control (current). Predicted lift 1.3–2.0× if H4 dominant. |
| H5 | Reciprocity absence | 10% | Currot-Bridge integration A/B: with bridge (Lucid result → Currot friend comparison) vs without. Predicted effect: increase in session-2 retention rather than session-1 signup, since H5 acts at the post-signup deepening stage. |

The five are not mutually exclusive. We expect multi-factor contributions; the segmentation in Contribution 3 helps prioritize sequencing.

### Contribution 5 — Necessary-but-insufficient framing

Spectrum-first reduces AI resistance partially. We formalize this as: pr(complete | spectrum start) is approximately doubled for AI-skeptical segment after the 4 embedded items, but pr(signup | complete) is not differentially affected. This decomposition tells us where spectrum-first works (top of funnel) and where it does not (bottom of funnel) — and the latter is multi-factor friction the design must address separately.

---

## Section structure (target ~5,500 words, 10 pages)

### Abstract (300 words)
Anchor the paper in 2,733 sessions, 18-day window, 33% reach-analysis, 2.0% conversion. State the four-stage funnel + five hypotheses. Surface the dual-function items methodology.

### 1. Introduction (1.5 pages)
- Multi-AI consumer products and the trust-acquisition challenge
- Spectrum-first surface design as implicit AI introduction strategy
- The 1.7-2.0% conversion gap as measurable phenomenon, not optimization target
- Companion paper CC6 (Currot mirror); EN6 (theoretical foundation)

### 2. Background (1 page)
- AI resistance / algorithm aversion literature (Dietvorst et al. 2015; Logg et al. 2019)
- Test-first vs chat-first onboarding precedents (16personalities; Quora; Akinator)
- Multi-AI evaluation literature (Chatbot Arena — Chiang et al. 2024; LMSYS)
- Embedded survey methodology (Morwitz & Fitzsimons 2004)
- Funnel decomposition in HCI (Kohavi et al. 2020)

### 3. Theory: The 4-Stage AI Trust Funnel (2 pages)
- Formal definition of the funnel
- Stage-transition trust costs
- Agreeable disagreement as pedagogical hook
- Embedded AI-attitude items as dual-function intervention
- Necessary-but-insufficient framework

### 4. Methodology (1 page)
- Lucid platform description (4 frontier LLMs, spectrum design, 74 questions)
- 4 embedded AI items: aggregate response distribution to be released
- Data collection 2026-04-18 → 2026-05-04
- Disclosure: author's own platform; methodology mirrors CC6

### 5. Empirical Findings (3 pages)
- 5.1 4-stage funnel decomposition (full transition rates)
- 5.2 Daily session count (with 5/3 surge as outlier annotation)
- 5.3 4 AI-attitude items response distribution
- 5.4 AI-positive vs AI-skeptical segment conversion comparison
- 5.5 AI provider failure correlation with funnel transitions

### 6. Five Testable Hypotheses (1.5 pages)
For each H1–H5: formal statement + predicted effect size + intervention design.

### 7. Discussion (1 page)
- Spectrum-first as necessary but insufficient
- Implications for consumer AI products (cross-product, not single-product)
- Connection to CC6 (mirror methodology, same researcher, two products)
- Connection to EN6 (theoretical operationalization)

### 8. Limitations
- N = 2,733, single platform
- Author's own product (positionality declared)
- 4 AI items aggregate-released, not item-level (privacy)
- Phase 2 (intervention) data not yet collected at submission

### 9. References (1 page)
~25–30 entries. Park-method citations: Park & Sohn (2020) change-point; Park et al. (2025) ideal-point; Martin, Quinn, Park (2011) MCMCpack.

---

## Park expertise hooks (paper sections that map to Park's published methodology)

| Park's method | L1 paper application |
|---|---|
| MCMCpack (Bayesian R) | Posterior estimation of stage-transition rates with priors from Phase-1 data |
| Hidden Markov Models | User trajectory through funnel stages as latent states |
| Change-point detection | Identifying the question-index in the 74-question spectrum where mid-flow drop concentrates |
| Bipartite network embedding | Users × question-class space; embed users along an "AI affinity" latent dimension |
| Cox proportional hazards | Time-to-abandon at each stage |
| Mixed-effects models | User-level heterogeneity in funnel paths (per-user random intercepts on stage-transition rates) |
| Ideal-point estimation | 4 AI items as 4-item Bayesian IRT scaling for AI-attitude latent score |

The paper cites at least 4 of Park's papers in the methodology section. Acknowledgement section names Park as endorser without claiming co-authorship.

---

## Risk audit

| Risk | Probability | Mitigation |
|---|---|---|
| Cleanup overruns 13h budget | 30% | Hard cap at 13h; if not done by 5/14 EOD, post a v0.1 GitHub-only and submit arXiv after Tier B (5/15+) |
| Empirical findings are weaker than expected (e.g., AI-segment difference small) | 40% | This is itself a finding — H1 NOT dominant means the field should focus on H2–H4. Frame around "what we learned about hypothesis prior calibration" |
| arXiv reviewers reject for over-claim ("Currot product paper") | 20% | Disclosure section + methodology mirrors CC6; recast as "case-study contribution to AI consumer onboarding research" |
| 4-AI-item aggregate release insufficient for replication | 25% | Provide synthetic-data simulation script + full SQL extraction queries in appendix; researchers with platform access can reproduce the analysis |

---

## Empirical preview (2026-05-03 schema check, round 2) — PENDING 5/8 THESIS DECISION

Pre-cleanup schema verification on `prism.spectrum_session.score_ait` (the
derived AI-trust composite, 1–7 scale) reveals a population distribution
that **rejects, not merely qualifies**, the selection-on-AI-positive
assumption that an earlier draft of this outline implicitly relied on.

### Segment distribution (round 2 query, n = 1,087 analyzed)

| Segment | ait range | Sessions | % of analyzed | Mean ait |
|---|---|---|---|---|
| AI-very-skeptical | ≤ 2 | **446** | **41.0%** | 1.41 |
| AI-skeptical | 2 – 3 | 281 | 25.9% | 2.60 |
| AI-neutral | 3 – 4 | 239 | 22.0% | 3.67 |
| AI-positive | 4 – 5 | 95 | 8.7% | 4.58 |
| AI-very-positive | > 5 | 26 | 2.4% | 5.76 |
| **Aggregate** | — | **1,087** | 100% | **~2.4** |

(Unanalyzed: 1,897 additional sessions where status is `'answering'` and
score_ait has not been computed yet.)

**Skeptical (≤3) total: 727 (66.9%). Positive (≥4) total: 121 (11.1%).**

### What this rejects

The earlier H1 prior of 20% in §"Five testable hypotheses" rested on an
implicit assumption: spectrum-first onboarding selects users who are
already AI-friendly, so residual AI resistance among completers should be
small. The population data **disconfirms** this. The analyzed population
is **6× more skeptical-leaning than positive-leaning** (727 vs 121); the
mean is solidly below the midpoint of the scale.

### Implications (to be ratified during 5/8 cleanup)

1. **H1 prior probability should rise from 20% to roughly 35–45%.**
   Residual AI resistance is no longer an "implicit absence" interpretation;
   the population structure makes it a leading candidate. The point estimate
   should be calibrated against Q4's conversion-by-segment delta (see below).

2. **"Agreeable disagreement" hook differential efficacy becomes a
   sub-hypothesis.** Skeptical users (the 67% majority) may engage with the
   curiosity hook *despite* their AI distrust because cross-vendor
   disagreement validates their priors ("even AIs can't agree about me").
   This is testable in Q4: if AI-skeptical users convert at non-trivial
   rates, the hook is doing real work on the population that needs it most.

3. **§5.4 framing inverts.** The central question is no longer "do
   AI-positive users convert more?" but **"how much of the conversion gap
   comes from AI-skeptical users who completed the test but stopped at the
   phone gate?"** The AI-positive segment becomes a smaller high-conversion
   control population, not the dominant pathway.

4. **The selection finding is itself a paper contribution.** The fact that
   spectrum-first onboarding does *not* select on AI-friendliness — that
   the 270K-subscriber YouTube channel + landing page recruited a 67%
   skeptical population — is a non-trivial result for the AI consumer
   product literature. Most multi-AI products implicitly assume their
   users are early-adopters; our data says they reach the resistant segment.

### Test design that resolves the prior calibration

Run `queries_template.sql` Q4 (conversion by AI segment). The decisive
metrics:

- If **AI-skeptical conversion ≈ AI-positive conversion** (within ~30%):
  H1 is *not* dominant; AI resistance is unrelated to the conversion gap;
  the bottleneck is H2/H4 (phone friction / value proposition). H1 prior
  → ~10%.
- If **AI-positive conversion ≥ 1.5× AI-skeptical conversion**:
  H1 is dominant; H1 prior → ~40–50%.
- If **AI-skeptical conversion meaningfully > AI-positive conversion**
  (an inversion): the spectrum surface is doing the heavy trust-building
  work on the resistant segment; H1 prior remains modest, but the paper
  has a strong novel finding worth foregrounding.

**Decision held for 5/8 cleanup window**: the H1 prior revision is a
thesis-level claim. The current §"Five testable hypotheses" remains the
registered framework; this preview is a notice that the empirical priors
have already shifted before formal cleanup begins.

See `queries_template.sql` Q2 (full distribution, replicates the table
above) and Q4 (the central empirical claim) — both designed to resolve
the prior calibration definitively.

---

## Versioning

- **v0.1 — 2026-05-03**: outline locked; thesis γ refined; 5 contributions identified; Park hooks mapped; empirical anchor confirmed; **schema-check empirical preview added (above) flagging probable H1 prior revision**.
- v0.2 — 2026-05-08: theory + methodology drafted (~3 pages); H1 prior decision ratified after Q2/Q4 execution.
- v0.3 — 2026-05-12: empirical + figures + 5 hypotheses formalized (~6 pages).
- v0.4 — 2026-05-14: discussion + references + LaTeX typeset; arXiv submission ready.
- v1.0 — 2026-Q3: post-Phase-2 intervention data integrated; CHI 2027 LBW or ICWSM 2027 submission.

---
title: AnemoIA — from EcoLogits to our own estimator
date: 2026-05-08
tags: [anemoia, carbon, environmental-impact]
---


The environmental measurement side of AnemoIA went through a meaningful evolution, and I want to document it here because the shift from using an external tool to building our own estimator wasn't just a technical decision — it reflected something about what the project was actually trying to do.

---

## Starting with EcoLogits

The first version of AnemoIA used [EcoLogits](https://ecologits.ai) as a post-response overlay. EcoLogits is an open-source library that estimates the energy and carbon cost of AI API calls using a parametric model based on NVIDIA H100 hardware. The idea was straightforward: send the request, get the response, call EcoLogits, display the impact.

It worked. But as the project grew, two things broke the dependency.

**First: Google.** In August 2025 Google published first-party LCA (Life Cycle Assessment) data for Gemini inference on their TPU infrastructure. This is fundamentally different hardware from H100 GPUs — TPUs are custom ASICs with a systolic array architecture that keeps model weights stationary and minimises data movement, which is the dominant energy cost in inference. Applying EcoLogits' H100 parametric model to a TPU workload would produce figures that are structurally wrong, not just imprecise. Google's own published coefficients made the right calculation possible for the first time.

**Second: the model catalogue.** By the time we were deep into development, AnemoIA was supporting GPT-5 and Claude 4.x model families that weren't yet in EcoLogits' catalogue. This meant most requests were already silently falling back to a local estimate — without surfacing that fact to the user. The dependency was adding latency and introducing a silent failure mode while providing no meaningful benefit over what we were already calculating locally.

There was also no image generation support in EcoLogits, and image generation was a feature we needed to measure.

---

## Building the three-path estimator

Removing EcoLogits meant owning the methodology. That responsibility clarified the architecture.

The estimator routes each request through one of three deterministic paths:

**Priority 1 — TPU formula (Google Gemini).** Google's published LCA figures, scaled by output token count. Flash Lite, Flash, and Pro each have distinct Wh-per-thousand-token coefficients derived from first-party data covering accelerator, networking, storage, and cooling.

**Priority 2 — H100 parametric formula (Anthropic Claude, OpenAI GPT).** The EcoLogits physics model, implemented directly in-process rather than as an external API call. GPU energy from active parameter count and batch size; water from each provider's published Water Usage Effectiveness; embodied carbon from the Boavizta database, amortised over three years and allocated per request by latency.

**Priority 3 — Flat fallback.** A fixed per-token coefficient for any model without published data. Currently unused by the nine models in the catalogue, but there for future additions.

For image generation, the approach is different again: a token-based refinement using the output token count the API returns, anchored to peer-reviewed measurements from Luccioni et al. (2023) for the energy range, and Bertazzini et al. (2025) for the finding that prompt length has no statistically significant effect on image synthesis energy across diffusion models — so only completion tokens are counted.

---

## What the shift meant

In practical terms: lower latency, no silent failure modes, full catalogue coverage, image generation support, and the ability to extend the estimator to new models without a third-party dependency.

But the more interesting shift was conceptual. Building the estimator in-process meant understanding it — not just trusting that the library returned something plausible. Every coefficient has a source. Every methodology decision is documented. When someone asks why a request to Claude Opus costs 8× more electricity than the same request to Claude Haiku, the answer lives in the code, not in someone else's black box.

That felt right for a project about making AI use more legible. It would have been odd to achieve transparency about environmental cost through an opaque dependency.

All estimates are labelled `~estimated` in the interface. Every CSV export includes a formula identifier so the calculation path that produced each figure is always traceable. The uncertainty is honest rather than hidden.

---

*Related: [[anemo-ia-the-idea|Where the idea came from]] · [[anemo-ia-building-in-phases|Building in three phases]] · [[the-cost-of-ai|The cost of AI]] · [[ai-and-the-green-web|AI and the green web]] · [[can-transparency-be-enough|Can transparency be enough?]] · [[two-papers-three-formulas|Two papers, three formulas]] · [[if-hardware-gets-better-does-the-question-disappear|If the hardware gets better...]] · [[what-if-ai-showed-its-carbon-cost|What if AI showed you the bill?]]*

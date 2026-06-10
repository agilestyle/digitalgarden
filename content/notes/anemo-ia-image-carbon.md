---
title: AnemoIA — why image generation carbon is its own problem
date: 2026-06-03
tags: [notes, anemoia, carbon, environmental-impact]
---


Measuring the carbon footprint of a text request is already an estimation problem. Measuring image generation is a different problem entirely — and it forced a methodological detour that taught me more about the limits of environmental accounting than anything else in the project.

The text pipeline works like this: prompt goes out, tokens come back, multiply by a per-token energy coefficient. The coefficient depends on the hardware (TPU or GPU), the provider, and the electricity grid. Imprecise, but grounded in published data and consistent across requests.

Image generation doesn't fit that model at all.

---

The first issue is data. There is almost no peer-reviewed energy measurement of modern image generation models. The one solid source I found is [Luccioni et al. 2023](https://arxiv.org/abs/2311.16863), which measured energy consumption across a range of image synthesis models and found a spread of 2.907–11.41 Wh per image. I used the upper bound — 11.41 Wh — as the initial pre-send estimate, which is conservative, but honest about the uncertainty.

The second issue is that the energy doesn't come from the prompt. A striking finding from [Bertazzini et al. 2025](https://arxiv.org/html/2506.17016v1) tested 17 diffusion models and found that prompt length has **no statistically significant effect** on image synthesis energy. The compute cost is dominated by the diffusion process itself — the iterative denoising that turns noise into an image — not by how many tokens went in. This meant I couldn't use input tokens as a proxy for cost at all.

What the OpenAI API *does* return is completion token counts. And it turns out these are meaningful: `gpt-image-2` returns one of three predictable token counts depending on the quality setting selected. Standard quality comes back at roughly 1,056 tokens; medium at ~1,756; high at ~4,160. These aren't text tokens — they're the image encoded in the model's token vocabulary — but they function as a reliable quality-tier signal.

So the estimator runs in two stages. Before the request is sent, it shows a fixed upper-bound figure (~11.41 Wh) prefixed with `~` to signal approximation. After the response arrives with actual completion token counts, it refines the estimate using per-token coefficients derived from the Luccioni range: 2.74 Wh per 1,000 completion tokens, 2.67 mL water per 1,000 tokens. Prompt tokens are excluded entirely.

---

The question of *why only OpenAI* for image generation came up early. Two constraints ruled out the others. Google's Imagen API returns no token data from the response — every request would yield the same flat constant regardless of quality or compute spent, which makes the refinement step impossible. And Anthropic's models don't produce image output. So it wasn't a preference; it was the only provider where the post-send methodology is viable.

All of this produces estimates that still sit somewhere on a spectrum of approximation. A standard-quality image on the Italian grid (~285 g CO₂/kWh) works out to around 823 mg CO₂e. The same request on France's near-nuclear grid would be a fraction of that. Every image request lands in eco-grade E — the highest-impact band — regardless of model or grid, because image synthesis is consistently the costliest interaction in the catalogue.

That's the number. What stays with me is what it took to get there: one peer-reviewed paper from 2023, one from 2025, a token count that represents an image not text, and a two-stage pipeline designed around a dataset too small to be confident in. The measurement isn't lying — but it's wearing its uncertainty visibly, and I think that visibility is part of what the project was trying to argue for.

---

*Related: [[anemo-ia-the-idea|Where the idea came from]] · [[anemo-ia-measuring-carbon|From EcoLogits to our own estimator]] · [[anemo-ia-building-in-phases|Building in three phases]] · [[two-papers-three-formulas|Two papers, three formulas]] · [[the-cost-of-ai|The cost of AI]] · [[if-hardware-gets-better-does-the-question-disappear|If the hardware gets better...]] · [[what-if-ai-showed-its-carbon-cost|What if AI showed you the bill?]]*

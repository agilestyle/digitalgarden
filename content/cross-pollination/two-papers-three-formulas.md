---
title: Two papers, three formulas
tags: [environment, AI, carbon, ecologits, TPU, hardware, anemo-ia, cross-pollination]
---

When I started building the environmental estimation layer for AnemoIA, the obvious starting point was [EcoLogits](https://ecologits.ai) — an open-source tool that wraps AI API calls and returns a carbon estimate alongside every response. It uses a parametric model of NVIDIA H100 GPU clusters, combined with [Boavizta's](https://boavizta.org) embodied-carbon database, to calculate the energy, water, and manufacturing cost of each inference. Clean methodology, well-documented, MIT-licensed. I wired it in.

Then Google published their own LCA data.

The [Google Cloud LCA blog post](https://cloud.google.com/blog/products/infrastructure/measuring-the-environmental-impact-of-ai-inference) (August 2025) gives first-party energy coefficients for Gemini models, measured across accelerator, networking, storage, and cooling. The figures are expressed per 1,000 output tokens: Flash Lite at 0.06 Wh, Flash at 0.96 Wh, Pro at 1.44 Wh. What makes them incompatible with EcoLogits isn't the numbers — it's the hardware.

Google runs inference on TPUs. TPUs are ASICs designed exclusively for neural network workloads: their systolic array keeps weights stationary and minimises data movement, which is the dominant cost in inference. NVIDIA H100s use a general-purpose SIMT model with higher scheduling overhead per operation. Applying an H100 parametric model to a TPU workload doesn't produce a wrong number — it produces a number that's wrong in ways you can't correct for, because the architectural assumptions don't transfer.

So EcoLogits, for all its rigour, was silently producing estimates for Gemini that had no grounding in how Gemini actually runs. And since most of the requests in my early prototype were going to Gemini Flash, most of the estimates were quietly off. I removed the dependency.

What replaced it is a three-path router. Google models go through the TPU formula — Google's own coefficients, scaled by output token count. Anthropic and OpenAI models go through a re-implementation of EcoLogits' H100 parametric formula, run locally. Everything else falls back to a flat per-token constant. The router picks the path by provider; no API call, no latency, no silent fallback.

What I took from this — beyond the implementation — is that measurement methodology is not neutral. EcoLogits works well for H100-based models because it was built around H100 assumptions. The moment the hardware changes, the formula changes. There is no universal carbon calculator for AI, because there is no universal AI hardware. Any tool that presents a single number without surfacing that dependency is making a choice about what to hide.

The three-path design is honest about this. Every estimate in AnemoIA is labelled `~estimated` and includes a formula identifier in the CSV export. Not because the numbers are unreliable, but because they are approximations made with specific assumptions — and those assumptions should be legible.

→ EcoLogits methodology: [ecologits.ai/latest/methodology](https://ecologits.ai/latest/methodology/)  
→ Google Cloud LCA: [cloud.google.com/blog/products/infrastructure/measuring-the-environmental-impact-of-ai-inference](https://cloud.google.com/blog/products/infrastructure/measuring-the-environmental-impact-of-ai-inference)  
→ Boavizta embodied carbon: [boavizta.org](https://boavizta.org)

---

*Related: [[the-cost-of-ai]] · [[ai-and-the-green-web]] · [[if-hardware-gets-better-does-the-question-disappear]]*

---
title: What if AI systems showed you the bill?
date: 2026-06-05
tags: [open-question, transparency, carbon, anemoia, responsible-ai, environmental-impact]
---


One of the things AnemoIA required me to build from scratch was an environmental estimator — assembling coefficients from peer-reviewed papers, provider LCA disclosures, and third-party databases, stitching them into a three-path pipeline that produces a credible approximation and labels it as such. It works. But it shouldn't be necessary.

The providers are in a very different position than anyone building on top of their APIs.

Google, Anthropic, OpenAI — they know which data centre handled a request, which hardware generation, which electricity grid. They know the token counts, the batch sizes, the cooling overhead, the amortised manufacturing cost of the infrastructure. They can't produce an exact figure — energy accounting at this level of granularity always involves modelling choices — but they could produce estimates orders of magnitude more grounded than anything a third party can reconstruct from published coefficients. The gap between what they could credibly calculate and what they return in an API response is not a technical limitation. It's a design decision.

So the question I keep sitting with: what would change if they started surfacing those estimates?

---

Not perfect measurements. Not a number that eliminates uncertainty. First-party, per-request figures — clearly labelled as estimates, but grounded in real infrastructure data — returned alongside every response the way token counts already are. A field in the JSON. A few extra bytes. Technically tractable.

The effect wouldn't be trivial.

If every client application, every wrapper, every interface had access to real impact data, the decision about whether to surface it would move downstream to designers and product teams — people who, in theory, can be pressured. Right now the data doesn't exist in the response, so the decision is already made at the infrastructure level, invisibly, by the providers. Surfacing it wouldn't force anyone to show it to users, but it would make the concealment a visible choice rather than a default.

And some products would show it. Probably not the mainstream interfaces — at least not at first. But the tools built for education, for institutional governance, for people who have already decided they want to use AI more thoughtfully. The ecosystem that grows around real data looks very different from the one that grows around approximations.

---

There's a precedent worth thinking about. Nutrition labelling was resisted by food manufacturers for years on the grounds that it would confuse consumers and harm sales. The argument was that the information was already available — people could look it up — so mandatory disclosure added no value. What disclosure actually did was shift the cost of knowing from the individual to the producer, and that shift changed behaviour at scale: not dramatically, not uniformly, but measurably.

Carbon disclosure for AI wouldn't be mandatory. But a norm can do some of the work a law would do, if it gets established early enough.

The question is whether providers would adopt it voluntarily, and on what timeline. The commercial incentive runs the other way: effortlessness is the product. Making resource consumption visible introduces a kind of friction — not in the interaction itself, but in the imagination of the interaction. You start to notice that you've been asking a lot of questions today. You wonder whether the quick lookup needed the expensive model.

That noticing is exactly what responsible use requires. It's also exactly what the current UX design suppresses.

---

I built AnemoIA because the data I needed didn't come with the API. I had to reconstruct it from published sources, with all the uncertainty that entails. The estimates are honest and methodologically grounded, but they're still estimates — proxies for numbers that exist somewhere in a data centre and aren't being shared.

The feeling that comes with that is something like anemoia: a longing for a version of things that doesn't exist yet but feels like it should have existed all along. A world where the interface tells you what you're spending — not to shame you, not to stop you, but because that's what transparency actually looks like when it's designed for the person using the system and not for the institution deploying it.

I don't know if providers will move in this direction. The incentive structure is against it, and the regulatory pressure in this specific area is still weak. But I notice that token counts weren't always in the API response either. At some point someone at each provider decided that information was useful enough to return. The technical work of adding emissions data is the same order of magnitude.

What's missing isn't the capability. It's the decision.

---

*Related: [[anemo-ia-the-idea|Where the idea came from]] · [[anemo-ia-measuring-carbon|From EcoLogits to our own estimator]] · [[anemo-ia-image-carbon|Image generation carbon]] · [[the-cost-of-ai|The cost of AI]] · [[can-transparency-be-enough|Can transparency be enough?]] · [[if-hardware-gets-better-does-the-question-disappear|If the hardware gets better...]] · [[responsible-for-whom|Responsible for whom?]]*

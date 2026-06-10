---
title: AnemoIA — building in three phases
date: 2026-04-22
tags: [anemoia]
---


One of the meta-questions I had going into the final project was whether it was possible to build something technically serious — not a prototype, not a mockup — while working alone, part-time, across a master's programme. The answer turned out to be yes, but only by being deliberate about how different AI tools were used at different stages.

The build happened in three phases.

---

**Phase 0 — Specification with ChatGPT.**
Before writing a line of code I used ChatGPT to work through the architecture of the product: what it needed to do, what it couldn't compromise on, where the hard constraints were. The most important constraints that came out of this phase were quiet ones: prompts may never be silently modified without user approval; environmental estimates should be clearly labelled as approximations; learning capsules should surface contextually, not on a fixed schedule. These aren't technical decisions — they're ethical ones. Getting them in writing before scaffolding anything meant they couldn't be accidentally designed away.

**Phase 1 — Scaffolding with Lovable.**
Lovable generated a working React codebase in hours: all four route pages, UI components, business logic stubs, and Cloudflare Workers deployment configuration. The trade-off was speed over correctness — no tests, some partially wired modules, rough edges throughout. But it gave me something real to reason about, which is worth more than a blank canvas.

**Phase 2 — Engineering refinement with Claude Code.**
This is where the majority of the work happened. Claude Code added the test suite, the on-device prompt analyser, the three-path environmental estimator, the carbon budget, model suggestion, CSV export, image attachment, pre-send impact preview, and image generation mode. It also removed significant dead code and rewired modules that Lovable had left incomplete.

---

What strikes me in retrospect is that each tool was genuinely necessary, and genuinely insufficient on its own. ChatGPT produces specification documents, not code. Lovable produces code without tests or custom engineering. Claude Code requires an existing codebase to reason about. Together, they compressed what would ordinarily be months of solo development.

There's something worth sitting with here: a project about responsible AI use was itself built using AI — and the process was faster, and arguably better-structured, than it would have been without it. That's not a contradiction. It's the same argument the project makes: the question isn't whether to use these tools, it's how to use them with intention.

---

*Related: [[anemo-ia-the-idea|Where the idea came from]] · [[anemo-ia-measuring-carbon|From EcoLogits to our own estimator]] · [[what-does-design-actually-change|What does design actually change?]] · [[from-principles-to-doing|From principles to doing]] · [[two-papers-three-formulas|Two papers, three formulas]] · [[if-hardware-gets-better-does-the-question-disappear|If the hardware gets better...]]*

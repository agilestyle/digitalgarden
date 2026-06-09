---
title: Clearview AI — a system that wasn't built for you
tags: [surveillance, biometrics, adms, power, governance, term-3]
---


Clearview AI scraped over 30 billion photographs from the open web — social media profiles, news articles, personal pages — and built a searchable database of human faces. No user consent. No opt-out. No relationship with the people whose faces were indexed.

What struck me when analysing it isn't the scale, though the scale is staggering. It's the relationship the system was built around. Clearview was never a product *for* the people being photographed. It was a product *about* them, sold to law enforcement clients who paid subscription fees to search it. The photographed are the raw material, not the customer and not the beneficiary.

This is a useful clarifying frame for [[adms-everywhere]]. Who is the system built for? Who pays for it, who operates it, and who is acted upon by it? The answers to those three questions tell you a lot about what values are encoded in the design.

Technically, the pipeline is elegant in a way that makes it easy to underestimate: CNN-based feature extraction produces a 128-dimensional embedding for each face, then vector similarity search (via Faiss + RocksDB) matches that embedding against billions of stored vectors in milliseconds. A face becomes a point in high-dimensional space — queryable, comparable, persistent. What makes it powerful is also what makes it alarming: the face doesn't expire. The embedding from a scraped photo taken years ago is permanently searchable.

The accountability gap is structural. Law enforcement agencies that use Clearview disclaim responsibility for the underlying data collection. Clearview disclaims responsibility for how its tool is used. Nobody owns the outcome. This is the same diffusion of accountability I noticed with [[adms-everywhere]] — automation doesn't eliminate responsibility, it redistributes it until it disappears.

---

*Related: [[adms-everywhere]] · [[responsible-for-whom]] · [[face-as-identity]] · [[can-consent-survive-scale]]*

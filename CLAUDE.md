# CLAUDE.md — Digital Garden (MDRAI)

## What this project is

A personal digital garden for the Master in Design for Responsible AI (MDRAI) at Elisava, Barcelona (2025–2026). Built with Quartz v5. A living knowledge space — not a blog, not a publication. Content is seeded, grown, and cross-pollinated throughout the program.

**Live:** agilestyle.github.io/digitalgarden
**Due:** Final review June 2026 — assessed on authenticity, consistency, and collaboration.

---

## Stack

- **Framework:** Quartz v5 (SSG for digital gardens, Markdown + wikilinks)
- **Content:** Markdown files in `content/` — flat structure within sections, `[[wikilinks]]` for connections
- **Config:** `quartz.config.yaml` (theme, plugins, layout)
- **Node:** ≥ 22 / npm ≥ 10.9.2

### Dev server

```sh
./server.sh start     # http://localhost:8080 (watches for changes)
./server.sh stop
./server.sh restart
```

---

## Content structure

```
content/
  index.md              # Garden home
  notes/                # Ideas and reflections from the program
  questions/            # Open, unresolved questions
  cross-pollination/    # Connections to peers' thinking
```

All notes are Markdown. Prefer short, linkable notes over long essays. Use tags and `[[wikilinks]]` to connect — not folders.

---

## Tone and voice

- Reflective and curious, not authoritative
- Personal — written in first person
- Comfortable with uncertainty and open questions
- Use "last updated" framing, never "published on"
- The garden metaphor is intentional: lean into it

---

## What to help with

- Drafting and refining notes and ideas
- Suggesting connections between notes via `[[wikilinks]]`
- Writing reflections on program themes: AI ethics, responsible design, speculative futures, human-AI interaction
- Keeping the tone personal and exploratory

---

## What NOT to do

- Don't make notes sound like blog posts or essays unless explicitly asked
- Don't add polish or "publishedness" — this is a garden, not a publication
- Don't add "published on" dates — use "last updated" framing
- Don't create new folders without asking

---

## Program context

- **Institution:** Elisava, Barcelona
- **Program:** Master in Design for Responsible AI (MDRAI)
- **Assignment:** M1 — Becoming a digital gardener (seed, grow, cross-pollinate)
- **Peer collaboration:** Part of a collective gardening practice — content may reference or link to peers' gardens
- **Final review:** June 2026 — assessed on a) authenticity and creativity, b) consistency of practice, c) collaboration

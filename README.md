# 🪴 Digital Garden — MDRAI

A personal digital garden built during the [Master in Design for Responsible AI (MDRAI)](https://www.elisava.net/en/masters/master-design-responsible-artificial-intelligence/) at Elisava, Barcelona (2025–2026).

This is a living knowledge space — not a blog, not a publication. Ideas here are seeded, grown, and cross-pollinated throughout the program. Things change. That's the point.

**Live garden:** [agilestyle.github.io/digitalgarden](https://agilestyle.github.io/digitalgarden)

---

## Stack

Built on [Quartz v5](https://quartz.jzhao.xyz/) — a static site generator for digital gardens and networked notes. Content is written in Markdown with `[[wikilinks]]` for internal connections.

- **Content:** `content/` — Markdown files, flat structure within sections
- **Config:** `quartz.config.yaml` — theme, plugins, layout
- **Build:** Quartz CLI via npm scripts

---

## Local development

**Requirements:** Node.js ≥ 22, npm ≥ 10.9.2

```sh
npm install
```

### Server commands

```sh
./server.sh start     # Start dev server at http://localhost:8080
./server.sh stop      # Stop the server
./server.sh restart   # Restart the server
```

The server watches for file changes and rebuilds automatically.

### Manual build

```sh
npx quartz build          # Build once to /public
npx quartz build --serve  # Build and serve with live reload
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

Notes use tags and `[[wikilinks]]` for connections — no nested folders within sections.

---

## Assignment context

**M1 — Becoming a Digital Gardener**
Seed, grow, and cross-pollinate. Assessed in June 2026 on authenticity, consistency of practice, and collaboration.

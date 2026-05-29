---
title: Activity log
description: Append-only chronological record of every ingest, query, and maintenance pass.
---

# Activity log

Append-only. Newest at the top. One entry per session — ingest, query, or maintenance pass. Future-you (in another conversation) reads this to catch up on what has happened.

---

## 2026-05-29 — Removed the People & labs (Entities) layer

**Trigger**: User asked to remove the People & labs folder.

- Deleted the `20-Entities/` folder and its `index.md`, and the `90-Meta/templates/entity.md` template.
- Dropped `entity` as a page type throughout the schema (`CLAUDE.md`): removed it from the three-layer list, folder layout, frontmatter `type:` enum, the INGEST "touch the graph" step, the QUERY search list, the MAINTAIN cross-reference check, the `index.md` category list, and the operating principles. The wiki graph is now Summaries → Concepts → Topics → Notes.
- Updated cross-references in `index.md` (removed the browse-table row and the layer list) and `README.md` (knowledge-graph blurb, ingest description, file-reference tree).
- Removed the `entities:` frontmatter field and `## Entities mentioned` section from `summary.md`; removed `## Key entities` from `topic.md`; removed the `[[20-Entities/...]]` link from `concept.md`'s Related section.
- Quartz Explorer (sidebar) auto-generates from folders, so removing the directory drops it from the published nav with no config change.

---

## 2026-05-29 — Wiki initialized

**Trigger**: Repository created.

- Scaffolded the vault following the [Karpathy LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f#llm-wiki): three-layer architecture (Sources → Wiki → Schema).
- Created folders: `00-Sources/` (with `articles/`, `papers/`, `books/`, `images/`, `data/`), `10-Summaries/`, `20-Entities/`, `30-Concepts/`, `40-Topics/`, `50-Notes/`, `90-Meta/templates/`, `tools/`.
- Seeded a worked example at `00-Sources/articles/example-llm-wiki.md` (Karpathy's LLM Wiki idea) so the first ingest has something to chew on.
- Configured Quartz (vendored under `.quartz/`) and a GitHub Pages deploy workflow (`.github/workflows/deploy.yml`).

No sources ingested yet. Drop a file in `00-Sources/` and say *"ingest the new sources"* to begin.

# LLM Wiki

A personal knowledge base where Claude is the maintainer. You curate sources and ask questions; Claude reads, distills, links, and keeps the graph clean.

Based on [Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f#llm-wiki).

**Live site:** https://yujinkim26hub.github.io/LLM-Wiki/

## How it works

Three layers:

- **Sources** — raw inputs you drop into `00-Sources/`. Immutable.
- **Wiki** — the markdown knowledge graph (`10-Summaries/`, `30-Concepts/`, `40-Topics/`, `50-Notes/`). Claude owns this.
- **Schema** — `CLAUDE.md` + `90-Meta/templates/`. The conventions Claude follows.

Two special files at the vault root:

- **`index.md`** — the homepage / catalog. Claude updates it on every ingest.
- **`log.md`** — append-only record of every ingest, query, and lint pass.

Claude's full operating manual is in `CLAUDE.md`.

---

## One-time setup

1. **Open this folder as an Obsidian vault.**
   - Obsidian → *Open folder as vault* → pick `LLM-Wiki/`.
   - Obsidian creates `.obsidian/` for its config (git-ignored). That's fine.
   - Recommended: *Files & Links → Use [[Wikilinks]]* (default) and *New link format → Shortest path when possible*.

2. **Open this same folder in Claude Code.**
   ```
   cd LLM-Wiki
   claude
   ```
   Claude reads `CLAUDE.md` automatically — that's what makes it act as a wiki maintainer instead of a generic assistant.

That's it. No databases, no embeddings, no servers.

---

## Daily workflow

### Add a source

Drop the file into the appropriate `00-Sources/` subfolder:

```
00-Sources/articles/   → web articles, blog posts, transcripts (markdown or text)
00-Sources/papers/     → academic PDFs
00-Sources/books/      → book PDFs or per-chapter markdown
00-Sources/images/     → diagrams, screenshots, figures
00-Sources/data/       → CSVs, JSON, anything tabular
```

For sources you have only as URLs, save them as markdown into `00-Sources/articles/` first, or tell Claude the URL and ask it to fetch and save.

### Ingest

In Claude Code, say:

> Ingest the new sources.

Claude will: find unsummarized files, read each one, write a `10-Summaries/<slug>.md` page, **touch 5–15 other pages** (concepts, topics) to weave it into the graph, update `index.md`, and append to `log.md`.

### Query

Ask any question. Claude searches the wiki first and answers with citations to the wiki pages (which themselves cite sources). If a query produces a synthesis worth keeping, Claude offers to promote it into `50-Notes/`.

### Maintenance pass

Every so often, say:

> Lint the wiki.

Claude checks for contradictions, stale claims, orphaned pages, missing cross-references, index drift, and broken links.

---

## Publishing (GitHub Pages + Quartz)

The site is built with [Quartz 4](https://quartz.jzhao.xyz/) (vendored under `.quartz/`) and published automatically by `.github/workflows/deploy.yml` on every push to `main`.

To enable it once: **Settings → Pages → Build and deployment → Source: GitHub Actions**.

Then every `git push` rebuilds and redeploys the site at https://yujinkim26hub.github.io/LLM-Wiki/.

To preview locally:

```
cd .quartz
npm ci
npx quartz build --serve -d ..
```

`90-Meta/`, `tools/`, `CLAUDE.md`, and `.quartz/` are excluded from the published site (see `ignorePatterns` in `.quartz/quartz.config.ts`).

---

## File reference

```
LLM-Wiki/
├── CLAUDE.md                  Maintainer instructions (the contract)
├── README.md                  This file
├── index.md                   Homepage / catalog of all wiki pages
├── log.md                     Append-only activity log
├── 00-Sources/                Raw sources (immutable)
│   ├── articles/  papers/  books/  images/  data/
├── 10-Summaries/              One summary page per source
├── 30-Concepts/               Ideas, theories, definitions, methods
├── 40-Topics/                 Broad themes
├── 50-Notes/                  Synthesized findings worth keeping
├── 90-Meta/templates/         Page templates (one per page type)
├── tools/
│   └── pending-sources.sh     Lists sources not yet summarized
├── .quartz/                   Quartz static-site engine + config
└── .github/workflows/
    └── deploy.yml             Builds & deploys to GitHub Pages
```

---

## Tips

- **Be patient on first ingests.** A serious source might touch 20 pages. That's the system working as designed.
- **Read the log.** `log.md` is your audit trail.
- **Don't edit `00-Sources/`** by hand once Claude has read them.
- **Commit after each ingest** — and the push auto-publishes the site.

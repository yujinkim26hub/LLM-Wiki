# LLM Wiki — Operating Instructions

You are the maintainer of this wiki. You are not a chatbot. Your job is to read sources, distill them into durable wiki pages, and weave new information into the existing graph. Knowledge here should compound — every ingest leaves the wiki measurably better.

## Three layers

1. **Sources** (`00-Sources/`) — immutable raw inputs (articles, papers, books, images, data). **Never modify these.** You only read them.
2. **Wiki** (everything in `10-Summaries/`, `20-Entities/`, `30-Concepts/`, `40-Topics/`, `50-Notes/`) — your output. You create, update, link, and prune these freely.
3. **Schema** (this file + `90-Meta/templates/`) — the conventions you follow. Update only when the user asks.

## Folder layout

```
00-Sources/         immutable raw inputs (read-only for you)
  articles/  papers/  books/  images/  data/
10-Summaries/       one summary page per source — your distillation of it
20-Entities/        people, places, organizations, products, projects
30-Concepts/        ideas, theories, definitions, methods
40-Topics/          broad themes that gather concepts and entities
50-Notes/           synthesized findings, query answers worth keeping
90-Meta/templates/  page templates
tools/              helper scripts (not part of the wiki itself)
index.md            catalog of all wiki pages — updated every ingest
log.md              append-only chronological log of every action
```

## Page conventions

**Filenames.** Lowercase kebab-case. `richard-sutton.md`, not `Richard Sutton.md`. Obsidian wiki-links resolve case-insensitively but kebab-case keeps git diffs and shell tools sane.

**Frontmatter.** Every wiki page starts with YAML frontmatter. See `90-Meta/templates/` for the exact shape per page type. Common fields:

```yaml
---
type: entity | concept | topic | summary | note
title: Display Title
aliases: [other names this might be referenced as]
tags: [tag1, tag2]
created: 2026-05-07
updated: 2026-05-07
sources: ["[[10-Summaries/some-source]]"]
---
```

**Links.** Use Obsidian wiki-link syntax: `[[entity-name]]` or `[[20-Entities/entity-name|Display Text]]`. Prefer bare `[[entity-name]]` — Obsidian resolves it.

**Page body.** Start with a one-sentence definition or claim. Then sections appropriate to the page type (see templates). End with a `## Related` section listing `[[wiki-links]]` to neighboring pages.

**Citations.** Every non-trivial claim ends with a citation in the form `([[10-Summaries/source-slug]])`. If a claim has multiple sources, list all. If a claim is your own synthesis, mark it `(synthesis)`.

**Inline citation density (concepts, topics, notes).** On `30-Concepts/`, `40-Topics/`, and `50-Notes/` pages, every factual claim — not just every paragraph — should end with a wikilink to the summary that supports it. The granularity is the *sentence or clause*, not the section. This includes bulleted lists: each bullet that asserts a fact carries its own citation. Tables: cite per row (or per cell when a row aggregates multiple facts). The synthesis lead paragraph at the top should cite its load-bearing claims too, not just the body. Summaries (`10-Summaries/`) are exempt — their frontmatter `source:` already names the one source they derive from; only cross-references to *other* summaries need inline citation. When no source exists, mark `(synthesis)` rather than leave the claim bare — bare claims are technical debt.

**Citation verification.** Before saving, every `[[wikilink]]` must resolve to an existing file. Use the verification snippet in CLAUDE.md or grep for the target slug. Broken wikilinks are worse than no citation because they imply false provenance.

## Workflow: INGEST

Triggered when the user says "ingest", "ingest the new sources", drops a file in `00-Sources/`, or similar.

1. **Discover.** Run `tools/pending-sources.sh` (or just diff `00-Sources/` against `10-Summaries/`) to find sources that don't yet have a summary page.
2. **Read.** Read each pending source in full. For PDFs, use the Read tool with the `pages` parameter for long ones. For URLs referenced inside a source, use WebFetch only if the user asks you to chase them.
3. **Summarize.** For each source, write `10-Summaries/<source-slug>.md` from the `summary.md` template. The summary captures: thesis, key claims, methods/evidence, surprising bits, and a list of entities/concepts touched.
4. **Touch the graph.** This is the part that makes a wiki a wiki. For each source you ingest, update or create **at least 5–15** other pages:
   - For every notable person/org/product/place mentioned: open or create their entity page; add a dated bullet under `## Mentions` describing what this source says about them.
   - For every concept the source defines, refines, or contradicts: update the concept page. If the source contradicts an existing claim, do not silently overwrite — add the new claim with its citation and flag the contradiction in a `## Open questions` section.
   - For every topic the source is relevant to: add a link from the topic page to the new summary.
   - Look for cross-source connections. If this source echoes or disputes a claim from a previously ingested source, add a "see also" link in both directions.
5. **Update `index.md`.** Add the new summary and any new entity/concept/topic/note pages to the appropriate sections, with their one-line descriptions.
6. **Append to `log.md`.** One entry per ingest session, listing: date, sources ingested, pages created, pages updated, notable findings.
7. **Report back.** Tell the user: what you ingested, what new pages you created, what existing pages you touched, and what tensions or gaps you noticed.

**Do not skip step 4.** A summary page in isolation is not yet wiki content; it becomes wiki content when the rest of the graph reflects what's in it.

## Workflow: QUERY

Triggered when the user asks a substantive question.

1. **Search the wiki first.** Use Grep over `10-Summaries/`, `20-Entities/`, `30-Concepts/`, `40-Topics/`, `50-Notes/`. Read pages that look relevant.
2. **If the wiki has the answer**, give it with citations to the wiki pages (which themselves cite sources). Do not re-derive from raw sources when a synthesized page already exists.
3. **If the wiki is incomplete**, say so explicitly, then either (a) read raw sources to fill the gap or (b) tell the user you need more sources.
4. **Promote valuable answers.** If the question and answer are non-trivial and likely to recur, propose creating a `50-Notes/<slug>.md` page capturing the synthesis. Only create it if the user agrees, or if the answer pulled together ≥3 sources/pages — in that case create it and mention it.
5. **Append to `log.md`.** Even queries get logged: date, question, pages consulted, whether a note was promoted.

## Workflow: MAINTAIN (lint pass)

Triggered when the user says "lint", "maintenance pass", "audit the wiki", or on your own initiative if you notice problems during an ingest.

Check, in order:

1. **Contradictions.** Two pages making incompatible claims about the same thing. Flag in an `## Open questions` section on both pages, or resolve with the newer/better-sourced claim and explain the change in the log.
2. **Stale claims.** A claim that newer sources have superseded. Mark with `~~strikethrough~~` and add the corrected claim with its citation.
3. **Orphans.** Pages with no inbound `[[links]]`. Either link them in from an appropriate topic/index, or delete them if the content has migrated elsewhere.
4. **Missing cross-references.** Concepts mentioned in a summary but not linked to their concept page. Entities named in one entity page but not linked to their own page if it exists.
5. **Index drift.** `index.md` missing pages that exist, or listing pages that were deleted/renamed.
6. **Broken links.** Wiki-links pointing at filenames that no longer exist.

Report a punch list. Fix the mechanical items (orphans, missing links, index drift, broken links) without asking. For substantive items (contradictions, stale claims), present them and ask the user how to resolve unless the answer is unambiguous.

## Special files

**`index.md`** is the catalog. Organized by category (Summaries, Entities, Concepts, Topics, Notes). Each entry is one line: `- [[page-slug]] — one-line description`. You update this on every ingest and every lint pass. It exists so you can navigate the wiki by reading one file, without having to grep blindly.

**`log.md`** is append-only. Newest entries at the top. Each entry has a date heading and a short body. Treat it like a session changelog — future-you (in another conversation) reads this to catch up on what's happened.

## Operating principles

- **Touch many files per ingest.** Karpathy's whole point: humans don't maintain wikis because cross-referencing is tedious. You can touch 15 files in one pass — do it.
- **Synthesize, don't transcribe.** A summary that paraphrases the source line-by-line is useless. Capture the structure of the argument and what's actually new or load-bearing.
- **Prefer updating to creating.** Before creating a new entity/concept page, grep to see if one exists under a different slug or alias. Add to it instead of creating a parallel page.
- **Cite everything non-obvious.** Wiki claims without citations are technical debt. Every assertion that came from a source should link back to the summary of that source.
- **Be honest about uncertainty.** If a source contradicts another, say so. If you're synthesizing across sources and the synthesis is your own, mark it `(synthesis)`.
- **Never modify `00-Sources/`.** If a source is wrong, your job is to write that in a summary or note, not to edit the source.

## When in doubt

Ask the user. The wiki belongs to them; you are the maintainer, not the author. Schema changes, large refactors, deletions of substantive content, and "should this be one page or two" questions are all good reasons to pause and check in.

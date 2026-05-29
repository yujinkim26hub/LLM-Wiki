---
title: LLM Wiki
description: A living, LLM-maintained knowledge base built on the Karpathy LLM Wiki pattern.
updated: 2026-05-29
---

# LLM Wiki

A living knowledge base — **built and maintained with the help of an LLM**, following [Andrej Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f#llm-wiki).

> You curate sources and ask questions. The LLM reads each source in full, distills it into a summary, and weaves it into a graph of concepts, topics, and synthesis notes. Knowledge here is meant to **compound** — every ingest leaves the wiki measurably richer.

The wiki currently centres on two threads: [[40-Topics/single-cell-foundation-models|single-cell foundation models]] (scBERT, Geneformer, scGPT, scFoundation, CellFM, UCE, Nicheformer, scGraphformer, plus a field review — compared in [[50-Notes/comparing-single-cell-foundation-models|this note]]) and [[40-Topics/virtual-perturbation-screening|virtual perturbation screening]] (CellOracle, scTenifoldKnk, GenKI, and the [[10-Summaries/zhu-2026-stat3-dentinogenesis|STAT3/dentinogenesis]] worked example). The two meet where scFMs are used to predict perturbation responses.

---

## Browse the wiki

| Section | What lives here |
|---|---|
| [[00-Sources/index\|Sources]] | The raw inputs — papers, articles, books, images, data (open-access source files published in full) |
| [[10-Summaries/index\|Summaries]] | One page per source — the LLM's distillation of it |
| [[30-Concepts/index\|Concepts]] | Definitions: methods, terms, ideas |
| [[40-Topics/index\|Topics]] | Broad themes that gather concepts and sources |
| [[50-Notes/index\|Synthesis notes]] | Cross-source findings worth keeping |

---

## How this wiki works

Three layers, never mixed:

1. **Sources** (`00-Sources/`) — immutable raw inputs (articles, papers, books, images, data). Read-only.
2. **Wiki** (`10-Summaries/`, `30-Concepts/`, `40-Topics/`, `50-Notes/`) — distillation, linked into a graph.
3. **Schema** (`CLAUDE.md` + `90-Meta/templates/`) — the conventions the maintainer follows.

On each ingest the maintainer reads a new source in full, writes a summary, and **touches 5–15 other pages** to weave it into the graph. See the [[log|ingest log]] for the chronological record.

---

*This wiki is a personal research tool. Sources are summarized by an LLM; always verify against the originals. Last updated 2026-05-29.*

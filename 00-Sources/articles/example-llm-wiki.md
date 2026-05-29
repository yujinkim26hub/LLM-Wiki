---
type: source
title: "Karpathy's LLM Wiki — building a knowledge base an LLM maintains"
source_kind: article
author: Andrej Karpathy
published: 2025
url: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
added: 2026-05-29
tags: [seed-example, llm-tooling, knowledge-management]
---

# Karpathy's LLM Wiki — building a knowledge base an LLM maintains

> This is a **seed example source**. It exists so your very first ingest is a real, worked run. Once you've ingested it and seen how the wiki fills out, you can delete this file (and its summary) for a clean slate, or keep it as a reference.

## The idea

A common failure mode of personal knowledge management is that the cross-referencing work — linking a new note to everything it touches — is tedious enough that humans simply don't do it. Notes pile up as disconnected islands. The promise of an LLM-maintained wiki is to flip that economics: a language model can cheaply touch a dozen pages per new source, so the graph actually gets woven together instead of accreting as a flat pile.

The pattern has three layers that are never mixed:

1. **Sources** — the raw inputs you collect (papers, articles, transcripts, data). These are immutable. The maintainer reads them but never edits them.
2. **Wiki** — the distilled, linked knowledge: one summary per source, plus pages for the entities, concepts, and topics those sources touch, plus synthesis notes that connect across sources. This layer is a graph, and it is the LLM's to grow and prune.
3. **Schema** — the conventions the maintainer follows: page templates, frontmatter shape, citation rules, and the workflows for ingesting, querying, and linting.

## Why "touch many pages per ingest" is the whole point

A summary page sitting in isolation is not yet wiki content. It becomes wiki content only when the rest of the graph reflects what's in it: the people it mentions get a dated bullet on their entity page; the methods it defines update the relevant concept pages; the themes it advances get a new link from the topic page; and any claim that echoes or disputes an earlier source gets a "see also" link in both directions.

This is the step humans skip and LLMs don't have to. The maintainer is told to update or create **at least 5–15 other pages** for every source ingested.

## Citations as provenance

Every non-trivial claim in the wiki ends with a citation that links back to the summary of the source it came from. Claims that are the maintainer's own synthesis are marked as such, rather than left to masquerade as sourced fact. Broken links — citations that point at files which don't exist — are treated as worse than no citation at all, because they imply a provenance that isn't real.

## Three workflows

- **Ingest** — read new sources, summarize each, weave them into the graph, update the catalog, log the session.
- **Query** — search the wiki first; answer from synthesized pages with citations; promote a recurring, multi-source answer into a synthesis note.
- **Maintain (lint)** — sweep for contradictions, stale claims, orphaned pages, missing cross-references, catalog drift, and broken links.

## What makes it durable

The wiki is plain markdown in a git repository. No database, no embeddings, no server. It's editable by hand in Obsidian, diffable in git, and publishable as a static site. The LLM is the maintainer, not the owner — schema changes, large refactors, and deletions of substantive content are decisions that belong to the human.

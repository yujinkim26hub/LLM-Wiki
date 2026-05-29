---
type: concept
title: Cell embedding
aliases: [cell embedding, cell embeddings, cell representation]
tags: [single-cell, foundation-model, representation]
created: 2026-05-29
updated: 2026-05-29
---

# Cell embedding

> A fixed-length vector summarising a cell's transcriptional state, produced by an scFM and reused across downstream tasks.

## Definition

A cell embedding is the model's learned representation of an entire cell, typically read from a special `<cls>` token or by pooling the cell's gene tokens ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/tejada-lapuerta-2025-nicheformer]]). UCE produces a 1,280-dimensional embedding from its `<cls>` token ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Why it matters

The cell embedding is the main reusable output: a good one places biologically similar cells together regardless of [[batch-integration|batch]], enabling [[cell-type-annotation]], clustering, and integration ([[10-Summaries/rosen-2023-universal-cell-embeddings]], [[10-Summaries/zeng-2025-cellfm]]). scFoundation recommends using embeddings rather than predicted expression values, since the latter are dropout-heavy ([[10-Summaries/hao-2024-scfoundation]]).

## Variants and refinements

- **`<cls>`-token embedding** — scGPT ([[10-Summaries/cui-2024-scgpt]]), UCE ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).
- **Mean of gene tokens** — Nicheformer averages last-layer gene tokens ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).
- **Cell-node embedding in a learned graph** — scGraphformer represents each cell as a graph node ([[10-Summaries/fan-2024-scgraphformer]]).

## Contested points

Independent benchmarks find scFM embeddings strong for cell-type prediction but weaker for cross-platform integration than dedicated tools ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[gene-embedding]] — the gene-level counterpart
- [[batch-integration]], [[cell-type-annotation]] — what embeddings are used for
- [[single-cell-foundation-model]], [[transformer]]

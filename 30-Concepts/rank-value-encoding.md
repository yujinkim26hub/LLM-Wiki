---
type: concept
title: Rank-value encoding
aliases: [rank-value encoding, rank value encoding, rank ordering]
tags: [single-cell, foundation-model, representation]
created: 2026-05-29
updated: 2026-05-29
---

# Rank-value encoding

> An [[expression-tokenization]] scheme that represents a cell by the *rank order* of its genes' expression rather than their absolute values.

## Definition

Genes are ranked by per-cell expression, normalised to each gene's corpus-wide non-zero median, so housekeeping genes are deprioritised and cell-state-defining genes (e.g. transcription factors) are promoted ([[10-Summaries/theodoris-2023-geneformer]]). Absolute transcript counts are discarded ([[10-Summaries/theodoris-2023-geneformer]]).

## Why it matters

Rank ordering is intrinsically relative, conferring robustness to technical scale/batch differences — Geneformer's signature contribution ([[10-Summaries/theodoris-2023-geneformer]]). Nicheformer reuses it with technology-specific normalisation to harmonise dissociated and spatial assays ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Contested points

The trade-off is loss of quantitative dynamic range; scBERT, scGPT, scFoundation and CellFM instead keep magnitude via binning or continuous value embeddings ([[10-Summaries/yang-2022-scbert]], [[10-Summaries/cui-2024-scgpt]], [[10-Summaries/hao-2024-scfoundation]], [[10-Summaries/zeng-2025-cellfm]]). Geneformer itself acknowledges discarding absolute counts loses information ([[10-Summaries/theodoris-2023-geneformer]]).

## Related

- [[expression-tokenization]] — the parent concept and competing schemes
- [[single-cell-foundation-model]]

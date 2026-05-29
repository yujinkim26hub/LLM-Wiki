---
type: concept
title: Expression tokenization
aliases: [expression tokenization, gene tokenization, input encoding, value binning, value projection]
tags: [single-cell, foundation-model, representation]
created: 2026-05-29
updated: 2026-05-29
---

# Expression tokenization

> How a single-cell foundation model turns a cell's gene-expression vector into a sequence of tokens the [[transformer]] can ingest — the design choice that most distinguishes scFMs from one another.

## Definition

Each scFM must encode (gene identity, expression level) pairs into model inputs. The dominant schemes are [[rank-value-encoding]], value binning, and continuous value projection ([[10-Summaries/baek-2025-scfm-review]]). The choice trades off quantitative resolution against robustness to noise and batch effects ([[10-Summaries/baek-2025-scfm-review]]).

## Why it matters

It is the single biggest architectural fork across scFMs and drives what information the model can and cannot represent ([[10-Summaries/baek-2025-scfm-review]]). Discarding magnitude (rank ordering) buys batch-robustness but loses dynamic range; preserving continuous values keeps magnitude but is more exposed to technical noise ([[10-Summaries/theodoris-2023-geneformer]], [[10-Summaries/hao-2024-scfoundation]]).

## Variants and refinements

- **[[rank-value-encoding|Rank-value encoding]]** — genes ordered by normalised expression; absolute counts discarded ([[10-Summaries/theodoris-2023-geneformer]]). Also used (with technology-specific normalisation) by Nicheformer ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).
- **Value binning** — expression discretised into bins (e.g. equal-frequency), relative and batch-invariant ([[10-Summaries/cui-2024-scgpt]]); scBERT uses binned expression plus gene2vec identity embeddings ([[10-Summaries/yang-2022-scbert]]).
- **Continuous value projection** — raw scalars mapped through learnable value embeddings, no discretisation; explicitly pitched as preserving resolution lost by binning ([[10-Summaries/hao-2024-scfoundation]], [[10-Summaries/zeng-2025-cellfm]]).
- **Protein-embedding gene tokens** — genes tokenised by the ESM2 embedding of their protein product, giving a species-independent vocabulary ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Contested points

scBERT and scFoundation argue binning sacrifices resolution and prefer richer value encodings ([[10-Summaries/yang-2022-scbert]], [[10-Summaries/hao-2024-scfoundation]]); Geneformer argues rank ordering deprioritises housekeeping genes and surfaces cell-state-defining ones ([[10-Summaries/theodoris-2023-geneformer]]); UCE argues the whole text-like gene-sequence framing is biologically dubious ([[10-Summaries/rosen-2023-universal-cell-embeddings]]). No consensus exists ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[rank-value-encoding]] — the rank-ordering scheme in detail
- [[gene-embedding]], [[transformer]], [[single-cell-foundation-model]]

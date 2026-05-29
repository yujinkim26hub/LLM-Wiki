---
type: concept
title: Multi-omics
aliases: [multi-omics, multiomics, multi-omic, multimodal]
tags: [single-cell, modality]
created: 2026-05-29
updated: 2026-05-29
---

# Multi-omics

> Jointly modelling more than one molecular modality (e.g. RNA + chromatin accessibility, RNA + protein) per cell.

## Definition

Multi-omics integrates complementary measurements such as scRNA-seq with scATAC-seq or surface-protein (CITE-seq) data into a shared representation ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/baek-2025-scfm-review]]).

## Why it matters

It is a major extension axis for scFMs, promising a more complete view of cell state than transcriptome-only models ([[10-Summaries/baek-2025-scfm-review]]). Several current scFMs are explicitly transcriptome-only and flag this as a limitation ([[10-Summaries/hao-2024-scfoundation]], [[10-Summaries/theodoris-2023-geneformer]]).

## Variants and refinements

- **RNA + ATAC / RNA + protein / mosaic integration** — scGPT's multi-omic variant (vs scGLUE, Seurat v4, scMoMaT) ([[10-Summaries/cui-2024-scgpt]]).
- **Modality taxonomy** — the review organises scFMs partly by which omics modalities they cover ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[single-cell-foundation-model]], [[cell-embedding]]
- [[spatial-transcriptomics]] — a related extension axis

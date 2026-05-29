---
type: concept
title: Single-cell RNA sequencing (scRNA-seq)
aliases: [scRNA-seq, single-cell RNA-seq, single-cell RNA sequencing, single-cell transcriptomics]
tags: [single-cell, modality, data]
created: 2026-05-29
updated: 2026-05-29
---

# Single-cell RNA sequencing (scRNA-seq)

> Measuring gene expression one cell at a time, the data modality that single-cell foundation models are trained on.

## Definition

scRNA-seq profiles the transcriptome of individual cells, revealing cellular heterogeneity at high resolution ([[10-Summaries/zeng-2025-cellfm]], [[10-Summaries/fan-2024-scgraphformer]]). The resulting matrices are large, sparse, noisy, and affected by [[batch-integration|batch effects]] ([[10-Summaries/zeng-2025-cellfm]]).

## Why it matters

The explosion of public scRNA-seq atlases (tens of millions of cells) is what makes scFM [[self-supervised-pretraining|pretraining]] feasible — and the data's noise/sparsity is what motivates a unified model ([[10-Summaries/zeng-2025-cellfm]], [[10-Summaries/baek-2025-scfm-review]]). It also supplies the expression matrices from which single-cell [[gene-regulatory-network|GRNs]] are inferred for [[in-silico-perturbation]] ([[10-Summaries/yang-2023-genki]]).

## Variants and refinements

- **Dissociated scRNA-seq** — the standard input for Geneformer, scGPT, scFoundation, scBERT, CellFM, UCE ([[10-Summaries/theodoris-2023-geneformer]], [[10-Summaries/cui-2024-scgpt]]).
- **+ Spatial** — [[spatial-transcriptomics]] retains tissue location, jointly modelled by Nicheformer ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).
- **+ Other modalities** — see [[multi-omics]] ([[10-Summaries/cui-2024-scgpt]]).

## Related

- [[spatial-transcriptomics]], [[multi-omics]]
- [[single-cell-foundation-model]], [[batch-integration]]

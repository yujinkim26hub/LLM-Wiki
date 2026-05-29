---
type: concept
title: Batch integration
aliases: [batch integration, batch effect, batch effects, batch correction, data integration]
tags: [single-cell, task, benchmark]
created: 2026-05-29
updated: 2026-05-29
---

# Batch integration

> Removing technical variation between datasets/experiments so that cells cluster by biology rather than by batch — both a downstream task for scFMs and a confound they must overcome.

## Definition

Batch effects are systematic technical differences between samples, platforms, or studies that obscure biological signal ([[10-Summaries/zeng-2025-cellfm]], [[10-Summaries/yang-2022-scbert]]). Integration aligns datasets into a shared space, evaluated by metrics such as scIB/AvgBIO ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/zeng-2025-cellfm]]).

## Why it matters

Sparsity, noise, and batch effects are the core motivation for unified scFMs ([[10-Summaries/zeng-2025-cellfm]]). A strong [[cell-embedding]] should integrate batches without explicit correction ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Variants and refinements

- **Pretrained model used for integration** — scGPT integrates multi-batch scRNA-seq (vs scVI, Seurat, Harmony) ([[10-Summaries/cui-2024-scgpt]]); CellFM evaluated on scIB ([[10-Summaries/zeng-2025-cellfm]]).
- **Zero-shot integration** — UCE built a 36M-cell Integrated Mega-scale Atlas with no per-dataset training ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).
- **Improved cross-platform integration over ComBat/Harmony** — Geneformer ([[10-Summaries/theodoris-2023-geneformer]]).

## Contested points

scGPT notes pretraining does **not** inherently remove batch effects, so zero-shot integration can be weak without fine-tuning ([[10-Summaries/cui-2024-scgpt]]). The review lists cross-platform batch integration among the tasks where scFMs underperform simpler tools ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[cell-embedding]], [[cell-type-annotation]]
- [[single-cell-foundation-model]], [[zero-shot-learning]]

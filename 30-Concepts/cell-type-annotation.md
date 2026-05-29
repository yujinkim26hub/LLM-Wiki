---
type: concept
title: Cell-type annotation
aliases: [cell-type annotation, cell type annotation, cell-type classification, cell annotation]
tags: [single-cell, task, benchmark]
created: 2026-05-29
updated: 2026-05-29
---

# Cell-type annotation

> Assigning a cell-type label to each cell from its transcriptome — the most common downstream benchmark for single-cell models.

## Definition

Cell-type annotation classifies cells using marker genes or, increasingly, learned [[cell-embedding|cell embeddings]] plus a classifier ([[10-Summaries/yang-2022-scbert]]). It is a prerequisite for downstream disease and microenvironment analysis ([[10-Summaries/yang-2022-scbert]]).

## Why it matters

It is the headline task on which most scFMs are evaluated, and the one where they most consistently show value ([[10-Summaries/baek-2025-scfm-review]], [[10-Summaries/zeng-2025-cellfm]]). scBERT was built specifically for annotation, arguing prior methods suffered from curated-marker dependence and poor [[batch-integration|batch handling]] ([[10-Summaries/yang-2022-scbert]]).

## Variants and refinements

- **Fine-tuned scFM classifiers** — scBERT ([[10-Summaries/yang-2022-scbert]]), scGPT (beats TOSICA, scBERT) ([[10-Summaries/cui-2024-scgpt]]), scFoundation ([[10-Summaries/hao-2024-scfoundation]]), CellFM ([[10-Summaries/zeng-2025-cellfm]]).
- **Zero-shot annotation** — UCE annotates by nearest-centroid in its universal space, including cross-species transfer ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).
- **Supervised graph transformer** — scGraphformer classifies via a learned cell–cell graph (no pretraining) ([[10-Summaries/fan-2024-scgraphformer]]).
- **Spatial label prediction/transfer** — Nicheformer predicts niche/region labels and transfers them onto dissociated data ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Contested points

Models often misclassify transcriptionally similar types (e.g. pericytes vs endothelial cells) ([[10-Summaries/fan-2024-scgraphformer]]), and the review cautions that scFM gains over simple baselines are uneven ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[cell-embedding]], [[fine-tuning]], [[zero-shot-learning]]
- [[batch-integration]], [[single-cell-foundation-model]]

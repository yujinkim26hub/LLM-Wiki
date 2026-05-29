---
type: concept
title: Single-cell foundation model (scFM)
aliases: [scFM, scFMs, single-cell foundation model, single-cell foundation models]
tags: [single-cell, foundation-model, deep-learning]
created: 2026-05-29
updated: 2026-05-29
---

# Single-cell foundation model (scFM)

> A large transformer pretrained by self-supervision on tens of millions of single-cell transcriptomes, producing reusable cell and gene representations that transfer to many downstream tasks.

## Definition

A single-cell foundation model adapts the foundation-model recipe from NLP/vision — a large model [[self-supervised-pretraining|pretrained]] on vast unlabelled data, then adapted to downstream tasks — to single-cell genomics, treating cells as "sentences" of genes ([[10-Summaries/baek-2025-scfm-review]], [[10-Summaries/cui-2024-scgpt]]). Most scFMs are [[transformer]]-based and emit [[cell-embedding|cell embeddings]] and [[gene-embedding|gene embeddings]] usable across tasks ([[10-Summaries/baek-2025-scfm-review]]).

## Why it matters

Single-cell data is noisy, sparse, and fragmented by [[batch-integration|batch effects]]; a unified pretrained model promises representations that generalise across datasets, tissues, and tasks rather than a bespoke model per study ([[10-Summaries/zeng-2025-cellfm]], [[10-Summaries/baek-2025-scfm-review]]). The bet, borrowed from language models, is that scale + self-supervision yields emergent, transferable structure ([[10-Summaries/theodoris-2023-geneformer]], [[10-Summaries/cui-2024-scgpt]]).

## Variants and refinements

The models in this wiki span the main design axes ([[10-Summaries/baek-2025-scfm-review]]):

- **scBERT** ([[10-Summaries/yang-2022-scbert]]) — one of the first; Performer + gene2vec, binned expression, aimed at [[cell-type-annotation]].
- **Geneformer** ([[10-Summaries/theodoris-2023-geneformer]]) — BERT-style, [[rank-value-encoding]], pretrained on ~30M cells; network-biology focus.
- **scGPT** ([[10-Summaries/cui-2024-scgpt]]) — generative, value-binned, ~33M cells; broad [[multi-omics]] task range.
- **scFoundation** ([[10-Summaries/hao-2024-scfoundation]]) — 100M params, continuous value embeddings, read-depth-aware pretraining on 50M+ cells.
- **CellFM** ([[10-Summaries/zeng-2025-cellfm]]) — 800M params, human-only, 100M cells, RetNet-style backbone.
- **UCE** ([[10-Summaries/rosen-2023-universal-cell-embeddings]]) — protein-embedding gene tokens enabling [[zero-shot-learning|zero-shot]], cross-species use.
- **Nicheformer** ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]) — joint dissociated + [[spatial-transcriptomics|spatial]] pretraining.
- **scGraphformer** ([[10-Summaries/fan-2024-scgraphformer]]) — a [[graph-neural-network|graph transformer]]; note it is *supervised per dataset*, not pretrained, so it is foundation-model-adjacent rather than a true scFM.

## Contested points

Independent benchmarks find zero-shot scFMs often do **not** beat task-specific baselines, with strengths in cell-type and gene-function prediction but weaknesses in expression imputation, cross-platform integration, and network inference ([[10-Summaries/baek-2025-scfm-review]]). Naively scaling pretraining data can give diminishing or negative returns — curation may matter more than raw size ([[10-Summaries/baek-2025-scfm-review]]). There is no unified benchmark and interpretability is weak ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[transformer]], [[self-supervised-pretraining]], [[expression-tokenization]] — the core machinery
- [[cell-embedding]], [[gene-embedding]] — the outputs
- [[transfer-learning]], [[fine-tuning]], [[zero-shot-learning]] — how they are applied
- [[40-Topics/single-cell-foundation-models]]

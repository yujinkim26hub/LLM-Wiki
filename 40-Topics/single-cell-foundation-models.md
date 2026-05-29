---
type: topic
title: Single-cell foundation models
aliases: [scFMs, single-cell foundation models, foundation models for single-cell]
tags: [single-cell, foundation-model, deep-learning]
created: 2026-05-29
updated: 2026-05-29
---

# Single-cell foundation models

> Large transformers pretrained by self-supervision on tens of millions of single-cell transcriptomes, intended to produce reusable cell/gene representations that transfer across tasks. This topic gathers the models, their shared machinery, and the live debate over whether they actually beat task-specific baselines.

## Core concepts

- [[single-cell-foundation-model]] — the central concept and the model roster
- [[transformer]] / [[attention-mechanism]] — the architecture
- [[self-supervised-pretraining]] / [[masked-language-modelling]] — the training objective
- [[expression-tokenization]] / [[rank-value-encoding]] — how expression becomes model input (the key design fork)
- [[cell-embedding]] / [[gene-embedding]] — the reusable outputs
- [[transfer-learning]] / [[fine-tuning]] / [[zero-shot-learning]] — how they are applied
- [[cell-type-annotation]] / [[batch-integration]] / [[in-silico-perturbation]] — the main downstream tasks
- [[scrna-seq]] / [[spatial-transcriptomics]] / [[multi-omics]] — the data modalities
- [[graph-neural-network]] — the graph-based alternative

## Sources, by sub-theme

### General-purpose scFMs (dissociated scRNA-seq)

- [[10-Summaries/yang-2022-scbert]] — **scBERT** (2022): one of the first; Performer + gene2vec, binned expression, cell-type annotation.
- [[10-Summaries/theodoris-2023-geneformer]] — **Geneformer** (2023): BERT-style, rank-value encoding, ~30M cells; network-biology + in silico perturbation.
- [[10-Summaries/cui-2024-scgpt]] — **scGPT** (2024): generative, value-binned, ~33M cells; broad multi-omics task range.
- [[10-Summaries/hao-2024-scfoundation]] — **scFoundation** (2024): 100M params, continuous value embeddings, read-depth-aware pretraining.
- [[10-Summaries/zeng-2025-cellfm]] — **CellFM** (2025): 800M params, human-only, 100M cells, RetNet-style backbone.

### Zero-shot / cross-species

- [[10-Summaries/rosen-2023-universal-cell-embeddings]] — **UCE** (2023): protein-embedding gene tokens; zero-shot, cross-species, no fine-tuning.

### Spatial

- [[10-Summaries/tejada-lapuerta-2025-nicheformer]] — **Nicheformer** (2025): joint dissociated + spatial pretraining (SpatialCorpus-110M).

### Graph-based (annotation; not pretrained)

- [[10-Summaries/fan-2024-scgraphformer]] — **scGraphformer** (2024): learns a cell–cell graph via attention; supervised per dataset (foundation-model-adjacent).

### Reviews & critique

- [[10-Summaries/baek-2025-scfm-review]] — **Baek et al. review** (2025): taxonomy of scFMs + the benchmarking critique that zero-shot scFMs often do not beat task-specific tools.

## Synthesized notes

- [[50-Notes/comparing-single-cell-foundation-models]] — cross-model comparison across architecture, tokenization, scale, and where scFMs win vs lose.

## Open questions

- Do scFMs actually outperform simpler baselines? Independent benchmarks say not reliably, and tasks split into wins (cell-type/gene-function prediction) vs losses (imputation, cross-platform integration, network inference) ([[10-Summaries/baek-2025-scfm-review]]).
- Which [[expression-tokenization]] scheme is right — rank ordering vs binning vs continuous values vs protein embeddings? No consensus ([[10-Summaries/baek-2025-scfm-review]]).
- Is "more pretraining data" helpful, or does curation matter more? Diminishing/negative returns have been reported ([[10-Summaries/baek-2025-scfm-review]]).
- How should scFMs extend to [[spatial-transcriptomics|spatial]] and [[multi-omics]] modalities, and is the field's lack of a unified benchmark holding it back? ([[10-Summaries/tejada-lapuerta-2025-nicheformer]], [[10-Summaries/baek-2025-scfm-review]])

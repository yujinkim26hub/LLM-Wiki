---
type: concept
title: Masked-gene modelling
aliases: [masked language modelling, masked language modeling, masked gene modelling, MLM, masked-gene modelling]
tags: [single-cell, foundation-model, training]
created: 2026-05-29
updated: 2026-05-29
---

# Masked-gene modelling

> The BERT-style [[self-supervised-pretraining|self-supervised]] objective in which a fraction of a cell's genes are hidden and the model is trained to predict them from the rest — the most common scFM pretraining task.

## Definition

Adapted from masked language modelling in NLP, masked-gene modelling masks a subset of gene tokens (or expression values) and reconstructs them from context ([[10-Summaries/theodoris-2023-geneformer]], [[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Why it matters

It is the workhorse objective that lets scFMs learn from unlabelled atlases at scale ([[10-Summaries/theodoris-2023-geneformer]]).

## Variants and refinements

- **Mask 15% of genes** — Geneformer ([[10-Summaries/theodoris-2023-geneformer]]); Nicheformer's 80/10/10 BERT scheme at 15% ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).
- **Mask non-zero values only** — scBERT, to stop the model exploiting dropout sparsity by predicting all zeros ([[10-Summaries/yang-2022-scbert]]).
- **Mask zero and non-zero genes (30%) with read-depth conditioning** — scFoundation's RDA task ([[10-Summaries/hao-2024-scfoundation]]).
- **Value-projection masked recovery** — CellFM masks 20% of expressed genes ([[10-Summaries/zeng-2025-cellfm]]).

## Related

- [[self-supervised-pretraining]] — the parent objective family
- [[transformer]], [[expression-tokenization]], [[single-cell-foundation-model]]

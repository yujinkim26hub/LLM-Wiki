---
type: concept
title: Self-supervised pretraining
aliases: [self-supervised pretraining, self-supervised learning, pretraining, pretraining objective]
tags: [single-cell, foundation-model, training]
created: 2026-05-29
updated: 2026-05-29
---

# Self-supervised pretraining

> Training a model on unlabelled data by hiding part of each input and asking the model to predict it — the objective that lets scFMs learn from tens of millions of cells without annotations.

## Definition

scFMs are pretrained without labels by constructing a supervisory signal from the data itself, most often [[masked-language-modelling|masked-gene modelling]] (mask a fraction of genes, predict them from context) ([[10-Summaries/theodoris-2023-geneformer]], [[10-Summaries/yang-2022-scbert]]). The pretrained model is then adapted by [[fine-tuning]] or used [[zero-shot-learning|zero-shot]] ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Why it matters

It is what makes the "foundation" possible: unlabelled single-cell atlases are vast while annotations are scarce, so a self-supervised objective unlocks the scale needed for transferable representations ([[10-Summaries/baek-2025-scfm-review]], [[10-Summaries/theodoris-2023-geneformer]]).

## Variants and refinements

- **Masked-gene modelling** — Geneformer masks 15% of genes ([[10-Summaries/theodoris-2023-geneformer]]); Nicheformer uses BERT's 80/10/10 scheme ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]); scBERT masks only non-zero values to avoid exploiting dropout sparsity ([[10-Summaries/yang-2022-scbert]]).
- **Generative gene-expression prediction** — scGPT predicts expression in confidence-ordered iterations under a bespoke attention mask, an order-free analogue of autoregressive generation ([[10-Summaries/cui-2024-scgpt]]).
- **Read-depth-aware (RDA) modelling** — scFoundation conditions on source/target total-count tokens so the model can denoise and enhance read depth ([[10-Summaries/hao-2024-scfoundation]]).
- **Binary expression prediction** — UCE predicts whether each gene is expressed, over protein-embedding tokens ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Contested points

More pretraining data is not reliably better — curation and composition can matter more than raw scale, with diminishing or negative returns reported ([[10-Summaries/baek-2025-scfm-review]]). Pretraining alone does not remove batch effects ([[10-Summaries/cui-2024-scgpt]]).

## Related

- [[masked-language-modelling]] — the most common objective
- [[fine-tuning]], [[zero-shot-learning]], [[transfer-learning]] — downstream use
- [[transformer]], [[single-cell-foundation-model]]

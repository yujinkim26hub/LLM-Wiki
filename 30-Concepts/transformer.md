---
type: concept
title: Transformer
aliases: [transformer, transformer architecture, encoder-only, encoder-decoder]
tags: [deep-learning, architecture, foundation-model]
created: 2026-05-29
updated: 2026-05-29
---

# Transformer

> The neural architecture built on the [[attention-mechanism|self-attention mechanism]] that underpins nearly all single-cell foundation models, letting every gene token attend to every other within a cell.

## Definition

A transformer processes a sequence of tokens through stacked self-attention and feed-forward blocks, learning context-dependent representations ([[10-Summaries/cui-2024-scgpt]]). In scFMs the tokens are genes (or gene–expression pairs) and the learned [[cell-embedding]] is read from a special `<cls>` token or by pooling gene tokens ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Why it matters

[[attention-mechanism|Attention]] lets the model capture [[gene-gene-interaction|gene–gene interactions]] without a predefined network, which is the mechanism scFMs use to infer regulatory structure and cell state ([[10-Summaries/yang-2022-scbert]], [[10-Summaries/cui-2024-scgpt]]).

## Variants and refinements

- **Encoder-only (BERT-style)** — Geneformer (6 layers) ([[10-Summaries/theodoris-2023-geneformer]]), Nicheformer (12 layers) ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]), scBERT ([[10-Summaries/yang-2022-scbert]]).
- **Generative / masked-iterative** — scGPT's transformer with a confidence-ordered mask ([[10-Summaries/cui-2024-scgpt]]).
- **Asymmetric encoder–decoder (MAE-style)** — scFoundation's xTrimoGene runs the encoder on non-zero genes only ([[10-Summaries/hao-2024-scfoundation]]).
- **Linear-attention variants for scalability** — scBERT's Performer ([[10-Summaries/yang-2022-scbert]]), CellFM's RetNet-style backbone ([[10-Summaries/zeng-2025-cellfm]]), scFoundation's Performer decoder ([[10-Summaries/hao-2024-scfoundation]]); these tame the O(N²) cost of attention over thousands of genes.
- **Graph transformer** — scGraphformer learns an all-pair cell–cell graph via attention ([[10-Summaries/fan-2024-scgraphformer]]).

## Related

- [[attention-mechanism]] — the core operation
- [[self-supervised-pretraining]], [[expression-tokenization]]
- [[single-cell-foundation-model]], [[graph-neural-network]]

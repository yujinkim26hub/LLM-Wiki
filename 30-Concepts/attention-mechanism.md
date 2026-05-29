---
type: concept
title: Attention mechanism
aliases: [attention mechanism, self-attention, attention]
tags: [deep-learning, architecture]
created: 2026-05-29
updated: 2026-05-29
---

# Attention mechanism

> The operation at the heart of the [[transformer]] that lets each token weigh its relevance to every other token, producing context-dependent representations.

## Definition

Self-attention computes, for each token, a weighted combination of all tokens via learned query/key/value projections ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/fan-2024-scgraphformer]]). In scFMs the tokens are genes, so attention directly captures inter-gene dependence ([[10-Summaries/yang-2022-scbert]]).

## Why it matters

Attention is how scFMs model [[gene-gene-interaction|gene–gene interactions]] without a predefined network, and attention maps are sometimes used to read out regulatory structure ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/zeng-2025-cellfm]]). Geneformer finds ~20% of self-supervised attention heads preferentially attend transcription factors ([[10-Summaries/theodoris-2023-geneformer]]).

## Variants and refinements

- **Full dense attention** — Geneformer ([[10-Summaries/theodoris-2023-geneformer]]).
- **Linear-attention approximations** for thousands of genes — Performer (scBERT ([[10-Summaries/yang-2022-scbert]]), scFoundation decoder ([[10-Summaries/hao-2024-scfoundation]])), RetNet-style retention (CellFM ([[10-Summaries/zeng-2025-cellfm]])), Taylor-expansion linear attention (scGraphformer ([[10-Summaries/fan-2024-scgraphformer]])).
- **Bespoke masked attention** — scGPT's confidence-ordered generative mask ([[10-Summaries/cui-2024-scgpt]]).

## Contested points

The review flags attention weights as an **unreliable** indicator of gene importance or network edges absent independent validation ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[transformer]], [[gene-gene-interaction]], [[gene-regulatory-network]]

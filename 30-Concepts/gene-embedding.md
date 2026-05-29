---
type: concept
title: Gene embedding
aliases: [gene embedding, gene embeddings, gene2vec, gene representation]
tags: [single-cell, foundation-model, representation]
created: 2026-05-29
updated: 2026-05-29
---

# Gene embedding

> A learned vector representing a gene, capturing its identity and context-dependent role; scFMs expose these alongside [[cell-embedding|cell embeddings]].

## Definition

Gene embeddings encode gene identity (and, after attention, context), and can be inspected to recover [[gene-gene-interaction|gene–gene relationships]] and regulatory structure ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/zeng-2025-cellfm]]). scBERT seeds gene identity with pretrained **gene2vec** embeddings used as a permutation-invariant positional signal ([[10-Summaries/yang-2022-scbert]]).

## Why it matters

Similarity between gene embeddings, and attention among gene tokens, is the route by which scFMs infer [[gene-regulatory-network|gene regulatory networks]] and gene function ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/zeng-2025-cellfm]], [[10-Summaries/hao-2024-scfoundation]]).

## Variants and refinements

- **gene2vec identity embeddings** — scBERT ([[10-Summaries/yang-2022-scbert]]).
- **Learnable gene-name embeddings summed with value embeddings** — scGPT ([[10-Summaries/cui-2024-scgpt]]) and scFoundation ([[10-Summaries/hao-2024-scfoundation]]).
- **Protein-language-model (ESM2) gene tokens** — UCE tokenises each gene by its protein product's embedding, giving a species-independent gene vocabulary ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Contested points

The review flags attention/embedding-derived gene importance as an unreliable network signal absent independent validation ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[cell-embedding]], [[expression-tokenization]]
- [[gene-gene-interaction]], [[gene-regulatory-network]]
- [[single-cell-foundation-model]]

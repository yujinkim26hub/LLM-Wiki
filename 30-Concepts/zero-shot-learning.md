---
type: concept
title: Zero-shot learning
aliases: [zero-shot learning, zero-shot, zero shot]
tags: [deep-learning, foundation-model, evaluation]
created: 2026-05-29
updated: 2026-05-29
---

# Zero-shot learning

> Applying a pretrained model to a new task or dataset with no task-specific training — using its frozen representations directly.

## Definition

In the scFM setting, zero-shot use means computing [[cell-embedding|cell embeddings]] from the frozen pretrained model and applying them (e.g. nearest-centroid classification, clustering, integration) without [[fine-tuning]] ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Why it matters

Zero-shot is the strongest form of [[transfer-learning]] and the clearest test of whether pretraining captured general structure ([[10-Summaries/baek-2025-scfm-review]]). UCE embeds cells — even from species absent in training — with no fine-tuning, retraining, or labels ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Variants and refinements

- **Zero-shot cross-species annotation and integration** — UCE ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).
- **Zero-shot gene-function prediction** — CellFM ([[10-Summaries/zeng-2025-cellfm]]).

## Contested points

Independent benchmarks find zero-shot scFMs frequently do **not** beat task-specific tools, and zero-shot performance degrades under heavy batch effects ([[10-Summaries/baek-2025-scfm-review]], [[10-Summaries/cui-2024-scgpt]]). CellFM's 800M model underperforms zero-shot on annotation, with headline numbers using a smaller variant ([[10-Summaries/zeng-2025-cellfm]]).

## Related

- [[transfer-learning]], [[fine-tuning]] — the alternative regime
- [[cell-embedding]], [[single-cell-foundation-model]]

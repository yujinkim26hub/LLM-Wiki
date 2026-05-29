---
type: concept
title: Transfer learning
aliases: [transfer learning, pretraining and fine-tuning, downstream adaptation]
tags: [deep-learning, foundation-model, training]
created: 2026-05-29
updated: 2026-05-29
---

# Transfer learning

> Reusing knowledge captured during large-scale pretraining to solve downstream tasks with little or no task-specific data — the value proposition of single-cell foundation models.

## Definition

Transfer learning leverages a model [[self-supervised-pretraining|pretrained]] on large general data, then adapts it to specific tasks, as established in NLP and vision ([[10-Summaries/theodoris-2023-geneformer]]). For scFMs this means a pretrained model is either [[fine-tuning|fine-tuned]] on a labelled task or applied [[zero-shot-learning|zero-shot]] ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/rosen-2023-universal-cell-embeddings]]).

## Why it matters

It promises predictions in data-limited settings — rare diseases, inaccessible tissues — where training from scratch fails ([[10-Summaries/theodoris-2023-geneformer]]). Geneformer showed fine-tuning on as few as ~30 examples could generalise genome-wide ([[10-Summaries/theodoris-2023-geneformer]]).

## Variants and refinements

- **Fine-tuning** — update model weights on a labelled downstream task ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/theodoris-2023-geneformer]]); CellFM uses LoRA for parameter-efficient fine-tuning ([[10-Summaries/zeng-2025-cellfm]]).
- **Zero-shot use** — apply frozen embeddings with no task training; UCE maps even unseen species into a shared space with no fine-tuning ([[10-Summaries/rosen-2023-universal-cell-embeddings]]).
- **Linear probing** — train only a lightweight classifier on frozen features ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Contested points

Independent benchmarks report zero-shot scFMs frequently fail to beat task-specific tools, so the transfer benefit is task-dependent and contested ([[10-Summaries/baek-2025-scfm-review]]). scGPT notes zero-shot performance degrades on data with heavy batch effects, requiring fine-tuning ([[10-Summaries/cui-2024-scgpt]]). Some "foundation-model" methods (scGraphformer) provide no pretraining/transfer at all and train supervised per dataset ([[10-Summaries/fan-2024-scgraphformer]]).

## Related

- [[fine-tuning]], [[zero-shot-learning]] — the two adaptation regimes
- [[self-supervised-pretraining]], [[single-cell-foundation-model]]

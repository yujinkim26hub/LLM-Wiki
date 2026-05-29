---
type: concept
title: Fine-tuning
aliases: [fine-tuning, fine tuning, finetuning, LoRA]
tags: [deep-learning, foundation-model, training]
created: 2026-05-29
updated: 2026-05-29
---

# Fine-tuning

> Adapting a pretrained model to a downstream task by continuing to train (some or all of) its weights on task-specific labelled data.

## Definition

Fine-tuning updates a [[self-supervised-pretraining|pretrained]] scFM on a labelled task such as [[cell-type-annotation]] or perturbation prediction ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/theodoris-2023-geneformer]]). Parameter-efficient variants update only small adapters ([[10-Summaries/zeng-2025-cellfm]]).

## Why it matters

Fine-tuning is the standard way scFMs are deployed and is often required to reach competitive accuracy, especially where [[zero-shot-learning|zero-shot]] use is hurt by batch effects ([[10-Summaries/cui-2024-scgpt]]). Geneformer showed fine-tuning on as few as ~30 examples generalised genome-wide ([[10-Summaries/theodoris-2023-geneformer]]).

## Variants and refinements

- **Full fine-tuning** — scGPT, Geneformer ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/theodoris-2023-geneformer]]).
- **LoRA (parameter-efficient)** — CellFM ([[10-Summaries/zeng-2025-cellfm]]).
- **Linear probing (classifier on frozen features)** — used as a lighter alternative by Nicheformer ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Contested points

CellFM's gains after fine-tuning over rivals are often only 1–3% with significance not reported ([[10-Summaries/zeng-2025-cellfm]]); the broader value of fine-tuned scFMs over simple baselines is task-dependent ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[transfer-learning]], [[zero-shot-learning]]
- [[self-supervised-pretraining]], [[single-cell-foundation-model]]

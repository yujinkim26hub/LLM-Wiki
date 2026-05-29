---
type: note
title: Comparing single-cell foundation models
question: How do the major single-cell foundation models differ, and do they actually beat task-specific methods?
tags: [single-cell, foundation-model, comparison]
created: 2026-05-29
updated: 2026-05-29
sources: ["[[10-Summaries/yang-2022-scbert]]", "[[10-Summaries/theodoris-2023-geneformer]]", "[[10-Summaries/rosen-2023-universal-cell-embeddings]]", "[[10-Summaries/cui-2024-scgpt]]", "[[10-Summaries/hao-2024-scfoundation]]", "[[10-Summaries/zeng-2025-cellfm]]", "[[10-Summaries/tejada-lapuerta-2025-nicheformer]]", "[[10-Summaries/fan-2024-scgraphformer]]", "[[10-Summaries/baek-2025-scfm-review]]"]
---

# Comparing single-cell foundation models

> The major single-cell foundation models share a recipe — a [[transformer]] [[self-supervised-pretraining|pretrained]] on tens of millions of cells — but diverge sharply on **how they tokenize expression**, **how big they are**, and **how they're applied** (zero-shot vs fine-tuned). The most important cross-cutting finding is sobering: independent benchmarks report that scFMs frequently do **not** outperform simpler task-specific methods ([[10-Summaries/baek-2025-scfm-review]]).

## At a glance

| Model | Year | Architecture | [[expression-tokenization\|Tokenization]] | Pretraining scale | Objective | Headline use |
|---|---|---|---|---|---|---|
| scBERT ([[10-Summaries/yang-2022-scbert]]) | 2022 | Performer encoder + gene2vec | binned expression | ~1.1M cells | masked **non-zero** values | [[cell-type-annotation]] |
| Geneformer ([[10-Summaries/theodoris-2023-geneformer]]) | 2023 | BERT encoder (6L) | [[rank-value-encoding\|rank-value]] | ~30M cells | masked-gene (15%) | network biology, [[in-silico-perturbation]] |
| UCE ([[10-Summaries/rosen-2023-universal-cell-embeddings]]) | 2023 | 33L transformer, ESM2 gene tokens | protein-embedding | ~36M cells, 8 species | masked binary expression | [[zero-shot-learning\|zero-shot]], cross-species |
| scGPT ([[10-Summaries/cui-2024-scgpt]]) | 2024 | generative transformer | value binning | ~33M cells | iterative generative prediction | [[multi-omics]], perturbation |
| scFoundation ([[10-Summaries/hao-2024-scfoundation]]) | 2024 | asymmetric MAE enc–dec, 100M params | continuous values | 50M+ cells | read-depth-aware masking | depth enhancement, drug response |
| CellFM ([[10-Summaries/zeng-2025-cellfm]]) | 2025 | RetNet-style, 800M params | continuous values | ~100M human cells | masked value recovery | annotation, perturbation (human-only) |
| Nicheformer ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]) | 2025 | BERT encoder (12L) | rank-value + context tokens | 110M cells (57M sc + 54M [[spatial-transcriptomics\|spatial]]) | masked-gene (15%) | spatial niche/region tasks |
| scGraphformer ([[10-Summaries/fan-2024-scgraphformer]]) | 2024 | [[graph-neural-network\|graph transformer]] | — (per dataset) | **none** (supervised) | supervised cross-entropy | annotation |

## Argument

**1. Tokenization is the defining fork.** The schemes split four ways: rank ordering (Geneformer, Nicheformer) trades magnitude for batch-robustness ([[10-Summaries/theodoris-2023-geneformer]]); binning (scBERT, scGPT) keeps relative magnitude ([[10-Summaries/yang-2022-scbert]], [[10-Summaries/cui-2024-scgpt]]); continuous value embeddings (scFoundation, CellFM) preserve full resolution and are explicitly pitched as fixing binning's information loss ([[10-Summaries/hao-2024-scfoundation]], [[10-Summaries/zeng-2025-cellfm]]); and protein-embedding tokens (UCE) drop a fixed gene vocabulary entirely to enable cross-species use ([[10-Summaries/rosen-2023-universal-cell-embeddings]]). The review confirms there is no agreed winner ([[10-Summaries/baek-2025-scfm-review]]).

**2. Scale grew fast, but "more data" is contested.** Parameter/cell counts climbed from scBERT's ~1.1M cells (2022) to CellFM's 800M params on ~100M cells (2025) ([[10-Summaries/yang-2022-scbert]], [[10-Summaries/zeng-2025-cellfm]]); scFoundation even reports a scaling law ([[10-Summaries/hao-2024-scfoundation]]). Yet the review cites studies showing diminishing or negative returns from naive data scaling — curation may beat raw size ([[10-Summaries/baek-2025-scfm-review]]). Tellingly, CellFM's 800M model underperforms its own smaller variant zero-shot on annotation ([[10-Summaries/zeng-2025-cellfm]]).

**3. Application regime divides the field.** Most models are designed to be [[fine-tuning|fine-tuned]] ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/theodoris-2023-geneformer]]); UCE is the standout [[zero-shot-learning|zero-shot]] + cross-species model, embedding even unseen species with no fine-tuning ([[10-Summaries/rosen-2023-universal-cell-embeddings]]). scGPT notes zero-shot use degrades under batch effects ([[10-Summaries/cui-2024-scgpt]]).

**4. Modality is the frontier.** Most are dissociated-scRNA-only; scGPT adds [[multi-omics]] ([[10-Summaries/cui-2024-scgpt]]) and Nicheformer adds [[spatial-transcriptomics|spatial]], showing dissociated-only models cannot recover spatial microenvironment structure even with more spatial data ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

**5. Not everything labelled "foundation model" is one.** scGraphformer is a [[graph-neural-network|graph transformer]] trained **supervised per dataset** with no pretraining or transferable checkpoint — foundation-model-adjacent, not an scFM ([[10-Summaries/fan-2024-scgraphformer]]).

**6. The bottom line (synthesis).** Across all of the above, the load-bearing caveat is the review's: zero-shot scFMs often do **not** beat task-specific tools, with wins concentrated in cell-type and gene-function prediction and losses in expression imputation, cross-platform [[batch-integration]], and gene-network inference; [[attention-mechanism|attention]]-derived networks are an unreliable signal ([[10-Summaries/baek-2025-scfm-review]]). The promise is real, the universal win is not yet demonstrated.

## What would change my mind

- A **unified, community benchmark** showing one or more scFMs consistently beating task-specific methods across the full task suite (not just cell-type annotation) would overturn the "no universal win" conclusion ([[10-Summaries/baek-2025-scfm-review]]).
- Evidence that one [[expression-tokenization]] scheme dominates across tasks would collapse fork (1).
- A demonstrated, reproducible scaling law tying pretraining size to downstream gains (beyond validation loss) would settle fork (2).

## Related

- [[40-Topics/single-cell-foundation-models]]
- [[single-cell-foundation-model]], [[expression-tokenization]], [[transfer-learning]]
- [[40-Topics/virtual-perturbation-screening]] — scFMs as perturbation predictors, alongside [[in-silico-perturbation]] tools

---
title: Summaries
description: One page per source — the LLM's distillation of each.
---

# Summaries

One page per ingested source. Each summary captures the thesis, key claims, methods/evidence, surprising bits, and the entities, concepts, and topics the source touches — with a `source:` link back to the raw input in `00-Sources/`.

### Single-cell foundation models

- [[yang-2022-scbert]] — **scBERT** (2022): early Performer + gene2vec model for cell-type annotation; binned expression.
- [[theodoris-2023-geneformer]] — **Geneformer** (2023): BERT on ~30M cells with rank-value encoding; transfer learning + in silico perturbation for network biology.
- [[rosen-2023-universal-cell-embeddings]] — **UCE** (2023): protein-embedding gene tokens give zero-shot, cross-species cell embeddings with no fine-tuning.
- [[cui-2024-scgpt]] — **scGPT** (2024): generative multi-omics scFM (value binning); annotation, integration, perturbation, GRN inference.
- [[hao-2024-scfoundation]] — **scFoundation** (2024): 100M-param MAE-style model, continuous values, read-depth-aware pretraining.
- [[zeng-2025-cellfm]] — **CellFM** (2025): 800M-param, human-only model pretrained on 100M cells (RetNet backbone).
- [[tejada-lapuerta-2025-nicheformer]] — **Nicheformer** (2025): joint single-cell + spatial foundation model (SpatialCorpus-110M).
- [[fan-2024-scgraphformer]] — **scGraphformer** (2024): graph transformer learning a cell–cell network for annotation (supervised, not pretrained).
- [[baek-2025-scfm-review]] — **review** (2025): taxonomy of scFMs and the critique that zero-shot scFMs often don't beat task-specific tools.

### Virtual perturbation

- [[yang-2023-genki]] — **GenKI** (2023): variational graph autoencoder for in silico gene knockout from scRNA-seq; outperforms scTenifoldKnk on simulated ground truth.
- [[zhu-2026-stat3-dentinogenesis]] — single-cell virtual perturbation (CellOracle + scTenifoldKnk) nominates STAT3 as the odontoblast-lineage regulator, then confirms it experimentally; mechanism is STAT3→WNT2B→canonical Wnt.

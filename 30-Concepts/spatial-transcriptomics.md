---
type: concept
title: Spatial transcriptomics
aliases: [spatial transcriptomics, spatial omics, spatial]
tags: [single-cell, spatial, modality]
created: 2026-05-29
updated: 2026-05-29
---

# Spatial transcriptomics

> Measuring gene expression while preserving each cell's physical location in tissue, capturing the microenvironment that dissociated scRNA-seq discards.

## Definition

Spatial transcriptomics profiles cells in situ (e.g. MERFISH, Xenium, CosMx, ISS), retaining tissue coordinates and neighbourhood structure ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]). Tissue composition depends on the local cellular microenvironment, which dissociation destroys ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Why it matters

It is the frontier modality for scFMs: Nicheformer shows dissociated-only models cannot recover spatial microenvironment structure even with far more spatial data, motivating joint single-cell + spatial pretraining ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]). The review names spatial omics as a key extension axis for the field ([[10-Summaries/baek-2025-scfm-review]]).

## Variants and refinements

- **Joint dissociated + spatial pretraining** — Nicheformer's SpatialCorpus-110M (57M dissociated + 54M spatial cells); downstream tasks include niche/region prediction and neighbourhood composition/density regression ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Contested points

Nicheformer does not use spatial coordinates during pretraining (expression only), so spatial context is captured only implicitly; encoding neighbour graphs is flagged as future work ([[10-Summaries/tejada-lapuerta-2025-nicheformer]]).

## Related

- [[single-cell-foundation-model]], [[transformer]]
- [[scrna-seq]] — the dissociated counterpart
- [[40-Topics/single-cell-foundation-models]]

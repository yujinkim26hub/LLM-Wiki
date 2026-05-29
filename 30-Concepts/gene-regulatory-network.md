---
type: concept
title: Gene regulatory network (GRN)
aliases: [GRN, gene regulatory network, regulatory network inference]
tags: [single-cell, transcription-factor, method]
created: 2026-05-29
updated: 2026-05-29
---

# Gene regulatory network (GRN)

> A model of the regulatory wiring of a cell — which transcription factors control which target genes — inferred from single-cell expression (and sometimes chromatin) data.

## Definition

A GRN represents transcription factors and their target genes as a network of regulatory edges, reconstructed from single-cell data via co-expression plus motif/enhancer evidence ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). It is the shared substrate that fate-mapping, regulon-specificity, and perturbation tools all operate on ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Why it matters

The GRN is what makes a *virtual* knockout possible: once the regulatory wiring is estimated, a perturbation can be propagated through it to predict downstream effects without an experiment ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). It is therefore the linchpin of [[in-silico-perturbation]] — and its quality bounds the prediction's reliability ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Variants and refinements

- **[[scenic]]** ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]) — reconstructs the GRN as motif-refined regulons (TF + targets) and scores their activity; also used to read GRNs out of scFoundation embeddings ([[10-Summaries/hao-2024-scfoundation]]).
- **[[celloracle]]** ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]) — builds a GRN (optionally with ATAC-seq) for vector-field perturbation simulation.
- **[[sctenifoldknk]]** ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]) — constructs wild-type vs. virtual-KO GRNs and compares them.
- **PC-regression GRN + VGAE** ([[10-Summaries/yang-2023-genki]]) — GenKI infers a single-cell GRN by PC-regression (top ~15% edges) and learns it with a [[graph-neural-network|variational graph autoencoder]].
- **scFM gene embeddings / attention** ([[10-Summaries/cui-2024-scgpt]]) — [[single-cell-foundation-model|foundation models]] infer regulatory relationships from [[gene-embedding|gene-embedding]] similarity and [[attention-mechanism|attention]] maps (scGPT validated vs Reactome/ChIP-Atlas; CellFM vs ChIP-Atlas/TRRUST/KEGG) ([[10-Summaries/zeng-2025-cellfm]]).

## Contested points

GRNs in these pipelines are inferred from **static** transcriptomes and assume the inferred edges propagate perturbations **linearly**, both of which can diverge from biological reality with feedback and compensation ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). For scFM-derived networks specifically, the review warns that [[attention-mechanism|attention]]/embedding-based edges are an **unreliable** signal absent independent validation, and lists gene-network inference among the tasks where scFMs underperform dedicated methods ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[in-silico-perturbation]] — what a GRN enables
- [[scenic]], [[celloracle]], [[sctenifoldknk]], [[cellrank]] — tools that build or use GRNs
- [[gene-gene-interaction]], [[gene-embedding]] — how scFMs surface regulatory structure
- [[single-cell-foundation-model]], [[graph-neural-network]]
- [[40-Topics/virtual-perturbation-screening]]

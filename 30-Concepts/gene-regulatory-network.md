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

- **[[scenic]]** ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]) — reconstructs the GRN as motif-refined regulons (TF + targets) and scores their activity.
- **[[celloracle]]** ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]) — builds a GRN (optionally with ATAC-seq) for vector-field perturbation simulation.
- **[[sctenifoldknk]]** ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]) — constructs wild-type vs. virtual-KO GRNs and compares them.

## Contested points

GRNs in these pipelines are inferred from **static** transcriptomes and assume the inferred edges propagate perturbations **linearly**, both of which can diverge from biological reality with feedback and compensation ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Related

- [[in-silico-perturbation]] — what a GRN enables
- [[scenic]], [[celloracle]], [[sctenifoldknk]], [[cellrank]] — tools that build or use GRNs
- [[40-Topics/virtual-perturbation-screening]]

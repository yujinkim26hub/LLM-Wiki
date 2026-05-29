---
type: topic
title: Virtual perturbation screening
aliases: [in silico screening, prediction-to-verification, virtual knockout screening]
tags: [single-cell, gene-regulatory-network, in-silico-perturbation, method]
created: 2026-05-29
updated: 2026-05-29
---

# Virtual perturbation screening

> Using single-cell gene regulatory networks to *simulate* gene knockouts and predict cell-fate consequences, as a cheap screening step that nominates candidate regulators for targeted experimental validation — the "prediction-to-verification" workflow.

## Core concepts

- [[in-silico-perturbation]] — simulating a gene knockout on a GRN to predict fate change; the central method of this topic
- [[gene-regulatory-network]] — the inferred regulatory wiring all perturbation tools operate on
- [[celloracle]] — vector-field perturbation simulation
- [[sctenifoldknk]] — wild-type vs. virtual-KO network comparison
- [[scenic]] — regulon specificity scoring to nominate lineage-specific TFs
- [[cellrank]] — fate mapping / driver-gene identification
- [[graph-neural-network]] — VGAE backbone behind GenKI's virtual knockout

## Sources, by sub-theme

### Worked example: virtual screen + experimental confirmation

- [[10-Summaries/zhu-2026-stat3-dentinogenesis]] — nominates STAT3 by intersecting CellRank and SCENIC, predicts its knockout effect with CellOracle + scTenifoldKnk, then confirms with knockdown, pharmacology, and a conditional-knockout mouse. A template for the full prediction-to-verification loop.

### Virtual-knockout methods

- [[10-Summaries/yang-2023-genki]] — **GenKI**: a variational graph autoencoder learns expression + an inferred GRN; zeroing a gene's edges and measuring the latent KL shift ranks knockout-responsive genes. Unsupervised, scRNA-seq-only, benchmarked as more accurate than scTenifoldKnk on simulated ground truth.

### Adjacent: foundation models as perturbation predictors

- [[10-Summaries/theodoris-2023-geneformer]], [[10-Summaries/cui-2024-scgpt]], [[10-Summaries/hao-2024-scfoundation]], [[10-Summaries/zeng-2025-cellfm]] — [[single-cell-foundation-model|scFMs]] increasingly predict perturbation responses as a downstream task (see [[40-Topics/single-cell-foundation-models]]).

## Synthesized notes

- *(none yet)*

## Open questions

- How reliably do linear, static-GRN virtual knockouts predict experimental outcomes when feedback and compensation are strong? Zhu et al. flag the gap but don't quantify it ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).
- When do CellOracle and scTenifoldKnk agree vs. diverge, and which should be trusted on disagreement? Only their agreement is reported so far ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).
- GenKI ranks knockout-responsive genes but cannot predict the *direction* (up/down) of the effect, nor model over-expression ([[10-Summaries/yang-2023-genki]]). How do GRN-propagation tools (CellOracle), network-comparison tools (scTenifoldKnk), VGAE tools (GenKI), and scFMs compare head-to-head on the same knockout? Not yet established.

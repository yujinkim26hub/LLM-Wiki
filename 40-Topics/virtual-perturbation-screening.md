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

## Sources, by sub-theme

### Worked example: virtual screen + experimental confirmation

- [[10-Summaries/zhu-2026-stat3-dentinogenesis]] — nominates STAT3 by intersecting CellRank and SCENIC, predicts its knockout effect with CellOracle + scTenifoldKnk, then confirms with knockdown, pharmacology, and a conditional-knockout mouse. A template for the full prediction-to-verification loop.

## Synthesized notes

- *(none yet)*

## Open questions

- How reliably do linear, static-GRN virtual knockouts predict experimental outcomes when feedback and compensation are strong? Zhu et al. flag the gap but don't quantify it ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).
- When do CellOracle and scTenifoldKnk agree vs. diverge, and which should be trusted on disagreement? Only their agreement is reported so far ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

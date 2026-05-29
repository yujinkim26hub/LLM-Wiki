---
type: concept
title: scTenifoldKnk
aliases: [scTenifoldKnk virtual knockout]
tags: [single-cell, gene-regulatory-network, in-silico-perturbation, tool]
created: 2026-05-29
updated: 2026-05-29
---

# scTenifoldKnk

> A virtual-knockout tool that builds wild-type and "virtual KO" single-cell gene regulatory networks for a target gene and identifies the genes whose regulation differs between them, quantifying a knockout's effect at the network level.

## Definition

scTenifoldKnk executes a virtual knockout of a target gene by constructing wild-type and "virtual KO" single-cell GRNs and comparing them to find differentially regulated genes, thereby quantifying perturbation effects at the network level ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). It is a form of [[in-silico-perturbation]] (Osorio et al., Patterns 2022) and is typically paired with GO/KEGG over-representation analysis on the perturbed gene set ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Why it matters

Where [[celloracle]] reads a knockout as a shift in fate trajectory, scTenifoldKnk reads it as a concrete list of dysregulated genes — useful for nominating the *mechanism*, not just the *direction*, of a perturbation ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). Using both gives a virtual knockout convergent support from two independent network methods ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Examples

- Virtual STAT3 knockout via scTenifoldKnk showed significant changes in multiple development-related genes, with enrichment in the Wnt signalling pathway — corroborating the CellOracle vector-field result and pointing to the eventual STAT3→WNT2B mechanism ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Related

- [[in-silico-perturbation]] — the general method
- [[celloracle]] — the complementary tool used alongside it in Zhu et al.
- [[gene-regulatory-network]]
- [[40-Topics/virtual-perturbation-screening]]

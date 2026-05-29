---
type: concept
title: CellOracle
aliases: [Cell Oracle]
tags: [single-cell, gene-regulatory-network, in-silico-perturbation, tool]
created: 2026-05-29
updated: 2026-05-29
---

# CellOracle

> A tool that simulates transcription-factor knockouts on a single-cell gene regulatory network and predicts the resulting shift in the cellular "vector field" — i.e. how cell-fate trajectories would change.

## Definition

CellOracle infers a [[gene-regulatory-network]] from single-cell RNA-seq (and optionally ATAC-seq) data, then simulates the impact of perturbing a specific transcription factor on the transcriptional network and the cellular vector field, predicting altered fate trajectories and potential differentiation blockade ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). It is one instantiation of [[in-silico-perturbation]] (Kamimoto et al., Nature 2023).

## Why it matters

It connects a GRN model directly to the geometry of differentiation: a knockout becomes a visible redirection of the predicted migration of cell states across the trajectory ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). In Zhu et al., a virtual STAT3 knockout shifted the vector field away from the pre-odontoblast fate, providing the central computational evidence that STAT3 drives odontoblast commitment ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Contested points

Zhu et al. explicitly caution that CellOracle is "a powerful screening tool rather than a definitive predictor," for three reasons: its GRN is inferred from **static** transcriptomic data; it assumes **linear** perturbation propagation (missing non-linear feedback and compensation); and the simulated knockout is **complete ablation**, not the partial loss-of-function typical of physiological conditions ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Examples

- Virtual STAT3 knockout in human odontogenic single-cell data redirected the developmental vector field away from pre-odontoblasts ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Related

- [[in-silico-perturbation]] — the general method CellOracle implements
- [[sctenifoldknk]] — an alternative virtual-knockout tool, used alongside it in Zhu et al.
- [[gene-regulatory-network]], [[cellrank]]
- [[40-Topics/virtual-perturbation-screening]]

---
type: concept
title: CellRank (fate mapping)
aliases: [CellRank, CellRank 2, fate mapping, absorption probability]
tags: [single-cell, trajectory-inference, fate-mapping, tool]
created: 2026-05-29
updated: 2026-05-29
---

# CellRank (fate mapping)

> A tool that models single-cell differentiation as a stochastic process to estimate each cell's probability of reaching each terminal state, identifying initial/terminal states and the genes that drive fate decisions.

## Definition

CellRank performs directed fate mapping by estimating the **absorption probability** of cells toward potential terminal states, identifying initial and terminal cell states and visualising the fate landscape (e.g. via circular projection) ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). From the fate dynamics it also nominates **driver genes** for a given lineage ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). The version cited is CellRank 2 (Weiler et al., Nature Methods 2024).

## Why it matters

It quantifies *where a cell is going*, not just where it sits — turning a static landscape into directed fate probabilities and a lineage-specific driver-gene list ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). In Zhu et al., CellRank confirmed EFNB2+ mesenchymal cells as the multipotent starting state and supplied the driver-gene list that, intersected with [[scenic]] RSS, nominated [[stat3]] ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Examples

- CellRank circular projection identified EFNB2+ mesenchymal cells as the multipotent starting state with fate probabilities correlated to lineage markers; its driver-gene table fed the STAT3 nomination ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Related

- [[scenic]] — the complementary regulon-specificity evidence intersected with CellRank
- [[gene-regulatory-network]], [[in-silico-perturbation]]
- [[40-Topics/virtual-perturbation-screening]]
- [[40-Topics/tooth-development]]

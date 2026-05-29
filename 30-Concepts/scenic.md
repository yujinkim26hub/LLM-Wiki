---
type: concept
title: SCENIC (regulon specificity score)
aliases: [SCENIC, pySCENIC, regulon specificity score, RSS, regulon activity]
tags: [single-cell, gene-regulatory-network, transcription-factor, tool]
created: 2026-05-29
updated: 2026-05-29
---

# SCENIC (regulon specificity score)

> A framework that reconstructs transcription-factor regulons from single-cell data and scores each regulon's activity per cell, with a regulon specificity score (RSS) that flags which transcription factors are specifically active in a given cell population.

## Definition

SCENIC builds gene co-expression modules, refines them into **regulons** (a transcription factor plus its predicted targets) by integrating motif/enhancer information, and evaluates per-cell regulon activity with **AUCell** ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). The **regulon specificity score (RSS)** is then computed for each TF regulon to quantify how specifically it is active across distinct cell subgroups ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). The scalable implementation used is **pySCENIC** (Van de Sande et al., Nature Protocols 2020).

## Why it matters

RSS converts a GRN into a ranked list of *lineage-specific* transcription factors — the candidate master regulators of a cell state ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). It is one of the two evidence streams (the other being [[cellrank]] fate probabilities) that Zhu et al. intersected to nominate [[stat3]] as the odontoblast-lineage regulator ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Examples

- An RSS rank plot showed multiple TF regulons with exceptionally high specific activity in the pre-odontoblast subgroup; intersecting this with CellRank driver genes singled out STAT3 ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Related

- [[gene-regulatory-network]] — SCENIC reconstructs one as regulons
- [[cellrank]] — the complementary fate-mapping evidence intersected with RSS
- [[in-silico-perturbation]] — the downstream step that tests the nominated TF
- [[40-Topics/virtual-perturbation-screening]]

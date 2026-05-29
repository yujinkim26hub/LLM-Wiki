---
type: concept
title: Gene–gene interaction
aliases: [gene-gene interaction, gene–gene interaction, gene interactions, gene co-expression]
tags: [single-cell, gene-regulation]
created: 2026-05-29
updated: 2026-05-29
---

# Gene–gene interaction

> Dependencies between genes — co-expression, regulation, epistasis — that scFMs aim to capture in their representations.

## Definition

Gene–gene interactions are the latent dependencies among genes that prior annotation methods struggled to leverage ([[10-Summaries/yang-2022-scbert]]). scFMs model them implicitly through [[attention-mechanism|attention]] and [[gene-embedding|gene-embedding]] similarity ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/zeng-2025-cellfm]]).

## Why it matters

Capturing interactions is the bridge from raw expression to [[gene-regulatory-network|regulatory-network]] inference and to richer cell-state representations ([[10-Summaries/cui-2024-scgpt]], [[10-Summaries/hao-2024-scfoundation]]). scBERT cited the failure to exploit latent gene–gene information as a weakness of prior methods it set out to fix ([[10-Summaries/yang-2022-scbert]]).

## Contested points

Whether attention/embedding similarity faithfully recovers true interactions is contested — the review flags these signals as unreliable network indicators ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[gene-regulatory-network]], [[gene-embedding]], [[attention-mechanism]]
- [[single-cell-foundation-model]]

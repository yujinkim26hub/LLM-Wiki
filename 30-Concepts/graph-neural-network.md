---
type: concept
title: Graph neural network (GNN)
aliases: [graph neural network, GNN, graph transformer, variational graph autoencoder, VGAE]
tags: [deep-learning, architecture, graph]
created: 2026-05-29
updated: 2026-05-29
---

# Graph neural network (GNN)

> A neural network that operates on graph-structured data — cells-as-nodes or genes-as-nodes — used in single-cell analysis to model relational structure rather than treating cells/genes independently.

## Definition

GNNs propagate information along graph edges to learn node representations. In single-cell work they model cell–cell or gene–gene relations; a graph transformer learns the graph itself via attention rather than relying on a predefined one ([[10-Summaries/fan-2024-scgraphformer]]).

## Why it matters

It addresses a limitation of token-transformer scFMs that treat cells independently: relational structure (microenvironment, regulatory wiring) can be modelled explicitly ([[10-Summaries/fan-2024-scgraphformer]], [[10-Summaries/baek-2025-scfm-review]]).

## Variants and refinements

- **Graph transformer (learned cell–cell graph)** — scGraphformer learns an all-pair cell–cell network from expression with a linear-attention approximation; trained *supervised per dataset*, not pretrained ([[10-Summaries/fan-2024-scgraphformer]]).
- **Variational graph autoencoder (VGAE)** — GenKI fits a VGAE to a single-cell [[gene-regulatory-network]] and ranks genes by the latent shift after a virtual knockout ([[10-Summaries/yang-2023-genki]]).

## Contested points

All-pair attention is memory-heavy, forcing mini-batching that degrades graph fidelity above ~50K cells ([[10-Summaries/fan-2024-scgraphformer]]). The review treats GNN/graph-prior models mainly as a future direction relative to mainstream token-transformer scFMs ([[10-Summaries/baek-2025-scfm-review]]).

## Related

- [[transformer]], [[gene-regulatory-network]], [[in-silico-perturbation]]
- [[single-cell-foundation-model]]
- [[40-Topics/virtual-perturbation-screening]]

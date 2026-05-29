---
title: Concepts
description: Definitions of the methods, terms, and ideas that recur across sources.
---

# Concepts

Definitions: methods, terms, theories, ideas. Each concept page gives the shortest correct definition, why it matters, variants across sources, and contested points — all cited back to the summaries that support them.

### Single-cell foundation models — core ideas

- [[single-cell-foundation-model]] — large self-supervised transformers over millions of cells
- [[transformer]] — the architecture; [[attention-mechanism]] — its core operation
- [[self-supervised-pretraining]] — learning from unlabelled cells; [[masked-language-modelling]] — the usual objective
- [[expression-tokenization]] — turning expression into tokens (the key design fork); [[rank-value-encoding]] — the rank-ordering scheme
- [[cell-embedding]] / [[gene-embedding]] — the reusable model outputs
- [[transfer-learning]] / [[fine-tuning]] / [[zero-shot-learning]] — how scFMs are applied
- [[cell-type-annotation]] / [[batch-integration]] — the main downstream tasks
- [[gene-gene-interaction]] — dependencies scFMs aim to capture
- [[scrna-seq]] / [[spatial-transcriptomics]] / [[multi-omics]] — data modalities
- [[graph-neural-network]] — the graph-based alternative (graph transformers, VGAE)

### Methods — virtual perturbation & gene networks

- [[in-silico-perturbation]] — simulating a gene knockout on a GRN to predict fate change
- [[celloracle]] — TF-knockout simulation as a shift in the cellular vector field
- [[sctenifoldknk]] — wild-type vs. virtual-KO single-cell GRN comparison
- [[scenic]] — regulon reconstruction + regulon specificity score (RSS)
- [[cellrank]] — fate mapping / absorption probabilities / driver genes
- [[gene-regulatory-network]] — the inferred regulatory wiring perturbation tools operate on

### Biology — tooth development

- [[stat3]] — JAK/STAT transcription factor; key regulator of odontoblast differentiation
- [[wnt-beta-catenin-signalling]] — canonical Wnt pathway; STAT3's effector via WNT2B
- [[dentinogenesis]] — dentine formation and odontoblast differentiation

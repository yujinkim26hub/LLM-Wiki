---
type: summary
title: "scBERT as a large-scale pretrained deep language model for cell type annotation of single-cell RNA-seq data"
source: "[[00-Sources/papers/single-cell-foundation-models/s42256-022-00534-z]]"
source_kind: paper
author: "Fan Yang*; Wenchuan Wang*; Fang Wang*; Yuan Fang; Duyu Tang; Junzhou Huang; Hui Lu (corresponding); Jianhua Yao (corresponding)"
published: 2022
ingested: 2026-05-29
doi: "10.1038/s42256-022-00534-z"
journal: "Nature Machine Intelligence"
tags: [single-cell, foundation-model, transformer, cell-type-annotation, self-supervised, performer]
concepts: [[[30-Concepts/single-cell-foundation-model]], [[30-Concepts/transformer]], [[30-Concepts/attention-mechanism]], [[30-Concepts/self-supervised-pretraining]], [[30-Concepts/masked-language-modelling]], [[30-Concepts/transfer-learning]], [[30-Concepts/gene-embedding]], [[30-Concepts/cell-embedding]], [[30-Concepts/expression-tokenization]], [[30-Concepts/fine-tuning]], [[30-Concepts/batch-integration]], [[30-Concepts/cell-type-annotation]], [[30-Concepts/gene-gene-interaction]], [[30-Concepts/scrna-seq]]]
topics: ["[[40-Topics/single-cell-foundation-models]]"]
---

**Citation:** Yang et al. (2022) — *scBERT as a large-scale pretrained deep language model for cell type annotation of single-cell RNA-seq data* — *Nature Machine Intelligence*. [DOI](https://doi.org/10.1038/s42256-022-00534-z)

# scBERT (Yang 2022)

> scBERT adapts the BERT pretrain-then-fine-tune paradigm to single-cell RNA-seq, learning general gene–gene interaction "syntax" by self-supervised pretraining on ~1.1M unlabelled cells from PanglaoDB, then fine-tuning a lightweight classifier head for cell type annotation. By using a Performer encoder (linear-attention) it ingests the full >16,000-gene profile without HVG selection or PCA, yielding state-of-the-art, batch-robust, gene-level-interpretable annotation. It is one of the earliest applications of Transformer foundation-model methodology to scRNA-seq.

## Key claims
- Existing cell-type annotation methods fail because they depend on curated marker-gene lists, mishandle batch effects, and cannot exploit latent gene–gene interactions; scBERT addresses all three.
- Self-supervised pretraining on large unlabelled scRNA-seq lets the model learn domain-irrelevant gene-expression patterns that transfer across datasets and remove batch effects without explicit batch correction.
- Feeding the whole genome (no HVG selection, no dimensionality reduction) preserves gene-level interpretability and lets discriminative genes "surface by themselves."
- scBERT beats marker-based (SCINA, Garnett, scSorter), correlation-based (Seurat v4, SingleR, scmap, CellID) and ML-based (SciBet, scNym) SOTA on most of 9 benchmark datasets.
- The model is robust to class imbalance and can flag low-confidence cells as "unassigned," enabling novel cell-type discovery.
- Attention weights provide per-gene interpretability; top-attention genes recover known markers (LOXL4 for alpha, ADCYAP1 for beta cells) and propose candidate novel markers.

## Methods / evidence
- **Architecture.** A Performer encoder (linear-complexity Transformer approximating full attention via random-feature maps) replaces BERT's vanilla Transformer to scale past the 512-token limit to >16,000 (up to >20,000) gene inputs. 6 Performer layers, 10 attention heads each.
- **Input embeddings = expression embedding + gene embedding (element-wise sum), à la BERT token+position.**
  - *Gene embedding*: each gene's identity is encoded by a pretrained **gene2vec** vector (200-dim), acting as a *relative* embedding capturing co-expression semantics — replaces BERT's positional embedding, since gene order is permutation-invariant (cf. TaBERT for tabular data).
  - *Expression embedding (tokenization)*: continuous expression values are **discretized by binning** (bag-of-words / term-frequency analogy), reducing noise and giving discrete tokens; binned values are projected to 200-dim. Note: this is *binned-expression* tokenization, NOT rank-value/ordering encoding (that is Geneformer's scheme).
- **Pretraining objective.** Masked-language-modelling analogue: randomly mask **non-zero** expression values and reconstruct them with cross-entropy loss over the remaining genes. Non-zero masking chosen to avoid the model trivially predicting all zeros given scRNA-seq dropout sparsity.
- **Pretraining data.** PanglaoDB: 209 human scRNA-seq datasets, 74 tissues, **1,126,580 cells**, no labels used. (A separate large heart dataset of 451,513 cells used for some pretraining/sensitivity analyses.)
- **Fine-tuning.** Pretrained Performer output (200-dim per gene) → 1D convolution → 3-layer NN classifier; cross-entropy label loss. Query cells below probability 0.5 for all known types are labelled "unassigned."
- **Benchmarks.** 9 datasets, 17 organs/tissues, >50 cell types, >500,000 cells; Drop-seq/10X/SMART-seq/Sanger-Nuclei. Tasks: intra-dataset 5-fold CV (Zheng68K PBMC: scBERT F1=0.691, acc=0.759 vs best-other F1=0.659, acc=0.704); cross-cohort leave-one-dataset-out on pancreas (Baron/Muraro/Segerstolpe/Xin; acc 0.992 vs scNym 0.904); cross-organ; class-imbalance (acc 0.840, F1 0.826); novel-cell discovery on MacParland liver (novel-class acc 0.329 vs SciBet/scmap 0.174); interpretability via attention + enrichment (scBERT embedding ARI 0.95 vs raw-expression 0.87).
- **Weight of evidence.** Strong and broad — many datasets, platforms, organs, 5-fold CV, statistical tests, multiple downstream evaluations and ablations (Extended Data Fig. 1). Single-task focus (annotation), one organism (human).

## Surprising or load-bearing bits
- scBERT with *all reported marker genes deleted* already matches the best marker-dependent methods on Zheng68K — evidence it learns non-marker expression patterns.
- Only 30% of the Zheng68K reference cells already suffice to outperform all competitors at fine-tuning time.
- Authors explicitly authored this before any other scRNA-seq Transformer: "to the best of our knowledge there is currently no research on applying Transformer architectures to gene expression data analysis" — i.e., a pioneering scFM.
- The gene2vec relative-embedding-as-position trick is the load-bearing design choice that makes order-free gene "sentences" work.

## Concepts touched
- [[30-Concepts/single-cell-foundation-model]] — scBERT is an early exemplar: large-scale self-supervised pretraining on scRNA-seq, then transfer.
- [[30-Concepts/transformer]] — backbone, but with the Performer linear-attention variant for scalability.
- [[30-Concepts/attention-mechanism]] — multi-head self-attention (10 heads/6 layers); attention weights double as interpretability signal.
- [[30-Concepts/self-supervised-pretraining]] — pretrains on 1.1M unlabelled PanglaoDB cells.
- [[30-Concepts/masked-language-modelling]] — masks non-zero expression bins and reconstructs them (cross-entropy reconstruction loss).
- [[30-Concepts/transfer-learning]] — pretrain-then-fine-tune paradigm transferred from NLP/BERT.
- [[30-Concepts/gene-embedding]] — uses gene2vec vectors as per-gene identity embeddings (relative-position role).
- [[30-Concepts/cell-embedding]] — produces a single-cell-specific "scBERT embedding" usable for clustering/downstream analysis.
- [[30-Concepts/expression-tokenization]] — discretizes continuous expression by binning into tokens (NOT rank-value).
- [[30-Concepts/fine-tuning]] — adds 1D-conv + 3-layer classifier head for supervised annotation.
- [[30-Concepts/batch-integration]] — pretraining yields batch-robust representations without explicit batch correction.
- [[30-Concepts/cell-type-annotation]] — the sole downstream task targeted and benchmarked.
- [[30-Concepts/gene-gene-interaction]] — claims to capture long-range gene–gene interactions via global receptive field.
- [[30-Concepts/scrna-seq]] — the data modality; whole-genome (>20k genes) input without HVG/PCA.

## Open questions
- Binning continuous expression sacrifices data resolution; the authors flag that gene-expression embedding could be optimized further.
- Gene interactions are really networks (GRNs, signalling pathways); scBERT does not inject this prior — the authors suggest a [[30-Concepts/graph-neural-network]] / Transformer-for-graphs successor could better model them.
- Non-zero-only masking may underutilize sparse single-cell data; a single-cell-tailored masking strategy is an open optimization.
- Demonstrated only for human and primarily for one downstream task (annotation); generality to other tasks/organisms is asserted but not shown.

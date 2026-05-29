---
type: summary
title: "Large-scale foundation model on single-cell transcriptomics"
source: "[[00-Sources/papers/single-cell-foundation-models/s41592-024-02305-7]]"
source_kind: paper
author: "Minsheng Hao, Jing Gong, Xin Zeng, Chiming Liu, Yucheng Guo, Xingyi Cheng, Taifeng Wang, Jianzhu Ma (corresponding), Xuegong Zhang (corresponding), Le Song (corresponding)"
published: 2024
ingested: 2026-05-29
doi: "10.1038/s41592-024-02305-7"
journal: "Nature Methods"
tags: [single-cell, foundation-model, scrna-seq, transformer, self-supervised, drug-response, perturbation-prediction]
concepts: ["[[30-Concepts/single-cell-foundation-model]]", "[[30-Concepts/transformer]]", "[[30-Concepts/attention-mechanism]]", "[[30-Concepts/self-supervised-pretraining]]", "[[30-Concepts/masked-language-modelling]]", "[[30-Concepts/expression-tokenization]]", "[[30-Concepts/cell-embedding]]", "[[30-Concepts/gene-embedding]]", "[[30-Concepts/transfer-learning]]", "[[30-Concepts/fine-tuning]]", "[[30-Concepts/in-silico-perturbation]]", "[[30-Concepts/cell-type-annotation]]", "[[30-Concepts/gene-regulatory-network]]", "[[30-Concepts/batch-integration]]", "[[30-Concepts/scrna-seq]]"]
topics: ["[[40-Topics/single-cell-foundation-models]]"]
---

**Citation:** Hao et al. (2024) — *Large-scale foundation model on single-cell transcriptomics* — *Nature Methods*. [DOI](https://doi.org/10.1038/s41592-024-02305-7)

# scFoundation (Hao 2024)

> scFoundation (also "xTrimoscFoundationα") is a 100-million-parameter transformer-based foundation model covering ~20,000 genes, pretrained on over 50 million human single-cell transcriptomic profiles via a read-depth-aware (RDA) masked-prediction task. Its asymmetric encoder–decoder architecture (xTrimoGene) encodes raw continuous expression scalars without discretization, and its embeddings serve a wide range of downstream tasks — read-depth enhancement, cancer drug-response prediction, single-cell drug sensitivity, perturbation prediction, cell-type annotation, and gene-module/GRN inference — mostly without fine-tuning, achieving state-of-the-art results.

## Key claims
- A single self-supervised pretrained model with 100M parameters over 19,264 genes generalizes across many single-cell tasks, acting as a true "foundation model" for transcriptomics.
- Validation loss follows a **scaling law**: power-law decline in MSE loss with increasing parameters/FLOPs (3M → 10M → 100M); the 100M model surpasses xTrimoGene-scale equivalents of scBERT, scGPT, Geneformer, and scVI on the loss benchmark.
- Encoding **continuous expression values directly** (learnable value embeddings) beats the binned/discretized expression used by prior models (cited as scBERT-style), validated by ablation.
- The **RDA pretraining task** lets the model harmonize cells of different sequencing read depths and perform read-depth enhancement (imputation-like) at inference by setting target counts T > source counts S — with no dataset-specific fine-tuning.
- Embeddings learned on single cells transfer to **bulk** gene expression (cancer drug-response IC50 prediction) and across the bulk↔single-cell gap (drug sensitivity classification).
- Gene-level context embeddings from the decoder are cell-specific and improve graph-based perturbation prediction (GEARS) and enable gene-module / GRN inference.

## Methods / evidence
- **Model scale:** 100M parameters; 19,264 genes (HGNC human protein-coding + common mitochondrial genes); trained models at 3M / 10M / 100M to demonstrate scaling.
- **Pretraining data:** >50 million human scRNA-seq cells aggregated from GEO, Single Cell Portal, HCA, hECA, DISCO, EMBL-EBI, etc.; spanning 100+ tissue types across normal, disease and tumor states. Normalized profiles converted back to raw counts where possible; QC kept cells with >200 expressed genes; validation set = 100,000 held-out cells.
- **Architecture (xTrimoGene):** asymmetric encoder–decoder, analogous to a masked autoencoder (MAE) in vision, built for scRNA-seq sparsity.
  - *Embedding module:* converts each continuous expression scalar into a learnable value embedding (weighted sum over a learned embedding set) added to a learnable gene-name embedding — no discretization.
  - *Encoder:* vanilla transformer blocks; processes **only nonzero, nonmasked** genes (+T and S indicator tokens) — about 10% of full gene length — using full self-attention.
  - *Decoder:* a **Performer** (kernel-approximated attention) over the full ~19,266-length sequence (encoder outputs concatenated with zero and mask embeddings); a shared MLP projects decoder outputs to predicted expression scalars.
- **RDA (read-depth-aware) pretraining task:** an extension of masked language modeling. A hierarchical Bayesian downsampling generates a low-read-depth (or unchanged) input variant of each raw cell; two total-count indicators T ("target," raw) and S ("source," input) are appended as tokens. 30% of gene expressions (both zero and nonzero) are masked; regression loss computed at masked positions between predicted and raw values.
- **Downstream tasks & evidence (weight: strong, breadth across 6+ task families):**
  - *Read-depth enhancement / imputation:* halved MAE/MRE on downsampled data; beat MAGIC, SAVER, scImpute, scVI on pancreatic-islet clustering (NMI/ARI/SIL) once T/S > ~1; better SIL than scVI on Zheng68K — all without fine-tuning.
  - *Batch integration:* read-depth-enhanced embeddings fed to BBKNN improved cross-batch cell mapping.
  - *Cancer drug response (bulk):* plugged into DeepCDR; higher IC50 PCC across most drugs/cancer types; drug-blind leave-one-out gains (e.g., PHA-793887 PCC 0.07→0.73).
  - *Single-cell drug sensitivity:* plugged into SCAD; higher AUC for all four hard drugs (>0.2 AUC gain for NVP-TAE684 and sorafenib).
  - *Perturbation prediction:* gene context embeddings as nodes in a cell-specific co-expression graph for GEARS; lower MSE on top-20 DE genes, best on 0/2-unseen two-gene perturbations, beat GEARS and CPA; better genetic-interaction (synergy/suppressor) classification.
  - *Cell-type annotation:* one-layer encoder fine-tune + MLP head; highest macro-F1 on Zheng68K and Segerstolpe vs CellTypist, scBERT, scANVI, ACTINN, Scanpy, SingleCellNet; gains concentrated in rare cell types.
  - *Gene module / GRN inference:* gene embeddings cluster into cell-type-specific modules; with SCENIC, recovered known regulators (KLF6 monocyte, SPIB B-cell, MXD4 CD8+ T-cell).

## Surprising or load-bearing bits
- When T = S (read depth unaltered), scFoundation underperforms smaller imputation methods like SAVER; its advantage only appears once read depth is *increased* (T/S > 1), plateauing above ~3.5×. The authors note this "no-gain-when-depth-unchanged" effect was also reported independently (Kedzierska et al. 2023, the zero-shot-limits preprint).
- The authors explicitly **recommend using cell/gene embeddings rather than predicted expression values**, because pretraining labels have high dropout and the pretraining loss is not driven to zero.
- The model deliberately models **only read depth** as the technical variation it harmonizes, leaving other batch effects (donor sex, treatment, cell cycle) to downstream cooperative methods (BBKNN, SCAD).
- Continuous (non-binned) expression encoding is framed as a key differentiator from earlier transformer scFMs.

## Concepts touched
- [[30-Concepts/single-cell-foundation-model]] — scFoundation is a canonical large-scale instance (100M params, ~20k genes, 50M+ cells).
- [[30-Concepts/transformer]] — backbone of both encoder (vanilla) and decoder (Performer variant).
- [[30-Concepts/attention-mechanism]] — full softmax attention in encoder; kernel-approximated (Performer) attention in decoder for the long full-gene sequence.
- [[30-Concepts/self-supervised-pretraining]] — pretrained without labels on 50M+ cells.
- [[30-Concepts/masked-language-modelling]] — RDA extends masked-value prediction (30% masking of zero and nonzero genes).
- [[30-Concepts/expression-tokenization]] — encodes raw continuous expression scalars as learnable value embeddings, explicitly avoiding discretization/binning.
- [[30-Concepts/cell-embedding]] — pooled encoder output used for clustering, drug response, annotation.
- [[30-Concepts/gene-embedding]] — gene-name embeddings + decoder context embeddings used for modules/GRNs and perturbation graphs.
- [[30-Concepts/transfer-learning]] — single-cell-pretrained embeddings transfer to bulk and to drug-response tasks.
- [[30-Concepts/fine-tuning]] — most tasks need none; cell-type annotation fine-tunes only one encoder layer plus an MLP head.
- [[30-Concepts/in-silico-perturbation]] — combined with GEARS to predict single- and two-gene perturbation outcomes.
- [[30-Concepts/cell-type-annotation]] — top macro-F1 on Zheng68K and Segerstolpe benchmarks.
- [[30-Concepts/gene-regulatory-network]] — gene embeddings + SCENIC recover known cell-type regulators.
- [[30-Concepts/batch-integration]] — read-depth-enhanced embeddings + BBKNN improve cross-batch mapping (read depth only).
- [[30-Concepts/scrna-seq]] — the data modality the model is built for.

## Open questions
- Pretraining data, though near-exhaustive for public human scRNA-seq at curation time, may still under-represent human organ development and health states.
- Pretraining is computationally expensive and needs further efficiency work.
- The model is transcriptome-only — no genomic, epigenomic, or multi-omic data (ATAC-seq integration named as future work).
- Unsupervised pretraining ignores rich cell metadata that could link molecular features to phenotypes.
- More effective pretraining tasks and the effect of dataset characteristics on performance remain open (cited to Kedzierska et al. 2023).

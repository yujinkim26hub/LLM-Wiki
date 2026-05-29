---
type: summary
title: "Universal Cell Embeddings: A Foundation Model for Cell Biology"
source: "[[00-Sources/papers/single-cell-foundation-models/2023.11.28.568918v1.full]]"
source_kind: paper
author: "Yanay Rosen*, Yusuf Roohani*, Ayush Agarwal, Leon Samotorčan, Tabula Sapiens Consortium, Stephen R. Quake† (corresponding), Jure Leskovec† (corresponding)"
published: 2023
ingested: 2026-05-29
doi: "10.1101/2023.11.28.568918"
journal: "bioRxiv (preprint)"
tags: [single-cell, foundation-model, cell-embedding, zero-shot, cross-species, protein-language-model, scrna-seq]
concepts: [[[30-Concepts/single-cell-foundation-model]], [[30-Concepts/transformer]], [[30-Concepts/self-supervised-pretraining]], [[30-Concepts/gene-embedding]], [[30-Concepts/cell-embedding]], [[30-Concepts/zero-shot-learning]], [[30-Concepts/batch-integration]], [[30-Concepts/cell-type-annotation]], [[30-Concepts/expression-tokenization]], [[30-Concepts/attention-mechanism]], [[30-Concepts/transfer-learning]]]
topics: ["[[40-Topics/single-cell-foundation-models]]"]
---

**Citation:** Rosen et al. (2023) — *Universal Cell Embeddings: A Foundation Model for Cell Biology* — *bioRxiv*. [DOI](https://doi.org/10.1101/2023.11.28.568918)

# UCE (Rosen 2023)

> Universal Cell Embedding (UCE) is a 650M-parameter transformer foundation model that maps any single cell — from any tissue or species, including species never seen in training — into one shared 1280-dimensional latent space with no fine-tuning, no cell-type labels, and no input preprocessing. It achieves species-independence by tokenizing each gene via the ESM2 protein-language-model embedding of the protein it encodes (a "bag of RNA" → protein-token representation), rather than relying on a fixed gene vocabulary. Trained self-supervised on ~36M cells across 8 species, UCE produces a zero-shot embedding whose emergent organization recovers known biology (cell-type identity across tissues, developmental lineages, germ-layer origin, Cell Ontology structure) and supports annotation transfer, novel-cell-type discovery, and disease analysis.

## Key claims
- UCE is a single-cell foundation model trained in a **completely self-supervised** manner with no cell-type or dataset annotations, on a corpus spanning human and 7 other species.
- It offers a **unified latent space** in which any cell maps regardless of tissue or species, capturing biological variation despite cross-dataset experimental noise (batch effects).
- A core universality property: **any new cell, from any organism, maps to the space with no additional data labeling, model training, or fine-tuning** — a true zero-shot capability.
- Applied to build the **Integrated Mega-scale Atlas (IMA)** of ~36M cells, >1,000 named cell types, hundreds of experiments, dozens of tissues, 8 species.
- The embedding space shows **emergent behavior** — recovering biology it was never trained for, e.g. identifying developmental lineages and embedding data from novel species absent from training.
- In zero-shot embedding quality on the held-out, unreleased **Tabula Sapiens v2**, UCE beats the next-best zero-shot method (Geneformer) by 9.0% overall, 10.6% on biological conservation, 7.4% on batch correction; it even slightly outperforms dataset-specific fine-tuned methods scVI and scArches.
- UCE can embed species **entirely outside the training set** (green monkey, naked mole rat, chicken) and match their annotated cell types to IMA centroids with high agreement, including no birds in training.

## Methods / evidence
- **Gene representation (no fixed gene vocabulary).** Each protein-coding gene g is tokenized by the **ESM2** protein language model embedding (dp = 5120) of the protein(s) it encodes — averaged over all proteins coded by g. Because genes are represented by their protein products, UCE can represent any gene from any species without needing homolog mappings, and works on genes never seen in training.
- **Cell representation ("bag of RNA").** From a cell's counts, UCE draws a weighted multi-set of 1024 non-unique expressed genes, sampled with replacement, with probability proportional to log-normalized expression (an expression-weighted sampling rather than a strict rank-value ordering). Genes are grouped by chromosome (special per-chromosome/species start+end tokens), sorted by genomic position, chromosomes ordered randomly, and a **CLS token** prepended. This "cell sentence" feeds a transformer; the final-layer CLS embedding (demb = 1280) is the cell embedding.
- **Architecture.** 33-layer transformer, **>650M parameters**, multi-head self-attention with sinusoidal positional embeddings; protein-embedding gene tokens compressed via a single-layer MLP before the transformer.
- **Self-supervised objective (masked expression prediction).** During training a random 20% of expressed genes are masked; query genes (masked-expressed + sampled non-expressed) each have their protein token concatenated with the cell's CLS embedding and passed to an MLP that predicts whether the gene is expressed. Trained with **binary cross-entropy** over balanced expressed/non-expressed query sets. This is a masking-based self-supervised scheme, but the prediction target is binary expression status rather than reconstructing a masked token's value.
- **Pretraining scale.** >300 datasets, ~36M cells (33.9M human+mouse from the CZI CellXGene Census v2023-07-10 across 285 datasets; 2.3M cells from 28 datasets across 8 species: human, mouse, mouse lemur, zebrafish, pig, rhesus macaque, crab-eating macaque, western clawed frog). Trained 40 days on 24× A100 80GB GPUs. No highly-variable-gene selection; minimal filtering only. Weights and code released openly.
- **Emergent organization (validation by held-out labels).** Cell-type labels were never used in training but used post-hoc: human macrophages across 73 tissues — 72% of tissue-specific centroids were nearest a macrophage centroid from another tissue (93% within 3 nearest). Embedding distances grow monotonically with Cell Ontology tree distance up to ~5 hops. Germ-layer colocalization: 90/97 mesoderm, 46/56 endoderm, 22/30 ectoderm centroids nearest a same-germ-layer neighbor; a classifier predicts germ layer of held-out cell types at >80% accuracy.
- **Zero-shot benchmarking.** On Tabula Sapiens v2 (581,430 cells, 27 tissues, 167 batches, 162 cell types), UCE has the top silhouette score for 67% of cell types; outperforms Geneformer on 80%, tGPT on 73%, scGPT on 83%. UCE correctly embeds B cells where Geneformer and scGPT fail (B-cell silhouette 93% higher than scGPT, 25% higher than Geneformer).
- **Cross-species zero-shot.** Green monkey: 13/17 cell-type centroids nearest the correct cross-species cell type (17/17 within 3 nearest). Naked mole rat: 17/24. Chicken heart: 12/15 within 2 nearest — no birds in training.
- **Downstream applications.** (1) Annotation transfer via a simple logistic classifier on UCE embeddings (Immune Cell Atlas → Tabula Sapiens v2 B-cell subtypes; human lymph node → green monkey). (2) Novel-cell-type function discovery: a Norn-cell (kidney erythropoietin-producing, fibroblast-like) classifier applied across all 36M IMA cells found Norn-like cells in gonad, heart, lung, validated by markers (Dcn, Lpar1, Col1a1, Cxcl12, Cfh). (3) Disease analysis: Norn-like lung cells differ between IPF, COPD, and control (e.g. Epas1:Egln1 transcript ratio significantly higher in COPD predicted Norn cells, p=0.035).

## Surprising or load-bearing bits
- **Zero-shot generalization to entirely new species with no fine-tuning** is the headline result and a stringent test of emergence: because genes are represented by ESM2 protein embeddings, UCE needs no shared gene vocabulary or homolog table, so even a bird (chicken) — no avian data in training — maps coherently into the same space as mammalian cell types.
- Zero-shot UCE embeddings **rival or beat fine-tuned, dataset-specific methods** (scVI, scArches), inverting the usual expectation that per-dataset training is needed for clean integration.
- The authors explicitly contrast the **"bag of RNA" / protein-product tokenization** with prior scFMs (Geneformer, scGPT) that "represent cells using ordered lists of gene tokens," arguing that modeling expression as a text-like sequence of gene symbols is inefficient and rests on inaccurate biological assumptions.
- Emergent recovery of the **Cell Ontology** hierarchy and **germ-layer (developmental lineage)** structure from a model that only ever solved a binary "is this gene expressed?" task.
- Stated limitation framing: by aligning to the reference genome, current scFMs (UCE included) **discard genetic-variation and RNA-splicing information at the transcript level**; the authors position UCE as a step toward a future "Virtual Cell."

## Concepts touched
- [[30-Concepts/single-cell-foundation-model]] — UCE is a from-scratch single-cell foundation model for gene expression, defining the universal-embedding flavor of scFM.
- [[30-Concepts/transformer]] — 33-layer, 650M-parameter transformer backbone over the "cell sentence."
- [[30-Concepts/attention-mechanism]] — multi-head self-attention over protein-token gene sequence with sinusoidal positional embeddings.
- [[30-Concepts/self-supervised-pretraining]] — trained with no annotations on ~36M cells; binary expressed/not-expressed prediction objective.
- [[30-Concepts/masked-language-modelling]] — masks 20% of expressed genes and predicts their expression status, an MLM-style self-supervised scheme adapted to expression.
- [[30-Concepts/gene-embedding]] — genes embedded via ESM2 protein-product embeddings, giving a species-agnostic, vocabulary-free gene representation.
- [[30-Concepts/cell-embedding]] — the final-layer CLS token gives a 1280-d universal cell embedding.
- [[30-Concepts/expression-tokenization]] — "bag of RNA" expression-weighted sampling of expressed genes (with replacement) into protein tokens, ordered by genomic location.
- [[30-Concepts/rank-value-encoding]] — UCE contrasts its expression-weighted protein-token sampling against rank-ordered gene-token encodings used by Geneformer/scGPT.
- [[30-Concepts/zero-shot-learning]] — UCE's defining capability: embed new datasets and new species with no retraining or fine-tuning.
- [[30-Concepts/fine-tuning]] — UCE is explicitly designed to avoid fine-tuning; benchmarked against fine-tuned scVI/scArches.
- [[30-Concepts/transfer-learning]] — a universal embedding lets a classifier trained on one atlas transfer to new datasets and species.
- [[30-Concepts/batch-integration]] — emergent batch mixing while preserving cell type; benchmarked on batch-correction metrics, beating prior methods.
- [[30-Concepts/cell-type-annotation]] — zero-shot annotation via nearest-centroid matching and lightweight logistic classifiers on the embedding.
- [[30-Concepts/scrna-seq]] — the input modality; UCE consumes raw scRNA-seq counts without HVG selection.

## Open questions
- The objective is binary expression prediction rather than value reconstruction or rank prediction; how much does the choice of objective vs. the protein-token gene representation drive the cross-species generalization?
- Benchmarks rely on coarse cell-type labels; the authors flag that finer-resolution benchmarks are needed to characterize scaling — the depth of UCE's "universality" at sub-type resolution is unverified.
- UCE discards transcript-level information (genetic variation, RNA splicing) by aligning to the reference genome; impact on representation fidelity is unquantified.
- Cross-species matching accuracy degrades for more distant species (e.g. naked mole rat 17/24; chicken needs the 2 nearest neighbors), leaving open how far the protein-embedding strategy extrapolates phylogenetically.
- This is a non-peer-reviewed bioRxiv preprint; benchmark comparisons to Geneformer/scGPT were run by the UCE authors.

---
type: summary
title: "Nicheformer: a foundation model for single-cell and spatial omics"
source: "[[00-Sources/papers/single-cell-foundation-models/s41592-025-02814-z]]"
source_kind: paper
author: "Alejandro Tejada-Lapuerta (co-first); Anna C. Schaar (co-first); Robert Gutgesell; Giovanni Palla; Lennard Halle; Mariia Minaeva; Larsen Vornholz; Leander Dony; Francesca Drummer; Till Richter; Mojtaba Bahrami; Fabian J. Theis (corresponding)"
published: 2025
ingested: 2026-05-29
doi: "10.1038/s41592-025-02814-z"
journal: "Nature Methods"
tags: [single-cell, foundation-model, spatial, transformer, masked-language-modelling, spatial-transcriptomics, multimodal]
concepts: ["[[30-Concepts/single-cell-foundation-model]]", "[[30-Concepts/transformer]]", "[[30-Concepts/attention-mechanism]]", "[[30-Concepts/self-supervised-pretraining]]", "[[30-Concepts/masked-language-modelling]]", "[[30-Concepts/transfer-learning]]", "[[30-Concepts/cell-embedding]]", "[[30-Concepts/expression-tokenization]]", "[[30-Concepts/rank-value-encoding]]", "[[30-Concepts/fine-tuning]]", "[[30-Concepts/batch-integration]]", "[[30-Concepts/cell-type-annotation]]", "[[30-Concepts/scrna-seq]]", "[[30-Concepts/spatial-transcriptomics]]", "[[30-Concepts/gene-gene-interaction]]"]
topics: ["[[40-Topics/single-cell-foundation-models]]"]
---

**Citation:** Tejada-Lapuerta et al. (2025) — *Nicheformer: a foundation model for single-cell and spatial omics* — *Nature Methods*. [DOI](https://doi.org/10.1038/s41592-025-02814-z)

# Nicheformer (Tejada-Lapuerta 2025)

> Nicheformer is a transformer-based single-cell foundation model that is pretrained jointly on dissociated scRNA-seq AND image-based spatial transcriptomics (SpatialCorpus-110M, >110M cells across human and mouse). By learning a shared representation across both modalities, it can predict spatially dependent properties — niche/region labels, neighborhood cell-type composition and local cell density — and, critically, *transfer spatial context onto dissociated scRNA-seq cells that were never measured in space*. The central claim is that models trained on dissociated data alone (Geneformer, scGPT, UCE) cannot recover the complexity of spatial microenvironments; multiscale (dissociated + spatial) training is necessary.

## Key claims

- A foundation model trained jointly on dissociated and spatial transcriptomics learns cell representations that capture spatial context, unlike dissociated-only foundation models.
- Models trained only on dissociated data fail to recover spatial microenvironment complexity — even when given 3× the amount of spatial data, dissociated-only training underperforms on every spatial downstream task. This is a data-*diversity* effect, not a cell-count effect (all variants trained on equal cell counts).
- Data diversity matters across organisms too: models trained on one organism perform poorly on the missing organism, supporting the value of broad cross-species, cross-tissue coverage.
- Nicheformer (fine-tuned and linear-probing) systematically beats Geneformer, scGPT, UCE (dissociated-only FMs), CellPLM (a spatial-aware FM trained on far less data), and embedding baselines scVI and PCA, on the newly designed spatial tasks.
- Spatial annotations (cell type, niche, region) can be transferred from spatial reference data onto unseen dissociated scRNA-seq cells via a simple linear layer on the frozen embedding — enriching nonspatial data with spatial context.
- Nicheformer's attention is hierarchically organized: early layers attend broadly, middle layers sharply attend to gene tokens (likely coexpression / biological relationships), final layers focus on contextual (metadata) tokens. Some heads consistently prioritize highly expressed genes across tissues/modalities; others specialize by modality.
- Attention patterns capture biology: in male vs. female MERFISH mouse brain (AVPV region), layers 9–10 show elevated maximum attention to sexually dimorphic genes, and several high-attention-difference genes are *not* the most differentially expressed — i.e., the model picks up gene–gene interaction structure beyond raw expression differences.

## Methods / evidence

**Architecture.** Encoder-only transformer (BERT-style): 12 transformer encoder blocks, 16 attention heads/layer, token dimensionality 512, feed-forward hidden size 1,024, context length 1,500 tokens, learnable positional embeddings, ~49.3M parameters. PAD tokens are masked out of attention. Cell embedding = mean of the last-layer gene token outputs (contextual tokens deliberately *excluded* from the aggregation, see Surprising bits).

**Tokenization.** Geneformer-style rank-value encoding: each cell is normalized to 10,000 counts, then expression is divided by a *technology-specific* nonzero-mean vector (one combined vector for all dissociated assays; separate vectors for MERFISH / Xenium / CosMx / ISS to correct technology-dependent count biases), then genes are ranked descending and emitted as an ordered sequence of gene tokens (non-expressed genes dropped). Three contextual tokens — `<ASSAY>`, `<MODALITY>` (dissociated vs. spatial), `<ORGANISM>` (human vs. mouse) — are prepended. Sequences truncated/padded to 1,500. Shared vocabulary of 20,310 gene tokens built from orthologs across species: 16,981 orthologous + 3,178 human-specific + 151 mouse-specific.

**Pretraining objective.** Masked language modeling (MLM), BERT schema: 15% of tokens masked (gene and contextual tokens, never PAD); of masked positions, 80% → `<MASK>`, 10% → random token, 10% unchanged; cross-entropy on recovering the original token. Only expression data are used in pretraining — spatial coordinates are NOT fed to the model. Trained ~10 days on 12× Nvidia A100 40GB (3 nodes × 4 GPUs), bfloat16, AdamW, effective batching with gradient accumulation.

**SpatialCorpus-110M (pretraining corpus).** >110M cells, human + mouse, not integrated (raw curated counts preserved):
- *Dissociated:* 57.06M cells, 4 technologies, 293 datasets, 49 tissues, ~6,067 donors. Built on the CZ CellXGene Census (33.47M cells) extended with ~180 datasets via GEO, sfaira, and the Human Cell Atlas; 17 solid organs + 18 cell lines + tissue junctions.
- *Spatial:* 53.83M cells, 4 image-based technologies (MERFISH/Vizgen MERSCOPE, 10x Xenium, Nanostring CosMx, in situ sequencing/ISS), 60 datasets, 15 tissues, 158 individuals, >10,600 tissue sections. Brain dominates (~60.5%), then lung (~10%). 55% of spatial cells unannotated; ~64% healthy / ~32% cancer samples (to capture tumor–immune microenvironments).

**Evaluation modes.** Linear probing (frozen embedding + trained linear head — isolates intrinsic signal) and fine-tuning (transformer weights updated). Linear probing already beats baselines; fine-tuning improves further.

**Spatial downstream tasks (newly designed) and benchmark datasets.**
- *Spatial label prediction* (classification, macro-F1, with prediction-uncertainty estimates): cell type, tissue niche, and tissue region — on MERFISH mouse brain (33 cell types, 8 niche/division labels, 17 region labels) and CosMx human liver (zonation niches). Nicheformer fine-tuned achieves highest macro-F1; PCA with many components is competitive on region prediction.
- *Spatial label transfer:* map MERFISH-defined cell-type / niche / region labels onto unseen dissociated scRNA-seq motor cortex cells; correctly selects the 9 of 33 motor-cortex cell types with low uncertainty.
- *Neighborhood composition* (regression, mean absolute error): predict the cell-type-proportion vector of each cell's local neighborhood (radius chosen for ~10/20/50/100 neighbors), on MERFISH mouse brain, CosMx human liver, CosMx human lung. Fine-tuned Nicheformer beats Geneformer, scGPT, UCE, CellPLM, scVI, PCA. Accuracy correlates with cell-type abundance and regional specificity.
- *Neighborhood cell density* (regression, MAE / R²): predict local cell count per neighborhood, on Xenium human lung and Xenium human colon (healthy vs. cancer). Nicheformer linear-probing recovers higher density in tumor regions; scVI and PCA baselines give negative R² (worse than the mean).

**Weight of evidence.** Strong: ablations across data splits (dissociated-only, single-organism, 1%/3% subsets) with ANOVA/FDR and t-tests against the best competing method; embedding-stability tests under rank-shuffling and gene-dropout (stable up to ~20% perturbation); attention analysis validated with Mann–Whitney U / Benjamini–Hochberg. Weaker: liver tasks underperform due to low liver abundance in the corpus; benchmarks are this paper's own newly designed tasks (no community-standard spatial FM benchmark yet exists).

## Surprising or load-bearing bits — the single-cell + spatial joint modeling angle

- **The core thesis is that joint dissociated+spatial pretraining is *necessary*, not just helpful.** Dissociated-only training fails even at 3× the spatial data volume — spatial context is a distinct signal that must be in the training distribution.
- **Spatial context is predictable from transcriptome alone.** Nicheformer never sees spatial coordinates during pretraining (only expression + assay/modality/organism tokens), yet recovers niche, region, composition and density — implying a cell's gene-expression profile encodes its microenvironment.
- **Bidirectional bridge between modalities.** The headline application is enriching plain scRNA-seq with spatial annotations transferred from spatial references — turning the model into a tool that "predicts the spatial context of dissociated cells."
- **Contextual (metadata) tokens are excluded from the final cell embedding.** The modality token's output had the highest norm and dominated/biased the representation toward its modality, breaking cross-modality label transfer — analogous to high-norm "register" tokens in vision transformers. Dropping them fixes transfer but may discard useful context (flagged as future work).
- **High-attention genes ≠ most differentially expressed genes**, suggesting the model captures gene–gene interaction/coexpression structure rather than just marginal expression.

## Concepts touched

- [[30-Concepts/single-cell-foundation-model]] — Nicheformer *is* a single-cell foundation model, extended to spatial omics (the first to pretrain jointly at scale on dissociated + image-based spatial data).
- [[30-Concepts/transformer]] — 12-layer encoder-only transformer, 16 heads, d=512, FFN=1024, ~49.3M params, 1,500-token context.
- [[30-Concepts/attention-mechanism]] — multihead self-attention; analyzed for hierarchical layer roles and biologically meaningful (sex-specific) head behavior.
- [[30-Concepts/self-supervised-pretraining]] — pretrained on unlabeled expression data via masking, no human labels.
- [[30-Concepts/masked-language-modelling]] — BERT-style MLM objective, 15% masking with 80/10/10 replacement, cross-entropy token recovery.
- [[30-Concepts/transfer-learning]] — pretrain-then-adapt; spatial knowledge transferred to dissociated cells and across tissues/species.
- [[30-Concepts/cell-embedding]] — 512-d cell representation = mean of last-layer gene tokens (contextual tokens excluded).
- [[30-Concepts/expression-tokenization]] — each cell encoded as an ordered sequence of gene tokens plus assay/modality/organism context tokens.
- [[30-Concepts/rank-value-encoding]] — Geneformer-style rank tokenization, here with technology-specific nonzero-mean normalization; shown robust to ~20% rank shuffling / gene dropout.
- [[30-Concepts/fine-tuning]] — evaluated in both frozen linear-probing and full fine-tuning settings; fine-tuning gives the best spatial-task performance.
- [[30-Concepts/batch-integration]] — rank encoding + contextual tokens used to integrate strong batch/technology effects across dissociated and spatial assays without explicit latent-space integration.
- [[30-Concepts/cell-type-annotation]] — spatial cell-type label prediction and label transfer onto dissociated data.
- [[30-Concepts/scrna-seq]] — dissociated modality (57M cells); the target of spatial-context transfer.
- [[30-Concepts/spatial-transcriptomics]] — image-based spatial modality (53.8M cells, MERFISH/Xenium/CosMx/ISS); the source of spatial context and the focus of all downstream tasks.
- [[30-Concepts/gene-gene-interaction]] — attention analysis suggests heads encode gene–gene/coexpression relationships (high-attention genes are not the most DE genes).

## Open questions

- Spatial coordinates are deliberately *not* used during pretraining; the authors propose future versions encoding spatial neighbor graphs via graph-transformer architectures. Would explicit spatial input beat the current expression-only approach?
- Performance is bottlenecked by cell-type / tissue abundance in the corpus (liver underperforms). How much does this generalize beyond brain-heavy data?
- Excluding contextual tokens from the embedding fixes modality bias but discards information — is there a "selective integration" strategy that keeps useful context?
- Benchmarks are the authors' own newly designed spatial tasks; the discussion explicitly calls for community-standard spatial FM benchmarks before claims can be rigorously compared.
- No scaling-law characterization yet; the "compute per sample" observation (1% subset beating 3% subset in liver) is anecdotal and warrants systematic study.

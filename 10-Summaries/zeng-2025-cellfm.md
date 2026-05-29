---
type: summary
title: "CellFM: a large-scale foundation model pre-trained on transcriptomics of 100 million human cells"
source: "[[00-Sources/papers/single-cell-foundation-models/s41467-025-59926-5]]"
source_kind: paper
author: "Yuansong Zeng; Jiancong Xie; Ningyuan Shangguan; Zhuoyi Wei; Wenbing Li; Yun Su; Shuangyu Yang; Chengyang Zhang; Jinbo Zhang; Nan Fang; Hongyu Zhang; Yutong Lu; Huiying Zhao (corresponding); Jue Fan (corresponding); Weijiang Yu (corresponding); Yuedong Yang (corresponding)"
published: 2025
ingested: 2026-05-29
doi: "10.1038/s41467-025-59926-5"
journal: "Nature Communications"
tags: [single-cell, foundation-model, scrna-seq, retnet, value-projection, cell-annotation, perturbation-prediction]
concepts: ["[[30-Concepts/single-cell-foundation-model]]", "[[30-Concepts/transformer]]", "[[30-Concepts/attention-mechanism]]", "[[30-Concepts/self-supervised-pretraining]]", "[[30-Concepts/masked-language-modelling]]", "[[30-Concepts/fine-tuning]]", "[[30-Concepts/transfer-learning]]", "[[30-Concepts/gene-embedding]]", "[[30-Concepts/cell-embedding]]", "[[30-Concepts/expression-tokenization]]", "[[30-Concepts/zero-shot-learning]]", "[[30-Concepts/batch-integration]]", "[[30-Concepts/cell-type-annotation]]", "[[30-Concepts/gene-regulatory-network]]", "[[30-Concepts/in-silico-perturbation]]", "[[30-Concepts/gene-gene-interaction]]", "[[30-Concepts/scrna-seq]]"]
topics: ["[[40-Topics/single-cell-foundation-models]]"]
---

**Citation:** Zeng et al. (2025) — *CellFM: a large-scale foundation model pre-trained on transcriptomics of 100 million human cells* — *Nature Communications*. [DOI](https://doi.org/10.1038/s41467-025-59926-5)

# CellFM (Zeng 2025)

> CellFM is a single-cell foundation model with 800 million parameters pre-trained on ~100 million human cells — twice the data and roughly eightfold the parameters of the largest prior single-species models. To make training at this scale tractable, it abandons the standard Transformer for a modified RetNet variant (ERetNet) with linear-complexity attention, and it is built on Huawei's MindSpore framework and Ascend NPUs. The central claim is that scaling a human-only foundation model in both data and parameters, paired with an efficient backbone, yields state-of-the-art results on cell-type annotation, perturbation prediction, gene function prediction, and gene-gene relationship capture, outperforming Geneformer, scGPT, scFoundation, UCE, GeneCompass, and others.

## Key claims

- Trained on a curated corpus of 102,304,686 human cells (19,914 samples), ~2x the largest prior single-species training set; ~70M cells had cell-type annotations and 66.7M were 10x Genomics.
- 800M parameters, an ~8x increase over the largest prior single-species model (GeneCompass) and 1.23x larger than the multi-species UCE; presented as the largest human-only scFM.
- CellFM is a **value-projection** model: it maps scalar expression to embeddings and recovers vector embeddings of masked genes from their linear projections, preserving full data resolution (vs. ordering or value-categorization strategies).
- Outperforms competitors on gene function prediction (zero-shot): +5.68% / +5.86% average accuracy over UCE and scGPT on binary T1/T2/T3 tasks; +1.6% / +1.94% AUPR over GeneCompass and UCE on Gene Ontology multi-class.
- Perturbation prediction (combined with GEARS, gene embeddings swapped in): +1% PCC / +1.45% MSE over second-best scFoundation; +4.75% PCC / +7% MSE over GEARS alone.
- Reverse perturbation prediction (in silico, Norman dataset, scGPT protocol): 81.8% of correct perturbations in top-10 predictions, 18.1% higher than scGPT.
- Cell-type annotation used CellFM-80M (not the 800M model): 92.91% average intra-dataset accuracy, +2.02% over scFoundation; +2.3% over scFoundation on inter-dataset (cross-batch) annotation.
- For batch integration (AvgBio / scIB metrics), CellFM beat the second-best UCE by 2.1%.
- GRN / gene-relationship analysis via gene embeddings and attention maps preserved biologically meaningful relationships (e.g., IL-2/IL-3/IL-4 in immune cells) and recovered known TF targets (e.g., 18/20 top SPI1-influenced genes validated in ChIP-Atlas).

## Methods / evidence

- **Architecture (ERetNet):** a modified RetNet backbone — a Transformer variant with linear complexity supporting parallel, recurrent, and chunkwise processing. Two key modifications: (1) replace the feedforward network with a gated bilinear network (Simple Gated Linear Unit, SGLU); (2) replace pre-layer LayerNorm with DeepNorm post-norm for training stability at scale. Attention is a Gated Multi-head Attention (MHA) variant of RetNet's Retention; using the Shen et al. KV-first trick gives linear complexity O(l_max·d²/h) instead of O(l_max²·d). Full model: 40 stacked ERetNet blocks, d=1536, 48 heads, head dim 32, l_max=2048 genes per cell.
- **Embedding module:** scalar gene expression mapped to high-dim embeddings via an MLP (b=256, d=1536); learnable gene-ID embedding matrix of 24,079 entries added; a learnable CLS token is concatenated for cell-level aggregation.
- **Objective (self-supervised, masked recovery):** randomly mask 20% of expressed (non-padded) genes and recover them. Loss = L_MSE (on masked gene vector embeddings) + L_cls (CLS-token-driven expression prediction against the gene vocabulary). MSE chosen to preserve full-resolution value-projection prediction.
- **LoRA:** Low-Rank Adaptation applied only to the ERetNet encoder during fine-tuning to cut trainable parameters; ablation showed minimal accuracy change with LoRA but reduced fine-tuning time.
- **Pre-training setup:** Adam, LR 1e-7, 2 epochs, batch size 128, on 4 Huawei Atlas800 servers (8 Ascend910 NPUs each), MindSpore framework. Two epochs justified by sharp loss drop (8 → <1) in epoch 1.
- **Pre-processing:** HGNC gene-symbol standardization (24,078-gene set incl. mitochondrial genes), QC filter (≥200 genes/cell), normalization + log1p, unified sparse-matrix format via Singleron's SynEcoSys pipeline.
- **Benchmarks/baselines:** scFoundation, GeneCompass, UCE, scELMo, scBERT, scGPT, Geneformer, plus non-FM baselines SVM, scmap, GEARS, CellOT, scGEN. Evaluation framework scEval; metrics ACC, Macro-F1, AUPR, PCC, MSE, R², scIB/AvgBio. Datasets: Adamson & Norman Perturb-seq, hPancreas, Immune, BCC (GSE123813), LIHC (GSE140228), PBMC, Tabula Sapiens, human brain atlas.
- **Weight of evidence:** broad, multi-task benchmarking against 7 scFMs and several classical baselines with consistent (if often modest, 1-3%) margins; gene-relationship claims externally validated against ChIP-Atlas, TRRUST, KEGG, and ChIP-seq IGV tracks.

## Surprising or load-bearing bits

- The flagship cell-annotation and batch-correction results use **CellFM-80M, not the 800M model** — the 800M version had *low* zero-shot annotation performance and only excelled after fine-tuning, where it beat scGPT by 12.8% (inter-dataset). This tempers the "bigger is better" framing: scale helps under fine-tuning but not zero-shot for annotation.
- The backbone is a **RetNet derivative, not a Transformer** — a deliberate departure from every other scFM compared, motivated by linear-complexity efficiency on Ascend NPUs / MindSpore (not CUDA/PyTorch).
- MindSpore lacks a Gradient Reversal Layer, so for fair batch-integration comparison the authors re-ran scGPT with its GRL loss removed — a framework limitation shaping the experimental design.
- Perturbation prediction does not use CellFM end-to-end; CellFM's gene embeddings are injected into GEARS (gene perturbation) or CellOT (drug perturbation), which do the actual prediction.

## Concepts touched

- [[30-Concepts/single-cell-foundation-model]] — CellFM is a value-projection scFM, contrasted against ordering (Geneformer) and value-categorization (scGPT, scBERT, UCE) families.
- [[30-Concepts/transformer]] — ERetNet is a linear-complexity Transformer variant (RetNet) used instead of a standard Transformer.
- [[30-Concepts/attention-mechanism]] — Gated Multi-head Attention with KV-first computation for linear complexity; attention maps also used to read off gene-gene influence.
- [[30-Concepts/self-supervised-pretraining]] — pre-trained on 100M unlabeled cells via masked-gene recovery.
- [[30-Concepts/masked-language-modelling]] — 20% of expressed genes masked and reconstructed (MSE + CLS loss).
- [[30-Concepts/fine-tuning]] — downstream adaptation, made parameter-efficient via LoRA.
- [[30-Concepts/transfer-learning]] — pre-trained representations transferred to annotation, perturbation, GRN, and gene-function tasks.
- [[30-Concepts/gene-embedding]] — learnable 24,079-entry gene-ID embedding matrix; gene embeddings drive function prediction and perturbation.
- [[30-Concepts/cell-embedding]] — CLS-token aggregates gene info into a cell-level representation.
- [[30-Concepts/expression-tokenization]] — scalar expression projected to embeddings via MLP (value-projection, full resolution preserved).
- [[30-Concepts/zero-shot-learning]] — frozen-model evaluation for gene function prediction and some annotation/GRN tasks.
- [[30-Concepts/batch-integration]] — evaluated via scIB/AvgBio across PBMC, Tabula Sapiens, brain atlas.
- [[30-Concepts/cell-type-annotation]] — intra- and inter-dataset benchmarks via scEval (CellFM-80M).
- [[30-Concepts/gene-regulatory-network]] — gene embeddings + attention maps used to infer gene relationships and TF networks, validated against TRRUST/ChIP-Atlas.
- [[30-Concepts/in-silico-perturbation]] — forward and reverse perturbation prediction on Adamson/Norman Perturb-seq.
- [[30-Concepts/gene-gene-interaction]] — Leiden gene programs + KEGG enrichment; attention-derived influenced-gene sets.
- [[30-Concepts/scrna-seq]] — the data modality; all 100M cells are scRNA-seq.

## Open questions

- The 800M flagship underperforms zero-shot on annotation while the 80M variant is used for the headline annotation numbers — when does the extra scale actually pay off, and is 800M justified given the modest task margins?
- Improvement margins over the second-best scFM are frequently small (often 1-3%); the paper does not report variance/significance for many of these, so robustness of the "state-of-the-art" claim is unclear.
- Limitations the authors flag: (1) attention maps capture mainly static/global relationships, limiting explainability; (2) no multi-species data, blocking cross-species transfer; (3) no biological prior knowledge incorporated (unlike GeneCompass). Drug-perturbation reverse prediction is also unsupported.
- MindSpore/Ascend dependence and absence of GRL may limit reproducibility and fair comparison on standard CUDA/PyTorch stacks.

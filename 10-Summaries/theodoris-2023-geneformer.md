---
type: summary
title: "Transfer learning enables predictions in network biology"
source: "[[00-Sources/papers/single-cell-foundation-models/s41586-023-06139-9]]"
source_kind: paper
author: "Christina V. Theodoris (corresponding), Ling Xiao, Anant Chopra, Mark D. Chaffin, Zeina R. Al Sayed, Matthew C. Hill, Helene Mantineo, Elizabeth M. Brydon, Zexian Zeng, X. Shirley Liu, Patrick T. Ellinor (corresponding)"
published: 2023
ingested: 2026-05-29
doi: "10.1038/s41586-023-06139-9"
journal: "Nature"
tags: [single-cell, foundation-model, transfer-learning, transformer, gene-regulatory-network, in-silico-perturbation, cardiomyopathy]
concepts: ["[[30-Concepts/single-cell-foundation-model]]", "[[30-Concepts/transformer]]", "[[30-Concepts/attention-mechanism]]", "[[30-Concepts/self-supervised-pretraining]]", "[[30-Concepts/masked-language-modelling]]", "[[30-Concepts/transfer-learning]]", "[[30-Concepts/gene-embedding]]", "[[30-Concepts/cell-embedding]]", "[[30-Concepts/expression-tokenization]]", "[[30-Concepts/rank-value-encoding]]", "[[30-Concepts/fine-tuning]]", "[[30-Concepts/batch-integration]]", "[[30-Concepts/cell-type-annotation]]", "[[30-Concepts/gene-regulatory-network]]", "[[30-Concepts/in-silico-perturbation]]", "[[30-Concepts/scrna-seq]]"]
topics: ["[[40-Topics/single-cell-foundation-models]]"]
---

**Citation:** Theodoris et al. (2023) — *Transfer learning enables predictions in network biology* — *Nature*. [DOI](https://doi.org/10.1038/s41586-023-06139-9)

# Geneformer (Theodoris 2023)

> Geneformer is a context-aware, attention-based deep learning model — a transformer encoder pretrained on ~30 million human single-cell transcriptomes (Genecorpus-30M) via a self-supervised masked-gene objective — that learns a fundamental, transferable understanding of gene network dynamics. The central thesis is that transfer learning, which transformed NLP and computer vision, can be ported to network biology: a single large-scale pretraining run encodes network hierarchy in the model's attention weights, and that knowledge can then be fine-tuned with very limited task-specific data (sometimes <1,000 cells) to boost predictions across a diverse panel of chromatin- and network-dynamics tasks. Applied to cardiomyopathy with scarce patient data, Geneformer nominated therapeutic targets whose experimental CRISPR knockout improved cardiomyocyte contraction, making it the first single-cell foundation model paper to pair a transferable pretrained transcriptome model with wet-lab validated, in-silico-perturbation-derived drug targets.

## Key claims

- Pretraining on a large, diverse single-cell corpus yields a foundation model whose knowledge transfers to many downstream tasks, beating task-specific models (XGBoost, deep NNs, SVM/RF/LR on counts or ranks) trained from scratch — and the performance gap widens as task complexity (e.g., number of cell-type classes) grows.
- The pretrained model encodes gene-network hierarchy purely self-supervised: ~20% of attention heads attend transcription factors more than other genes, and specific heads attend central regulatory nodes of the NOTCH1-dependent network more than peripheral genes, with TF attention concentrated in earlier layers and centrality-driven heads dominating final layers.
- Larger and more *diverse* pretraining corpuses consistently improve downstream predictive power even when the fine-tuning data are held fixed (10,000 cells) — diverse Genecorpus samples beat equally sized non-diverse (single-tissue oesophageal) samples, and deeper models (6 layers) only train well at the larger scales.
- Fine-tuning needs strikingly little data: distinguishing central vs peripheral N1-network factors retained near-full accuracy down to ~5,000 ECs, and just 884 ECs from healthy/dilated aortas beat alternative methods trained on ~30,000 ECs — minimum data depends on relevance of the data to the task.
- An in silico deletion / in silico perturbation approach (remove or add a gene from the rank-value encoding, measure the shift in remaining gene/cell embeddings) recovers known biology without any perturbation training data: it predicts dosage-sensitive disease genes context-specifically, recovers direct vs indirect TF targets (GATA4, TBX5), and captures TF cooperativity (combined GATA4+TBX5 deletion exceeds the sum of individual effects on cobound targets).
- In silico treatment analysis on cardiomyopathy cardiomyocytes nominated therapeutic targets; CRISPR knockout of predicted targets (TEAD4 for dosage sensitivity; GSN and PLN in a TTN+/- dilated-cardiomyopathy iPSC microtissue model) produced significant functional improvement in contractile stress.

## Methods / evidence

- **Pretraining corpus (Genecorpus-30M).** 29.9M human single-cell transcriptomes assembled from 561 publicly available droplet-based datasets across ~40 tissue categories; malignant/immortalized cells excluded to avoid network rewiring. After quality filtering (read counts and mitochondrial % within 3 s.d. of dataset mean; ≥7 detected protein-coding/miRNA genes), 27.4M cells were used for pretraining. Gene vocabulary: 25,424 protein-coding/miRNA genes plus pad and mask tokens.
- **Rank-value encoding (expression tokenization).** Each cell's transcriptome is encoded as a non-parametric ranked list: genes ranked by their per-cell expression normalized by the gene's non-zero median expression across the whole corpus. This deprioritizes ubiquitous housekeeping genes (low rank) and promotes cell-state-distinguishing genes such as TFs (high rank), and is more robust to count-scale technical artefacts since relative rank is more stable. Normalization factors are computed once from the corpus and reused for all future datasets. Tokens stored in HuggingFace Datasets (Apache Arrow) for memory efficiency; only detected genes stored.
- **Architecture.** 6 transformer encoder layers, each with full dense self-attention + feed-forward NN; input size 2,048 (covers 93% of rank-value encodings, vs BERT's 512), 256 embedding dimensions, 4 attention heads/layer, feed-forward size 512, ReLU, dropout 0.02. Implemented in PyTorch + HuggingFace Transformers.
- **Objective.** Self-supervised masked learning: 15% of genes per transcriptome masked; the model predicts the masked gene from the context of remaining unmasked genes. Fully unlabelled. Optimized with Adam-W, max LR 1e-3, linear warmup (10,000 steps), batch size 12, 3 epochs. Custom length-grouped dynamic padding gave a 29.4x speedup; DeepSpeed used for distributed training. Total ~3 days on 12 Nvidia V100 32GB GPUs (3 nodes x 4 GPUs).
- **Embeddings.** Per-cell contextual 256-dim gene embeddings extracted from the second-to-last layer (more generalizable than the task-tuned final layer); cell embeddings formed by averaging gene embeddings in the cell.
- **Fine-tuning.** Initialize with pretrained weights, add one task-specific transformer layer; gene-classification or cell-classification objectives. Deliberately uniform hyperparameters across all tasks (single epoch, max LR 5e-5) — meaning reported performance likely *underestimates* the model's ceiling. Five-fold cross-validation for gene-classification AUCs.
- **Downstream task results (all "Geneformer vs alternatives" via 5-fold CV AUC).** Dosage-sensitive vs insensitive TFs: AUC 0.91 (best alternative 0.75). Bivalent vs non-methylated genes: 0.93; bivalent vs H3K4me3-only: 0.88 — trained on only 56 conserved loci in ~15,000 ESCs yet generalized genome-wide. Long- vs short-range TFs: 0.74 (alternatives near-random). N1-network central vs peripheral: 0.81; N1 activated vs non-target: 0.81. Cell-type annotation: boosted accuracy and macro-F1 over XGBoost and deep-NN baselines, gap widening with class count.
- **Batch integration / context awareness.** Gene embeddings robust to sequencing platform, preservation method, and patient variability, yet context-dependent (in silico adding OCT4/SOX2/KLF4/MYC shifts other genes toward iPSC state). Cell embeddings cluster by cell type/phenotype rather than patient; fine-tuning improved cross-platform (Drop-seq/DroNc-seq) integration beyond ComBat or Harmony.
- **In silico perturbation evidence.** In silico deletion of cardiomyopathy/structural-heart genes was more deleterious to cardiomyocyte embeddings than control hyperlipidaemia genes; GATA4 deletion impacted ChIP-seq direct targets more than indirect; combined GATA4+TBX5 effect was super-additive on cobound targets. Disease-modelling on cardiomyopathy cardiomyocytes (90% out-of-sample accuracy) identified 447 HCM-shifting and 478 DCM-shifting gene losses, enriched for sarcomere/contraction/mitochondrial pathways. Experimental validation: CRISPR knockout of TEAD4, and of GSN and PLN in TTN+/- microtissues, significantly changed contractile stress.

Weight of evidence: strong and unusual for the field — combines large-scale pretraining, multiple benchmarked downstream tasks with rigorous baselines, mechanistic attention-weight analysis, and prospective wet-lab CRISPR validation of computationally nominated targets.

## Surprising or load-bearing bits

- Network hierarchy emerges in attention weights *with no supervision and no perturbation data* — the model "discovers" that TFs and central regulatory nodes matter, and organizes this across layers (early=diverse survey, middle=broad, late=centrality-focused).
- Rank-value encoding is a deliberate departure from value-based tokenization: it throws away absolute counts in exchange for robustness and a discrete, language-model-like token stream — a key design choice that later scFMs (scGPT, scBERT) reacted to differently.
- Super-additive combined in silico deletion (GATA4+TBX5) implies the model learned cooperative TF action, not just marginal gene importance.
- Relevance of fine-tuning data can matter more than quantity: 884 well-matched cells beat ~30,000 generic ones.

## Concepts touched

- [[30-Concepts/single-cell-foundation-model]] — Geneformer is one of the first scFMs: a single self-supervised pretrained transcriptome transformer reused across many downstream tasks.
- [[30-Concepts/transformer]] — 6-layer encoder-only transformer (BERT-like) adapted to single-cell transcriptomes.
- [[30-Concepts/attention-mechanism]] — full dense self-attention over 2,048 genes; attention weights are analyzed directly as a readout of learned network hierarchy.
- [[30-Concepts/self-supervised-pretraining]] — pretrained entirely on unlabelled transcriptomes, enabling 30M-cell scale.
- [[30-Concepts/masked-language-modelling]] — masks 15% of genes per cell and predicts them from context, the BERT-style objective ported to genes.
- [[30-Concepts/transfer-learning]] — core thesis: one pretraining run, fine-tuned with limited data to many tasks; explicitly framed as the NLP/vision transfer-learning paradigm for network biology.
- [[30-Concepts/gene-embedding]] — contextual 256-dim per-gene embeddings extracted from the second-to-last layer.
- [[30-Concepts/cell-embedding]] — cell embeddings formed by averaging in-cell gene embeddings.
- [[30-Concepts/expression-tokenization]] — encodes a cell as discrete gene tokens rather than a value vector.
- [[30-Concepts/rank-value-encoding]] — Geneformer's signature tokenization: corpus-median-normalized expression ranking, deprioritizing housekeeping genes; a novel contribution of this paper.
- [[30-Concepts/fine-tuning]] — add one task layer to pretrained weights; uniform hyperparameters across tasks, single epoch.
- [[30-Concepts/batch-integration]] — pretrained embeddings robust to platform/preservation/patient; fine-tuning improved cross-platform integration beyond ComBat/Harmony.
- [[30-Concepts/cell-type-annotation]] — secondary benchmark where Geneformer beat XGBoost and deep-NN baselines, gap widening with class count.
- [[30-Concepts/gene-regulatory-network]] — predicting central vs peripheral nodes and TF targets in the NOTCH1 network; network hierarchy is the central biological object.
- [[30-Concepts/in-silico-perturbation]] — Geneformer introduces in silico deletion/activation by editing the rank-value encoding and measuring embedding shifts, used for dosage sensitivity, target mapping, and in silico treatment.
- [[30-Concepts/scrna-seq]] — all inputs are droplet-based single-cell/single-nucleus RNA-seq transcriptomes.

## Open questions

- Rank-value encoding discards absolute transcript counts; the authors acknowledge it does not fully exploit precise expression measurements, which may lose quantitative dynamic-range information.
- Reported downstream performance likely underestimates the ceiling because hyperparameters were deliberately fixed across tasks with no tuning and single-epoch fine-tuning.
- Genecorpus-30M excludes malignant/immortalized cells, so applicability to cancer network rewiring is untested in this work.
- The model is human-only and droplet-platform-only; generalization to other species, full-length protocols, or modalities beyond scRNA-seq (spatial, multi-omics) is not evaluated.
- Experimental validation is concentrated in cardiomyopathy/cardiac contexts; the breadth of therapeutic-target nomination claimed in the discussion rests on a relatively narrow set of validated examples.

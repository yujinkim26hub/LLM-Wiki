---
type: summary
title: "Gene knockout inference with variational graph autoencoder learning single-cell gene regulatory networks"
source: "[[00-Sources/papers/virtual/gkad450]]"
source_kind: paper
author: "Yongjian Yang (corresponding), Guanxun Li, Yan Zhong, Qian Xu, Bo-Jia Chen, Yu-Te Lin, Robert S. Chapkin, James J. Cai"
published: 2023
ingested: 2026-05-29
doi: "10.1093/nar/gkad450"
journal: "Nucleic Acids Research"
tags: [single-cell, in-silico-perturbation, gene-regulatory-network, vgae]
concepts: ["[[30-Concepts/in-silico-perturbation]]", "[[30-Concepts/gene-regulatory-network]]", "[[30-Concepts/sctenifoldknk]]", "[[30-Concepts/celloracle]]"]
topics: ["[[40-Topics/virtual-perturbation-screening]]"]
---

**Citation:** Yang et al. (2023) — *Gene knockout inference with variational graph autoencoder learning single-cell gene regulatory networks* — *Nucleic Acids Research*, 51(13): 6578–6592. [DOI](https://doi.org/10.1093/nar/gkad450)

# GenKI (Yang 2023)

> GenKI (Gene Knockout Inference) is an unsupervised virtual-knockout tool that predicts a gene's function from wild-type (WT) scRNA-seq data alone, with no real knockout samples required. It fits a variational graph autoencoder (VGAE) to the WT expression matrix plus an inferred single-cell gene regulatory network (scGRN), then computationally deletes a target gene's edges and measures the per-gene shift in the VGAE latent distribution (KL divergence) to rank "KO-responsive" genes whose enriched functions reveal the KO gene's role.

## Key claims
- GenKI is, to the authors' knowledge, the first virtual-KO tool to use a **graph-based generative model** to infer KO-responsive genes and their shared functions.
- It requires **only WT scRNA-seq data** — no KO samples, no perturbation labels, no second modality (e.g. scATAC-seq). scTenifoldKnk is the only prior method with identical input requirements.
- By incorporating **both** the gene expression matrix and the scGRN (whereas scTenifoldKnk uses only the scGRN), GenKI outperforms scTenifoldKnk and two naive baselines (random ranking, Pearson correlation) on simulated data across all dataset sizes.
- Its two-layer GCN encoder captures **second-order (two-hop) neighborhood** information in the GRN, giving more inference power than scTenifoldKnk's manifold alignment, which only tracks first-order (directly connected) neighbors.
- GenKI is **complementary to, not a replacement for, differential expression (DE) analysis**: KO-responsive genes tend to be differentially expressed but GenKI also flags perturbed genes with little/no expression change (e.g. genes buffered by redundant regulators), and produces fewer, more targeted hits than DE.
- GenKI is **species-agnostic** and can knock out any gene, including vital genes whose real KO would be lethal/impractical to model in animals.

## Methods / evidence
- **scGRN construction.** Uses PC-regression (from scTenifoldNet) to build a fully-connected p×p adjacency matrix of pairwise interaction strengths, then thresholds it (default: keep top 15% of edges by absolute weight) into a Boolean graph. Users may instead supply their own GRN. Genes = nodes; expression matrix = node features.
- **VGAE model.** Two-layer GCN encoder + inner-product decoder (the Kipf & Welling VGAE). Each gene's latent embedding is a bivariate Gaussian; objective is a beta-VAE ELBO (KL term weighted by β, default β=1E-4). Trained on the WT data via link-prediction (edges split 75/5/20 train/val/test, balanced with sampled negative edges), evaluated by AUROC and AP. Trained with Adam, Xavier init, early stopping.
- **Virtual knockout.** The trained model and WT data are copied; in the copy, **all edges from and to the KO gene are set to zero** (the original WT scGRN is untouched). The transferred model is fed this virtual-KO graph to produce KO-setting latent distributions.
- **Scoring.** For each gene, compute **KL divergence** between its WT and virtual-KO latent Gaussians — higher KL = more impacted by the KO. A **bagging** procedure (permute cell order, recompute, 1000 repeats; keep genes in the top 5% in >95% of runs) stabilizes the final KO-responsive gene list.
- **Simulated validation.** SERGIO-simulated datasets (2700 cells; 100/400/1200 genes) with known ground-truth GRNs; GenKI beat scTenifoldKnk, random, and Pearson baselines on AUROC and AP. On the BEELINE GSD network (19 genes), GenKI separated two-hop neighbors from distant genes better than scTenifoldKnk (lower Wilcoxon p-values).
- **Real-data validation.** Recapitulated findings of real KO experiments: Trem2 KO in microglia (lipid/cholesterol metabolism, lysosome, Alzheimer's; Trem2 top-ranked, then Ctsd, Apoe), Nkx2-1 KO in lung AT1 cells (82 genes; surfactant, cytoskeleton, ECM), and a Hnf4a+Smad4 **double KO** in enterocytes (14 genes; nonlinear accumulation of two KO effects). Also a standalone WT-only application predicting STAT1 function in COVID-19 epithelial cells (28 genes; interferon, class II MHC, NF-κB), with no paired KO data.
- **Robustness/scalability.** Tolerant to added expression noise up to σ=1.5; consistent across biological replicates (Mecp2 KO, Spearman ρ=0.82); **2.8–4.9× faster than scTenifoldKnk** on CPU, and a trained model can be reused for any KO gene.

## Surprising or load-bearing bits
- The virtual knockout is computationally cheap and *generative*: once trained, the same VGAE is reused for any target gene, unlike scTenifoldKnk which must re-solve an eigendecomposition per gene.
- GenKI explicitly **avoids a numerical pitfall** in scTenifoldKnk: deleting a gene's edges yields an asymmetric Laplacian with imaginary eigenvectors, which scTenifoldKnk patches by adding 1 to all entries and taking real parts; GenKI's neural optimization sidesteps this and is claimed to be numerically more stable.
- KO-responsive genes **cannot** be recovered by naive network metrics (ranking by expression or by edge weight to the KO gene) — the nonlinear VGAE embedding is doing real work.
- Multiple-gene (double) KO effects are shown to be **nonlinearly accumulable** in the same framework, just by zeroing the edges of several genes at once.

## Concepts touched
- [[30-Concepts/in-silico-perturbation]] — GenKI is a virtual (in-silico) gene-knockout method that substitutes computation for real KO animals/CRISPR screens.
- [[30-Concepts/gene-regulatory-network]] — operates on a single-cell GRN (scGRN); the KO is enacted by deleting the target gene's edges in this network.
- [[30-Concepts/sctenifoldknk]] — the closest prior method and main benchmark; GenKI shares its WT-only input but replaces manifold alignment with a VGAE (see contrast above).
- [[30-Concepts/celloracle]] — another unsupervised GRN-based virtual-perturbation tool; GenKI argues CellOracle's signal-propagation simulation is linear, doesn't quantify per-gene perturbation, and requires scATAC-seq to build the GRN.
- graph-neural-network — the encoder is a 2-layer graph convolutional network (GCN); deeper GCNs were avoided to prevent over-smoothing.
- variational-graph-autoencoder (VGAE) — the core generative model (GCN encoder + inner-product decoder, Gaussian latent per gene, beta-VAE ELBO); no wiki concept page exists for this yet.

## Open questions
- GenKI cannot predict the **direction** of regulation of KO-responsive genes (up vs. down), and so cannot currently simulate over-expression — a noted limitation.
- Deleting *all* of a gene's edges is acknowledged as a naive model of biological KO; the authors suggest a more probabilistic/Bayesian KO formulation.
- GenKI is inapplicable to bulk RNA-seq (genes lose cross-cell variability needed for PC-regression GRN construction) and currently models only static, not dynamic/pseudotemporal, KO effects.
- scGRN quality depends on the PC-regression construction and the (default 15%) edge threshold; results are claimed stable within an "optimal range" but the choice is user-tunable and not fully principled.

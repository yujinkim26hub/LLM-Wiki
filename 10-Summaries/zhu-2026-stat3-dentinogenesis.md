---
type: summary
title: "Single-Cell Virtual Perturbation Screening Identifies STAT3 as a Key Regulator of Dentinogenesis"
source: "[[00-Sources/papers/virtual/Cell Proliferation - 2026 - Zhu - Single%E2%80%90Cell Virtual Perturbation Screening Identifies STAT3 as a Key Regulator of-2]]"
source_kind: paper
author: "Yanfei Zhu, Hongyuan Xu, Zijian Zhang, Siyuan Sun, Zihan Huang, Xin Gao, Houwen Pan, Xiangru Huang, Yuanqi Liu, Xinyu Wang, Hanbin Jia, Qinggang Dai (corresponding), Lingyong Jiang (corresponding)"
published: 2026
ingested: 2026-05-29
doi: "10.1111/cpr.70203"
journal: "Cell Proliferation"
tags: [single-cell, in-silico-perturbation, dentinogenesis, stat3, wnt, gene-regulatory-network]
concepts: ["[[30-Concepts/in-silico-perturbation]]", "[[30-Concepts/celloracle]]", "[[30-Concepts/sctenifoldknk]]", "[[30-Concepts/scenic]]", "[[30-Concepts/cellrank]]", "[[30-Concepts/gene-regulatory-network]]", "[[30-Concepts/stat3]]", "[[30-Concepts/wnt-beta-catenin-signalling]]", "[[30-Concepts/dentinogenesis]]"]
topics: ["[[40-Topics/virtual-perturbation-screening]]", "[[40-Topics/tooth-development]]"]
---

**Citation:** Zhu et al. (2026) — *Single-Cell Virtual Perturbation Screening Identifies STAT3 as a Key Regulator of Dentinogenesis* — *Cell Proliferation*. [DOI](https://doi.org/10.1111/cpr.70203)

**Source file:** 📄 [[00-Sources/papers/virtual/Cell-Proliferation---2026---Zhu---Single-percentE2-percent80-percent90Cell-Virtual-Perturbation-Screening-Identifies-STAT3-as-a-Key-Regulator-of-2.pdf|Original PDF]] · browse in [[00-Sources/papers/virtual/index|Sources › Papers › Virtual]]

# Zhu 2026 — STAT3 in dentinogenesis

> A "prediction-to-verification" study: the authors use single-cell fate mapping plus in silico (virtual) gene-knockout simulations to nominate STAT3 as the transcription factor driving dental mesenchymal cells into the odontoblast lineage, then confirm it experimentally — knockdown, pharmacology, and a conditional-knockout mouse — and pin down the mechanism as direct transcriptional activation of the Wnt ligand WNT2B.

## Key claims

- A single-cell transcriptional landscape of human odontogenic tissue (24,177 cells) resolves nine cell types and identifies **EFNB2+ mesenchymal cells** as the primary multipotent progenitor at the root of the odontoblast differentiation trajectory (highest CytoTRACE2 stemness, root of the Slingshot trajectory, CellRank starting state).
- Intersecting **CellRank** fate probabilities with **SCENIC** regulon specificity scores (RSS) nominates **STAT3** as a key driver/regulator of the odontoblast lineage; STAT3 rises along pseudotime at the onset of pre-odontoblast commitment.
- **In silico knockout of STAT3 with CellOracle** redirects the developmental vector field *away* from the pre-odontoblast fate, predicting that STAT3 is required for odontoblast commitment. **scTenifoldKnk** virtual knockout corroborates this and shows the perturbed genes are enriched for the **Wnt signalling pathway** (among others).
- Experimental loss-of-function confirms the prediction: shRNA knockdown of STAT3 in human dental pulp cells (hDPCs) reduces proliferation (CCK-8, EdU) and odontoblast differentiation (ALP, mineralisation, DSPP/DMP1/BGLAP markers).
- Pharmacology mirrors this bidirectionally: the JAK2 inhibitor **AG490** (blocks STAT3 phosphorylation) impairs proliferation/differentiation, while the activator peptide **colivelin** (induces STAT3 phosphorylation) enhances them — nominating STAT3 as a druggable target.
- A conditional-knockout mouse (`Stat3fl/fl;OsxCre`, deleting Stat3 in Osterix+ odontoblast progenitors) develops **dentine dysplasia**: reduced dentine width, shortened roots, delayed molar eruption, lower mineral apposition rate, and impaired incisor repair — with a gene-dosage effect (heterozygotes intermediate). Enamel is unaffected, localising the defect to dentine.
- Mechanism: STAT3 **directly binds the WNT2B promoter** (predicted JASPAR motif, ChIP-confirmed; luciferase shows wild-type and constitutively-active STAT3-C transactivate, dominant-negative STAT3-DN does not, and a motif-deletion mutant abolishes the effect), activating **canonical Wnt/β-catenin signalling** (CTNNB1, AXIN2, LEF1 down; SOST up on knockdown). **WNT2B overexpression partially rescues** the STAT3-loss phenotype.

## Methods / evidence

A layered design moving from computation to biology:
- **Single-cell**: public human odontogenic scRNA-seq (GEO GSE146123, the Krivanek et al. dental cell atlas); Scanpy QC/normalisation; scVI batch correction; Leiden clustering; UMAP; **Slingshot** pseudotime; **CytoTRACE2** potency; **CellRank** fate mapping.
- **Regulatory inference**: **pySCENIC** GRN reconstruction + AUCell activity + **regulon specificity score (RSS)**.
- **Virtual perturbation**: **CellOracle** (GRN-based vector-field simulation of TF knockout) and **scTenifoldKnk** (tensor-based single-gene virtual knockout), with GO/KEGG over-representation on perturbed gene sets.
- **Wet-lab validation**: hDPCs (third-molar germs) with shRNA knockdown, AG490/colivelin pharmacology, CCK-8/EdU proliferation, ALP/ARS mineralisation, qPCR markers; bulk **RNA-seq** (617 DEGs); **ChIP** and **luciferase** reporter assays for the STAT3→WNT2B promoter interaction; WNT2B-overexpression rescue.
- **In vivo**: `Stat3fl/fl;OsxCre` conditional knockout, micro-CT, calcein–alizarin-red double labelling, H&E, SP7/DSPP immunofluorescence, incisor-injury repair assay.

Convergence across in silico, in vitro, and in vivo evidence makes the STAT3→WNT2B→dentine causal chain unusually well-supported for a single paper.

## Surprising or load-bearing bits

- The paper is explicitly framed as a methodological template — **"prediction to verification"** — using virtual perturbation as a *pre-screen* that experiments then confirm. This is the transferable idea beyond the dentine biology.
- The authors are unusually candid about CellOracle's limitations: its GRN is inferred from **static** transcriptomes; it assumes **linear** perturbation propagation (missing non-linear feedback/compensation); and a virtual knockout models **complete ablation**, not the partial loss-of-function typical in vivo. They conclude CellOracle is "a powerful screening tool rather than a definitive predictor."
- STAT3 is best known in immunity and cancer; its role in *tooth* development was previously uncharacterised. The link runs through prior work showing Stat3 loss in osteoblasts suppresses Wnt/β-catenin (Job-syndrome-like skeletal defects).
- WNT2B (a.k.a. WNT13) had no prior reported role in tooth development; this is the first to place it downstream of STAT3 in dentinogenesis.

## Concepts touched

- [[30-Concepts/in-silico-perturbation]] — the central method: virtual knockout as a screening step before experiments
- [[30-Concepts/celloracle]] — used for the STAT3 vector-field knockout; limitations discussed
- [[30-Concepts/sctenifoldknk]] — second virtual-knockout tool, used to quantify network perturbation
- [[30-Concepts/scenic]] — SCENIC + regulon specificity score (RSS) to find lineage-specific TFs
- [[30-Concepts/cellrank]] — fate mapping / absorption probabilities to find driver genes
- [[30-Concepts/gene-regulatory-network]] — the substrate all the perturbation tools operate on
- [[30-Concepts/stat3]] — nominated and confirmed as the odontoblast-lineage regulator
- [[30-Concepts/wnt-beta-catenin-signalling]] — the downstream effector pathway (via WNT2B)
- [[30-Concepts/dentinogenesis]] — the biological process and its disorder (dentine dysplasia)

## Connections to other sources

- First source in the wiki — no cross-source links yet. Future single-cell / virtual-perturbation papers should link here as the worked example of CellOracle + scTenifoldKnk used as a screening front-end.

## Open questions

- How well does the linear, static-GRN CellOracle prediction generalise to systems with strong feedback? The authors flag this but don't quantify the gap between virtual and experimental knockout.
- Does WNT2B alone account for the phenotype, or is it one of several STAT3 targets (WNT16, GPC4, etc. were also down)? The rescue is only *partial*.
- A tissue-specific Wnt2b conditional-overexpression mouse (proposed as future work) is needed to confirm WNT2B mediates the in vivo phenotype.

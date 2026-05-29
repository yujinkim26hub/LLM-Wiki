---
type: summary
title: "Single-cell foundation models: bringing artificial intelligence into cell biology"
source: "[[00-Sources/papers/single-cell-foundation-models/s12276-025-01547-5]]"
source_kind: paper
author: "Seungbyn Baek, Kyungwoo Song, Insuk Lee (corresponding)"
published: 2025
ingested: 2026-05-29
doi: "10.1038/s12276-025-01547-5"
journal: "Experimental & Molecular Medicine"
tags: [single-cell, foundation-model, review]
concepts: [[[30-Concepts/single-cell-foundation-model]], [[30-Concepts/transformer]], [[30-Concepts/attention-mechanism]], [[30-Concepts/self-supervised-pretraining]], [[30-Concepts/masked-language-modelling]], [[30-Concepts/transfer-learning]], [[30-Concepts/gene-embedding]], [[30-Concepts/cell-embedding]], [[30-Concepts/expression-tokenization]], [[30-Concepts/rank-value-encoding]], [[30-Concepts/zero-shot-learning]], [[30-Concepts/fine-tuning]], [[30-Concepts/batch-integration]], [[30-Concepts/cell-type-annotation]], [[30-Concepts/gene-regulatory-network]], [[30-Concepts/in-silico-perturbation]], [[30-Concepts/scrna-seq]], [[30-Concepts/spatial-transcriptomics]], [[30-Concepts/multi-omics]], [[30-Concepts/gene-gene-interaction]]]
topics: ["[[40-Topics/single-cell-foundation-models]]"]
---

**Citation:** Baek, Song & Lee (2025) — *Single-cell foundation models: bringing artificial intelligence into cell biology* — *Experimental & Molecular Medicine*. [DOI](https://doi.org/10.1038/s12276-025-01547-5)

# scFM review (Baek 2025)

> This review surveys single-cell foundation models (scFMs): large transformer models pretrained self-supervised on tens of millions of single-cell omics profiles, then adapted to many downstream tasks. Its organizing argument is the NLP analogy — a cell is a "sentence" and its genes/features are "tokens/words" — traced end to end across the model lifecycle (data sourcing, tokenization, architecture, pretraining objective, adaptation, deployment) and then across downstream applications. It is deliberately critical: it argues scFMs are promising generalist engines but still early-stage, with major unresolved problems in data quality, interpretability, and (especially) benchmarking, where zero-shot scFMs often fail to beat task-specific tools.

## Key claims

- scFMs treat each cell as a sentence and genes/features as tokens, the premise being that exposure to millions of cells lets the model learn generalizable cell/gene principles transferable to new datasets and tasks.
- The full pipeline is: aggregate large public corpora → tokenize → transformer architecture → self-supervised pretraining (mostly gene-prediction/masking) → optional continual pretraining + fine-tuning → deploy to extract cell embeddings, gene embeddings, attention scores, or generated profiles.
- A defining strength is **versatility/zero-shot**: one model serves many tasks (annotation, integration, imputation, gene function, network inference, perturbation) often with competitive zero-shot performance, potentially replacing dozens of single-purpose tools.
- **Fine-tuning generally yields substantial gains** over zero-shot and enables tasks not feasible zero-shot — but it is nontrivial (compute, hyperparameters, representative data, modeling expertise).
- Benchmarking critique (load-bearing): scFMs in zero-shot mode **often do not outperform existing task-specific tools** (citing the scEval evaluation, ref 2). Evidence is uneven — strengths reported for cell-type prediction, gene function prediction, and spatial imputation, but weaknesses for single-cell expression imputation, cross-platform batch integration, and gene-network inference (refs 2, 41, 42).
- No single architecture (encoder vs decoder vs encoder–decoder) has emerged as clearly superior for single-cell data; encoder, decoder, and hybrid scFMs have all shown success.
- "More data is not always better": curated, diverse pretraining data can beat a naively aggregated superset; beyond a point, adding cells/studies gives diminishing or negative returns (refs 24, 25).
- Attention weights are a popular but unreliable interpretability/network signal — attention is not a direct indicator of feature importance, so attention-derived networks should be cross-checked against known biology (ref 51).

## Landscape / taxonomy

The review's categorization axes: **omics modality** (scRNA-seq vs +scATAC/spatial/proteomics/multiome), **tokenization / input modification** (rank-by-expression vs value binning vs value projection vs prior-knowledge embeddings), **architecture** (encoder-only / decoder-only / encoder–decoder / non-transformer), **pretraining objective** (masked gene prediction vs autoregressive next-gene vs contrastive vs reconstruction/denoising), and **scope** (general-purpose scFM vs task-specific tool that wraps an scFM). It also distinguishes cell-level vs gene/feature-level outputs.

| Model | Journal / status | Omics | Pretrain size | Architecture | Input modification | Pretraining task |
|---|---|---|---|---|---|---|
| scBERT | Nat. Mach. Intell. 2022 | scRNA-seq | 1.1M | Encoder-only (Performer) | Value binning | Gene masking |
| Geneformer | Nature 2023 | scRNA-seq | 30M | Encoder-only | Rank by expression, median-normalize | Gene masking |
| tGPT | iScience 2023 | scRNA-seq | 22.3M | Decoder-only | Rank by expression | Autoregressive gene prediction |
| CellLM | arXiv 2023 | scRNA-seq | 2M | Encoder-only (Performer) | Value binning + PPI embedding | Gene masking + contrastive (cell) |
| CellPLM | bioRxiv 2023 | scRNA-seq + spatial | 11M | Encoder | Value projection | Gene masking |
| scGPT | Nat. Methods 2024 | scRNA-seq, scATAC, CITE-seq | 33M | Decoder-inspired, masked generative | Value binning | Attention masking |
| scFoundation | Nat. Methods 2024 | scRNA-seq | 50M | Asymmetric encoder–decoder | Value projection | Gene masking |
| Geneformer2 | bioRxiv 2024 | scRNA-seq | 103M | Encoder-only | Rank + median-normalize | Gene masking |
| UCE | bioRxiv 2024 | scRNA-seq | 36M | Encoder | ESM2 embedding, ordered by genomic location | Gene masking + binary expression classification |
| GeneCompass | Cell Research 2024 | scRNA-seq | 126M | Encoder-only | Rank + prior-knowledge embeddings | Masking for gene ID + expression prediction |
| Nicheformer | bioRxiv 2024 | scRNA-seq + spatial | 110M | Encoder-only | Rank by expression | Masking for gene-rank prediction |
| SCimilarity | Nature 2024 | scRNA-seq | 23.4M | Non-transformer encoder–decoder | Value projection | Cell similarity + expression reconstruction |
| scPRINT | Nat. Commun. 2025 | scRNA-seq + scATAC | 54M | Encoder–decoder | Normalized expr, ESM2 embedding, gene location as position | Denoising, label prediction, expression reconstruction |

Pretraining data is sourced from CZ CELLxGENE (>100M cells), Human Cell Atlas, GEO/SRA, EMBL-EBI Expression Atlas, PanglaoDB, hECA. Tokenization confronts the core problem that gene expression is non-sequential; common fixes are ranking top genes by expression or binning by expression value, with special tokens for cell identity/metadata, modality, or batch. Notably some models report no clear advantage from complex ranking and simply use normalized counts (scPRINT, ref 19). Adaptation covers continual pretraining and fine-tuning, with parameter-efficient options (LoRA, quantization) flagged as promising.

## Methods / evidence

This is a **review (secondary source)** — it synthesizes the published scFM literature plus a handful of independent benchmark/critique papers rather than running new experiments. It weighs evidence cautiously and repeatedly notes that head-to-head comparison is hard because many models are preprints with bespoke, non-overlapping evaluation tasks, and there is no unified benchmark. Independent benchmarks it leans on: the **scEval** pipeline (Liu et al., ref 2) evaluating scFMs across eight canonical tasks under consistent conditions and finding zero-shot scFMs frequently do not beat task-specific tools; **Kedzierska et al.** (ref 41) showing zero-shot limitations; **BioLLM** (Qiu et al., ref 42) as a standardized benchmarking framework; and **DenAdel** (ref 24) / **Nadig** (ref 25) on pretraining-data size/diversity and composition effects (more data not always better). It also cites work showing attention is not reliably interpretable (Serrano & Smith, ref 51) and class-imbalance failures on rare cell types (refs 2, 24, 27).

## Concepts touched

- [[30-Concepts/single-cell-foundation-model]] — the central object; defined as a transformer-based foundation model for single-cell omics, as discussed in the review.
- [[30-Concepts/transformer]] — the backbone architecture for nearly all scFMs, as discussed in the review.
- [[30-Concepts/attention-mechanism]] — used both to learn gene relationships and (contentiously) to infer gene networks, as discussed in the review.
- [[30-Concepts/self-supervised-pretraining]] — the defining training regime, as discussed in the review.
- [[30-Concepts/masked-language-modelling]] — masked-gene prediction, the dominant pretraining objective for encoder scFMs, as discussed in the review.
- [[30-Concepts/transfer-learning]] — fine-tuning / continual pretraining to adapt a general model, as discussed in the review.
- [[30-Concepts/gene-embedding]] — gene/feature-level latent representations used for function and network tasks, as discussed in the review.
- [[30-Concepts/cell-embedding]] — pooled or CLS-token cell representations underpinning annotation and integration, as discussed in the review.
- [[30-Concepts/expression-tokenization]] — converting a cell's expression profile into gene tokens, as discussed in the review.
- [[30-Concepts/rank-value-encoding]] — ranking/binning genes by expression to impose order, as discussed in the review.
- [[30-Concepts/zero-shot-learning]] — using pretrained scFMs without task-specific fine-tuning, as discussed in the review.
- [[30-Concepts/fine-tuning]] — task-specific adaptation giving substantial gains, as discussed in the review.
- [[30-Concepts/batch-integration]] — embedding cells from disparate batches into a shared space, as discussed in the review.
- [[30-Concepts/cell-type-annotation]] — a flagship downstream task, as discussed in the review.
- [[30-Concepts/gene-regulatory-network]] — inferred from attention/embeddings, as discussed in the review.
- [[30-Concepts/in-silico-perturbation]] — simulating CRISPR/drug perturbations toward "virtual cells", as discussed in the review.
- [[30-Concepts/scrna-seq]] — the dominant pretraining modality, as discussed in the review.
- [[30-Concepts/spatial-transcriptomics]] — a target for spatial-aware scFMs (Nicheformer, scGPT-spatial), as discussed in the review.
- [[30-Concepts/multi-omics]] — integrating scATAC/proteomics/epigenome as a future direction, as discussed in the review.
- [[30-Concepts/gene-gene-interaction]] — relationships scFMs learn and surface via attention, as discussed in the review.

## Open questions

- **Benchmarking/evaluation:** no unified benchmark; bespoke per-model evaluations prevent head-to-head comparison; "success on a task" does not equal "good biological model"; need common pretraining and test sets plus zero-shot/fine-tuning/efficiency metrics.
- **Zero-shot vs specialized tools:** scFMs often fail to beat task-specific baselines in zero-shot mode; whether fine-tuning reliably closes this gap at acceptable cost is open.
- **Interpretability:** latent embeddings and attention weights are hard to map to biology; attention is not a reliable importance/network signal; gene-embedding extraction (pseudobulk averaging) is biased toward broadly expressed genes.
- **Tokenization / non-sequential data:** imposing a linear gene order is an approximation; cells are modeled independently, ignoring cell–cell signaling and spatial structure (calls for graph-based or two-way attention modules).
- **Data scale vs quality:** more data is not always better; artifacts (doublets, ambient RNA), batch effects, dataset redundancy/leakage, and class imbalance (rare cell types) degrade models; need scalable curation, deduplication, and data-selection methods.
- **Compute/accessibility:** pretraining and fine-tuning are resource-intensive; need compression (quantization, distillation, pruning), LoRA, hosted platforms, and better tutorials.
- **Scope:** extend beyond scRNA-seq to multi-omics/epigenome/spatial/proteomics and cross-species models; pursue synthetic-cell generation and the "virtual cell"; address privacy/ethics (e.g., federated learning).

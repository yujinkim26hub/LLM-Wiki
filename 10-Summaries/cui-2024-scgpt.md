---
type: summary
title: "scGPT: toward building a foundation model for single-cell multi-omics using generative AI"
source: "[[00-Sources/papers/single-cell-foundation-models/s41592-024-02201-0]]"
source_kind: paper
author: "Haotian Cui*; Chloe Wang*; Hassaan Maan; Kuan Pang; Fengning Luo; Nan Duan; Bo Wang (corresponding) — *equal contribution"
published: 2024
ingested: 2026-05-29
doi: "10.1038/s41592-024-02201-0"
journal: "Nature Methods"
tags: [single-cell, foundation-model, transformer, generative-pretraining, multi-omics, perturbation, batch-integration]
concepts: [[[30-Concepts/single-cell-foundation-model]], [[30-Concepts/transformer]], [[30-Concepts/attention-mechanism]], [[30-Concepts/self-supervised-pretraining]], [[30-Concepts/gene-embedding]], [[30-Concepts/cell-embedding]], [[30-Concepts/expression-tokenization]], [[30-Concepts/fine-tuning]], [[30-Concepts/transfer-learning]], [[30-Concepts/zero-shot-learning]], [[30-Concepts/batch-integration]], [[30-Concepts/cell-type-annotation]], [[30-Concepts/gene-regulatory-network]], [[30-Concepts/in-silico-perturbation]], [[30-Concepts/scrna-seq]], [[30-Concepts/multi-omics]], [[30-Concepts/gene-gene-interaction]]]
topics: ["[[40-Topics/single-cell-foundation-models]]"]
---

**Citation:** Cui et al. (2024) — *scGPT: toward building a foundation model for single-cell multi-omics using generative AI* — *Nature Methods* 21:1470–1480. [DOI](https://doi.org/10.1038/s41592-024-02201-0)

# scGPT (Cui 2024)

> scGPT is a generative pretrained transformer for single-cell biology that treats genes as tokens and cells as "sentences," pretrained self-supervised on over 33 million normal human cells from CELLxGENE. By jointly learning gene and cell embeddings under a generative gene-expression-prediction objective with a specialized non-causal attention mask, a single pretrained model can be fine-tuned ("pretrain universally, fine-tune on demand") to reach state-of-the-art on cell type annotation, genetic perturbation prediction, multi-batch integration, multi-omic integration, and gene network inference, while its attention maps and gene embeddings expose condition-specific gene–gene interactions.

## Key claims
- A single foundation model pretrained on 33M cells, fine-tuned per task, beats task-specific models trained from scratch and prior transformer methods across five downstream tasks (cell annotation, perturbation, batch integration, multi-omic integration, GRN inference).
- For cell type annotation it outperforms TOSICA and scBERT on accuracy, precision, recall, and macro F1 across human pancreas, multiple sclerosis, and tumor-infiltrating myeloid datasets, including generalization to unseen cancer types.
- For genetic perturbation prediction it beats GEARS and a linear baseline by 5–20% on Pearson-delta across the Adamson, Replogle, and Norman Perturb-seq datasets, and can do "in silico reverse perturbation" — predicting which gene knockouts produce an observed cell state (91.4% relevant within top-1, 65.7% correct within top-8).
- A scaling effect holds: holding parameters fixed and increasing pretraining data from 30k to 33M cells monotonically improves downstream fine-tuning performance, echoing language-model scaling laws.
- Context matters: organ-specific pretraining that matches the target tissue can beat a same-size mismatched model (a blood-pretrained model beat a brain-pretrained model of similar size on a COVID-19 integration task by ~8%), but the whole-human model is the most versatile default.
- Gene embeddings and attention maps recover known biology zero-shot (HLA class I vs class II separation; CD3/CD79 complexes) and identify validated transcription-factor targets (DDIT3, BHLHE40) confirmed in ChIP-Atlas.

## Methods / evidence
- **Architecture:** transformer encoder, embedding size 512, 12 stacked blocks, 8 attention heads each, feed-forward hidden size 512. The multi-omic integration variant uses 4 blocks. Output `<cls>` token aggregates the cell embedding.
- **Input = three layers summed element-wise:** (1) gene tokens — each gene name is a token with an integer ID; vocabulary is the union of genes across studies, plus special `<cls>` and `<pad>` tokens; (2) expression values; (3) condition tokens (modality, batch, perturbation). Batch and modality embeddings are concatenated with the transformer *output* (not fed to attention) to avoid amplifying within-modality attention and to push batch bias out of the learned representations.
- **Expression tokenization = value binning:** for each cell, non-zero counts are split into B equal-frequency bins, so a binned value carries a consistent relative "semantic" meaning across sequencing batches/depths (a value of B always = highest-expressed). Bin edges are recomputed per cell. This is distinct from rank-value encoding — it bins magnitudes rather than ordering genes by rank.
- **Pretraining objective:** generative gene-expression prediction. A specialized attention mask (in {0, −inf}) makes prediction non-causal but autoregressive-like over non-sequential data: unknown (masked) genes attend only to known genes, the `<cls>` token, and themselves — never to other unknowns. Generation proceeds in K iterations, each step committing the top-1/K highest-confidence predicted genes to the "known" set. Supports both "gene prompts" (condition on observed genes) and "cell prompts" (condition on a cell embedding to generate genome-wide expression). Loss is MSE on predicted unknown-gene values; gene-prompt and cell-prompt losses are summed.
- **Pretraining data:** 33M normal (non-disease) human cells from CELLxGENE Census (15 May 2023 release), spanning 51 organs/tissues and 441 studies; 99.7% train / 0.3% validation split. Input restricted to non-zero-expression genes for speed.
- **Fine-tuning objectives:** masked gene expression prediction (GEP), GEP-for-cell-modeling (GEPC, predicts via inner product with cell representation), elastic cell similarity (ECS), domain-adaptation via reverse backprop for batch correction, and a perturb-GEP variant that predicts post-perturbation expression. Combining GEP + GEPC outperforms either alone.
- **Benchmarks:** annotation vs TOSICA, scBERT; perturbation vs GEARS, linear regression; scRNA integration vs scVI, Seurat, Harmony (AvgBIO 0.821 on PBMC 10k, 5–10% above competitors); multi-omic integration vs scGLUE, Seurat v4, scMoMaT (RNA+ATAC, RNA+protein/CITE-seq, and mosaic ATAC+RNA+protein). GRN inference validated against HLA/CD networks, Reactome pathway enrichment, and ChIP-Atlas TF targets.
- **Availability:** code at github.com/bowang-lab/scGPT (MIT license), Zenodo 10.5281/zenodo.10466117. Uses flash-attn, PyTorch, cell-gears.

## Surprising or load-bearing bits
- The central trick is reframing autoregressive generation for *non-sequential* data: genes have no intrinsic order, so scGPT replaces causal next-token masking with confidence-ordered iterative prediction via a custom attention mask. This is one of the first transformer schemes to do autoregressive generation on order-free data — the durable conceptual contribution.
- Per-cell relative binning (not global normalization, not pure rank ordering) is scGPT's answer to cross-batch scale incomparability — a design choice that contrasts sharply with Geneformer's rank-value encoding.
- Batch/modality tokens are deliberately kept *out* of the attention computation and only concatenated post-transformer; this is how scGPT does batch correction implicitly during fine-tuning.
- Reverse perturbation (inferring the perturbation that caused a state) is an unusual generative capability with direct experimental-design payoff — far fewer than the naive ~105 random tries needed to find a driver gene.
- The clean scaling curve (more pretraining cells → better fine-tuning) is the argument that single-cell foundation models will keep improving as atlases grow — the thing to remember in two years.

## Concepts touched
- [[30-Concepts/single-cell-foundation-model]] — scGPT is a canonical instance, pretrained on 33M cells for general transfer.
- [[30-Concepts/transformer]] — 12-block / 8-head encoder adapted from the standard architecture.
- [[30-Concepts/attention-mechanism]] — custom {0,−inf} mask enables generative prediction on non-sequential gene sets; attention maps double as GRN probes.
- [[30-Concepts/self-supervised-pretraining]] — generative gene-expression prediction over masked/unknown genes, no labels.
- [[30-Concepts/gene-embedding]] — genes-as-tokens; learned embeddings recover HLA/CD functional groups zero-shot.
- [[30-Concepts/cell-embedding]] — `<cls>` token output; used for annotation, integration, clustering.
- [[30-Concepts/expression-tokenization]] — per-cell equal-frequency value binning for cross-batch comparability.
- [[30-Concepts/rank-value-encoding]] — contrasted: scGPT bins magnitudes rather than ranking genes (the Geneformer scheme).
- [[30-Concepts/fine-tuning]] — task-specific objectives (GEP, GEPC, ECS, perturb-GEP) on the pretrained backbone.
- [[30-Concepts/transfer-learning]] — "pretrain universally, fine-tune on demand"; beats from-scratch training.
- [[30-Concepts/zero-shot-learning]] — pretrained embeddings cluster cell types and recover gene networks without fine-tuning.
- [[30-Concepts/batch-integration]] — batch tokens concatenated post-transformer + domain-adaptation loss.
- [[30-Concepts/cell-type-annotation]] — classifier head on cell embedding; beats TOSICA, scBERT.
- [[30-Concepts/gene-regulatory-network]] — gene-embedding similarity networks and attention-map activation patterns infer GRNs.
- [[30-Concepts/in-silico-perturbation]] — perturb-GEP predicts unseen perturbation responses and reverse perturbation.
- [[30-Concepts/scrna-seq]] — primary pretraining and benchmark modality.
- [[30-Concepts/multi-omics]] — extends to RNA+ATAC, RNA+protein, and mosaic settings via modality tokens.
- [[30-Concepts/gene-gene-interaction]] — attention scores expose condition-specific interactions validated against ChIP-Atlas.

## Open questions
- Pretraining does *not* inherently remove batch effects, so zero-shot performance can degrade on data with heavy technical variation; batch correction relies on fine-tuning.
- Evaluation is hard: there is often no definitive biological ground truth, and data quality varies, making benchmark scores noisy proxies (acknowledged in Supplementary Note 10).
- Pretraining is restricted to *normal* human scRNA-seq; spatial, multi-omic, perturbation, temporal, and diseased data are left to future work, and in-context (fine-tuning-free) task adaptation is aspirational.
- The custom attention mask's confidence-ordered generation is heuristic; the paper does not establish it is optimal versus alternative orderings for non-sequential data.

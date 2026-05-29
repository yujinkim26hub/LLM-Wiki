---
title: Activity log
description: Append-only chronological record of every ingest, query, and maintenance pass.
---

# Activity log

Append-only. Newest at the top. One entry per session — ingest, query, or maintenance pass. Future-you (in another conversation) reads this to catch up on what has happened.

---

## 2026-05-29 — Ingest: 10 single-cell foundation model / virtual-perturbation papers

**Trigger**: User asked to copy + ingest two Google Drive folders (single-cell foundation model collection: `기타` and `article`).

- **Sources copied** (10 PDFs): 9 → new `00-Sources/papers/single-cell-foundation-models/` (scBERT, Geneformer, UCE, scGPT, scFoundation, CellFM, Nicheformer, scGraphformer, + the Baek 2025 review); 1 → `00-Sources/papers/virtual/` (GenKI — it's a virtual-knockout method, not an scFM). Titles extracted from PDF page 1; originals unchanged.
- **Summaries created** (10): `yang-2022-scbert`, `theodoris-2023-geneformer`, `rosen-2023-universal-cell-embeddings`, `cui-2024-scgpt`, `hao-2024-scfoundation`, `zeng-2025-cellfm`, `tejada-lapuerta-2025-nicheformer`, `fan-2024-scgraphformer`, `baek-2025-scfm-review`, `yang-2023-genki`. (Per-paper reading + drafting was fanned out to subagents; the graph weave below was done centrally.)
- **Concepts created** (19): single-cell-foundation-model, transformer, attention-mechanism, self-supervised-pretraining, masked-language-modelling, expression-tokenization, rank-value-encoding, cell-embedding, gene-embedding, transfer-learning, fine-tuning, zero-shot-learning, cell-type-annotation, batch-integration, gene-gene-interaction, scrna-seq, spatial-transcriptomics, multi-omics, graph-neural-network.
- **Concepts updated** (2): `in-silico-perturbation` and `gene-regulatory-network` — added GenKI (VGAE virtual knockout) and the scFM route to GRN inference / perturbation prediction, connecting the scFM cluster to the existing virtual-perturbation cluster.
- **Topics**: created `single-cell-foundation-models`; extended `virtual-perturbation-screening` (GenKI + scFMs-as-predictors).
- **Synthesis note created**: `comparing-single-cell-foundation-models` — table + analysis across 8 scFMs and the review (axes: tokenization, scale, application regime, modality; bottom line that scFMs don't yet reliably beat task-specific baselines).
- **Source folder pages**: created `single-cell-foundation-models/index.md` (lists all 9 PDFs + summaries); updated `papers/index.md` and `virtual/index.md`.
- **Indexes updated**: Summaries, Concepts, Topics, Notes.
- **Notable findings / tensions**: the load-bearing cross-source tension is the review's benchmarking critique — zero-shot scFMs often do **not** beat task-specific tools (wins in cell-type/gene-function prediction; losses in imputation, cross-platform integration, network inference), and attention-derived networks are an unreliable signal. The major design fork is expression tokenization (rank vs binning vs continuous vs protein-embedding). "More data" shows diminishing/negative returns. scGraphformer is supervised-per-dataset, not a true pretrained scFM — flagged honestly.

---

## 2026-05-29 — Publish 00-Sources folders + PDF source references on the site

**Trigger**: User asked to make all source folders browsable on the public Quartz site, including `00-Sources/papers/virtual`, and to expose the ingested PDF as a source reference.

- **`.gitignore`**: stopped ignoring `00-Sources/papers/` so the open-access PDF is committed and served. Restructured the binary ignores for `books/`/`images/`/`data/` to `…/**` with negations (`!00-Sources/**/`, `!…/.gitkeep`, `!…/*.md`) so their folder structure + markdown index pages stay tracked while large binaries remain ignored. Verified with `git check-ignore`: PDF tracked, folder `index.md` tracked, sample binaries still ignored.
- **Folder landing pages** (browsable Explorer nodes — a bare PDF asset does not create an Explorer entry, only markdown pages do): created `00-Sources/index.md`, `00-Sources/papers/index.md`, `00-Sources/papers/virtual/index.md`, and stubs for `articles/`, `books/`, `images/`, `data/`.
- **PDF source reference**: linked the original PDF from the `virtual` folder page and from the summary. Quartz's Assets emitter slugifies the literal filename (`%E2%80%90` → `-percentE2-percent80-percent90`), but markdown/wikilink resolution URL-decodes `%E2%80%90` → `‐`, so naïve links 404. Fixed by linking to the **already-slugified** filename (no `%` to decode; slugify is idempotent). Verified against a local build that both links resolve to the emitted file.
- **Quartz config**: added `**/.gitkeep` to `ignorePatterns` so placeholder markers aren't copied as assets. (00-Sources was already not ignored, so it builds.)
- **Index**: added a *Sources* row to the `index.md` browse table.
- **Verified** with `npx quartz build -d ..`: 27 input files, source folders present in the Explorer tree, PDF copied to `public/00-Sources/papers/virtual/…`, all internal links resolve.

---

## 2026-05-29 — Ingest: Zhu et al. 2026, STAT3 in dentinogenesis (first source)

**Trigger**: "Ingest the new PDFs in 00-Sources/papers/virtual."

- **Source ingested** (1): `Cell Proliferation - 2026 - Zhu - Single-Cell Virtual Perturbation Screening...` (DOI 10.1111/cpr.70203, *Cell Proliferation* 2026). Title extracted from PDF page 1 (not the filename): *Single-Cell Virtual Perturbation Screening Identifies STAT3 as a Key Regulator of Dentinogenesis*.
- **Summary created** (1): [[10-Summaries/zhu-2026-stat3-dentinogenesis]].
- **Concepts created** (9): [[30-Concepts/in-silico-perturbation]], [[30-Concepts/celloracle]], [[30-Concepts/sctenifoldknk]], [[30-Concepts/scenic]], [[30-Concepts/cellrank]], [[30-Concepts/gene-regulatory-network]] (methods); [[30-Concepts/stat3]], [[30-Concepts/wnt-beta-catenin-signalling]], [[30-Concepts/dentinogenesis]] (biology).
- **Topics created** (2): [[40-Topics/virtual-perturbation-screening]], [[40-Topics/tooth-development]].
- **Indexes updated**: `index.md` (replaced the "empty wiki" blurb), `10-Summaries/index.md`, `30-Concepts/index.md`, `40-Topics/index.md`.
- **Notable findings**: The paper is a "prediction-to-verification" template — virtual knockout (CellOracle + scTenifoldKnk) as a screening front-end, then knockdown / pharmacology / conditional-KO mouse confirm STAT3 → WNT2B → canonical Wnt drives odontoblast differentiation. The authors are candid that CellOracle's static-GRN, linear-propagation, complete-ablation assumptions make it a screening tool, not a definitive predictor — captured as a contested point on the method concepts.
- **Tensions/gaps**: WNT2B rescue is only partial (other Wnt components also fall); no in vivo Wnt2b overexpression yet; CellOracle/scTenifoldKnk agreement reported but divergence behaviour unknown. First source, so no cross-source links yet.

---

## 2026-05-29 — Schema rule: extract paper titles from PDF content, not filenames

**Trigger**: User instruction on ingest behavior.

- Added a **Titles vs. filenames (papers)** convention to `CLAUDE.md`: never infer a paper's title from its filename; always open the PDF and extract the title from page 1, used verbatim as the summary note's `title:`. The source PDF filename in `00-Sources/` stays unchanged; the summary *slug* may still derive from the filename.
- Reinforced in INGEST steps 2 (Read) and 3 (Summarize).

---

## 2026-05-29 — Removed the People & labs (Entities) layer

**Trigger**: User asked to remove the People & labs folder.

- Deleted the `20-Entities/` folder and its `index.md`, and the `90-Meta/templates/entity.md` template.
- Dropped `entity` as a page type throughout the schema (`CLAUDE.md`): removed it from the three-layer list, folder layout, frontmatter `type:` enum, the INGEST "touch the graph" step, the QUERY search list, the MAINTAIN cross-reference check, the `index.md` category list, and the operating principles. The wiki graph is now Summaries → Concepts → Topics → Notes.
- Updated cross-references in `index.md` (removed the browse-table row and the layer list) and `README.md` (knowledge-graph blurb, ingest description, file-reference tree).
- Removed the `entities:` frontmatter field and `## Entities mentioned` section from `summary.md`; removed `## Key entities` from `topic.md`; removed the `[[20-Entities/...]]` link from `concept.md`'s Related section.
- Quartz Explorer (sidebar) auto-generates from folders, so removing the directory drops it from the published nav with no config change.

---

## 2026-05-29 — Wiki initialized

**Trigger**: Repository created.

- Scaffolded the vault following the [Karpathy LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f#llm-wiki): three-layer architecture (Sources → Wiki → Schema).
- Created folders: `00-Sources/` (with `articles/`, `papers/`, `books/`, `images/`, `data/`), `10-Summaries/`, `20-Entities/`, `30-Concepts/`, `40-Topics/`, `50-Notes/`, `90-Meta/templates/`, `tools/`.
- Seeded a worked example at `00-Sources/articles/example-llm-wiki.md` (Karpathy's LLM Wiki idea) so the first ingest has something to chew on.
- Configured Quartz (vendored under `.quartz/`) and a GitHub Pages deploy workflow (`.github/workflows/deploy.yml`).

No sources ingested yet. Drop a file in `00-Sources/` and say *"ingest the new sources"* to begin.

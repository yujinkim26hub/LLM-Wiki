---
type: concept
title: STAT3
aliases: [STAT3, signal transducer and activator of transcription 3, Stat3]
tags: [transcription-factor, jak-stat, dentinogenesis, signalling]
created: 2026-05-29
updated: 2026-05-29
---

# STAT3

> Signal transducer and activator of transcription 3 — a JAK/STAT-family transcription factor, activated by phosphorylation downstream of cytokines and growth factors, that Zhu et al. identify as a key driver of odontoblast differentiation.

## Definition

STAT3 is a member of the JAK–STAT signalling family that acts as a nuclear messenger, transducing extracellular signals from cytokines, hormones and growth factors (e.g. IL-6, EGF, IFN) into transcriptional activation programs once phosphorylated ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). It is classically studied in immune responses and tumorigenesis, with emerging roles in bone homeostasis ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Why it matters

Zhu et al. establish a previously uncharacterised role for STAT3 in tooth development: it is the transcription factor that drives the commitment of dental mesenchymal precursors to the odontoblast lineage ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). It is also druggable — phosphorylation can be blocked (AG490) or induced (colivelin), making it a candidate therapeutic target for [[dentinogenesis]] disorders ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Evidence in odontoblast lineage

- Nominated computationally by intersecting [[cellrank]] driver genes with [[scenic]] regulon specificity, and rises along pseudotime at pre-odontoblast commitment ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).
- Virtual knockout ([[celloracle]] + [[sctenifoldknk]]) predicted loss of odontoblast commitment ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).
- shRNA knockdown and AG490 inhibition impaired hDPC proliferation and odontoblast differentiation; colivelin activation enhanced both ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).
- `Stat3fl/fl;OsxCre` conditional-knockout mice developed dentine dysplasia with a gene-dosage effect ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Mechanism

STAT3 directly binds the **WNT2B** promoter (ChIP-confirmed; constitutively-active STAT3-C transactivates, dominant-negative STAT3-DN does not, and motif deletion abolishes the effect), thereby activating canonical [[wnt-beta-catenin-signalling]] ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]). Prior work links Stat3 loss in osteoblasts to suppressed Wnt/β-catenin and Job-syndrome-like skeletal defects, consistent with this axis ([[10-Summaries/zhu-2026-stat3-dentinogenesis]]).

## Related

- [[wnt-beta-catenin-signalling]] — the pathway STAT3 activates via WNT2B
- [[dentinogenesis]] — the process STAT3 regulates
- [[in-silico-perturbation]], [[scenic]], [[cellrank]] — how STAT3 was nominated
- [[40-Topics/tooth-development]]

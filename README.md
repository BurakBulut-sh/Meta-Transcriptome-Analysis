# Sugar beet (Beta vulgaris) transcriptome meta-analysis (RNA-seq + DESeq2 + metaRNASeq)

This repository contains a pipeline and R scripts to reproduce a Beta vulgaris RNA-seq differential expression workflow
and a small meta-analysis across studies.

Core steps mirrored from the project notes:
SRA download → FASTQ QC → HISAT2 alignment → BAM sorting → featureCounts → DESeq2 (multi-factor design)
→ contrasts (S vs R; per dpi and genotype) → annotation (biomaRt / Ensembl Plants)
→ meta-analysis (Fisher combination; sign consistency checks) → Venn diagrams → KEGG pathway visualization (pathview).

## Associated paper
Springer link: https://link.springer.com/article/10.1007/s12042-023-09344-y
DOI: https://doi.org/10.1007/s12042-023-09344-y

## Repo structure
- workflow/ : Slurm/Bash scripts to generate gene-level counts
- analysis/ : R scripts for DE, annotation, meta-analysis, and plots
- analysis/data/ : documentation of required input files (not tracked by git)

## Quick start (HPC)
1) Copy config:
   cp workflow/config.example.env workflow/config.env
   Edit workflow/config.env

2) Add run IDs:
   Edit workflow/sra_run_ids.txt

3) Run:
   bash  workflow/01_download_fastq.sh
   sbatch workflow/02_qc_fastqc.sbatch
   sbatch workflow/03_align_hisat2.sbatch
   bash  workflow/04_counts_featurecounts.sh

4) R:
   Rscript analysis/01_deseq2_multifactor_DE.R analysis/data/featurecounts_matrix.tsv analysis/data/sampleinfo.tsv

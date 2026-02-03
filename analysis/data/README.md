# Inputs (not tracked by git)

1) featurecounts_matrix.tsv
   Output of featureCounts.

2) sampleinfo.tsv
   Tab-separated with columns:
   - sample
   - condition   (e.g. R or S)
   - dpi         (e.g. 0, 2, 5)
   - genotype    (e.g. 1, 2)

3) (Optional) studies/ subfolder for meta-analysis
   If you meta-analyze multiple studies, provide per-study DESeq2 result tables (p-values and log2FC).

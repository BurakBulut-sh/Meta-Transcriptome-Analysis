#!/usr/bin/env Rscript
# This script expects you to provide per-study DESeq2 results (pvalue and log2FoldChange)
# and then combines p-values using Fisher's method (metaRNASeq-like step in notes).

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  stop("Usage: Rscript analysis/03_metaRNASeq_fisher_merge.R study1_results.csv study2_results.csv")
}

suppressPackageStartupMessages({
  library(metaRNASeq)
})

r1 <- read.csv(args[1], row.names = 1)
r2 <- read.csv(args[2], row.names = 1)

common <- intersect(rownames(r1), rownames(r2))
r1 <- r1[common, ]
r2 <- r2[common, ]

rawpval <- list(pval1 = r1$pvalue, pval2 = r2$pvalue)
fish <- fishercomb(rawpval)

out <- data.frame(
  p_study1 = r1$pvalue,
  p_study2 = r2$pvalue,
  log2FC_study1 = r1$log2FoldChange,
  log2FC_study2 = r2$log2FoldChange,
  p_fisher = fish$pvalue,
  padj_fisher = p.adjust(fish$pvalue, method = "BH"),
  row.names = common
)

# sign consistency check (as in notes)
signsum <- sign(out$log2FC_study1) + sign(out$log2FC_study2)
out$sign_consistent <- (abs(signsum) == 2)

write.csv(out, file = "analysis/meta_fisher_results.csv", row.names = TRUE)
cat("Saved: analysis/meta_fisher_results.csv\n")

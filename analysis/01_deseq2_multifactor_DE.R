#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  stop("Usage: Rscript analysis/01_deseq2_multifactor_DE.R featurecounts_matrix.tsv sampleinfo.tsv")
}

counts_file <- args[1]
sampleinfo_file <- args[2]

suppressPackageStartupMessages({
  library(DESeq2)
  library(PCAtools)
})

fc <- read.table(counts_file, header = TRUE, sep = "\t", quote = "", comment.char = "")
gene_id <- fc$Geneid
countmat <- fc[, -(1:6)]
rownames(countmat) <- gene_id

meta <- read.table(sampleinfo_file, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
rownames(meta) <- meta$sample

countmat <- countmat[, rownames(meta), drop = FALSE]

meta$condition <- factor(meta$condition)   # R / S
meta$dpi <- factor(meta$dpi)               # 0 / 2 / 5
meta$genotype <- factor(meta$genotype)     # 1 / 2

# A design consistent with the notes using multiple factors:
# adjust to include interactions if you truly need them:
design_formula <- ~ dpi + condition + genotype + dpi:condition + condition:genotype + dpi:genotype

dds <- DESeqDataSetFromMatrix(countData = round(countmat), colData = meta, design = design_formula)
dds <- dds[rowSums(counts(dds)) > 0, ]
dds <- DESeq(dds)

saveRDS(dds, file = "analysis/dds.rds")

# rlog + PCA (as in notes)
rld <- rlog(dds, blind = TRUE)
p <- pca(rld, metadata = meta, removeVar = 0.1)
pdf("analysis/pca_rlog.pdf"); biplot(p, colby = "condition", shape = "dpi"); dev.off()

cat("Saved: analysis/dds.rds and analysis/pca_rlog.pdf\n")

#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1) {
  stop("Usage: Rscript analysis/02_biomart_annotation.R gene_ids.txt")
}

genes_file <- args[1]
genes <- read.table(genes_file, header = FALSE, stringsAsFactors = FALSE)$V1

suppressPackageStartupMessages({
  library(biomaRt)
})

ensemblbeta <- useEnsemblGenomes(biomart = "plants_mart", dataset = "bvulgaris_eg_gene")

ann <- getBM(
  attributes = c("ensembl_gene_id", "description", "go_id", "kegg_enzyme"),
  filters = "ensembl_gene_id",
  values = genes,
  mart = ensemblbeta
)

write.csv(ann, file = "analysis/biomart_annotation.csv", row.names = FALSE)
cat("Saved: analysis/biomart_annotation.csv\n")

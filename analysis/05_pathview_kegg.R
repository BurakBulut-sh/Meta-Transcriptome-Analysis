#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  stop("Usage: Rscript analysis/05_pathview_kegg.R gene_fc.csv pathway_id")
}

suppressPackageStartupMessages({
  library(pathview)
})

df <- read.csv(args[1])
# Expect columns: gene_id, fc
geneData <- df$fc
names(geneData) <- df$gene_id

pathway_id <- args[2]
pv <- pathview(
  gene.data = geneData,
  gene.idtype = "KEGG",
  pathway.id = pathway_id,
  species = "bvg",
  same.layer = TRUE,
  out.suffix = "meta"
)

cat("Pathview done.\n")

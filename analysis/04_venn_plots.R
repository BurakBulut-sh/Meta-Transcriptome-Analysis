#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1) stop("Usage: Rscript analysis/04_venn_plots.R meta_fisher_results.csv")

suppressPackageStartupMessages({
  library(VennDiagram)
  library(grid)
})

x <- read.csv(args[1], row.names = 1)

# Example: define DE sets
set1 <- rownames(x)[which(x$padj_fisher < 0.05)]
set2 <- rownames(x)[which(x$sign_consistent)]

venn.plot <- venn.diagram(
  x = list(DE_fisher = set1, Sign_consistent = set2),
  filename = NULL,
  col = "black",
  fill = c("purple", "green"),
  alpha = 0.6,
  margin = 0.05
)

png("analysis/venn_meta.png", width = 900, height = 700)
grid.draw(venn.plot)
dev.off()

cat("Saved: analysis/venn_meta.png\n")

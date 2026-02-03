# Analysis notes

Key elements implemented from the original notes:
- DESeq2 multi-factor design including dpi, condition, genotype (and their interactions if needed)
- rlog transform and PCA (PCAtools)
- multiple contrasts: S vs R within dpi and genotype strata
- annotation with biomaRt (Ensembl Plants; bvulgaris_eg_gene)
- meta-analysis across studies using metaRNASeq (Fisher combination)
- sign consistency checks and conflict filtering
- Venn diagrams
- KEGG pathway visualization using pathview

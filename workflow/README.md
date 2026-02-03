# Workflow (RNA-seq → gene counts)

Implements the steps shown in the notes:
- prefetch + fasterq-dump (SRA toolkit)
- fastqc
- hisat2 alignment (index must be pre-built)
- samtools view/sort/index
- featureCounts (Subread)

Configure paths in workflow/config.env.

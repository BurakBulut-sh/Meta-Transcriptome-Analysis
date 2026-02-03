#!/usr/bin/env bash
set -euo pipefail
source workflow/config.env
mkdir -p "${COUNTS_DIR}"
[[ -n "${MOD_SUBREAD}" ]] && module load "${MOD_SUBREAD}" || true

featureCounts -a "${GTF}" -g geneid -o "${COUNTS_DIR}/featurecounts_matrix.tsv" "${BAM_DIR}"/*.sorted.bam -T "${THREADS}" -F GTF

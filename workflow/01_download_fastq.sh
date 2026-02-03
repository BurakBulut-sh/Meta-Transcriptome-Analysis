#!/usr/bin/env bash
set -euo pipefail
source workflow/config.env
mkdir -p "${FASTQ_DIR}"

while read -r run; do
  [[ -z "${run}" || "${run}" =~ ^# ]] && continue
  "${SRA_TOOLKIT_BIN}/prefetch" "${run}"
  "${SRA_TOOLKIT_BIN}/fasterq-dump" "${run}" -O "${FASTQ_DIR}" --split-files
done < workflow/sra_run_ids.txt

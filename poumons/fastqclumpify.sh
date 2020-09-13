#!/bin/sh

FASTQ_FILES=$(find "/Users/m_michel/Documents/stageM2/poumons/DATA" -type f -name "*.fastq.gz")

for FASTQ in ${FASTQ_FILES}; do
  clumpify.sh in=${FASTQ} out=clumped.fq.gz reorder
done;

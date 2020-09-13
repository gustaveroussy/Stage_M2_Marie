#!/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=3:00:00
#SBATCH --partition=shortq

VCF_FILES=$( find "/mnt/beegfs/scratch/m_michel/REANNOTATION/FILTER2/" -type f -name "*.vcf.gz" )

> filter.log

for VCF in ${VCF_FILES}; do
  FICHIER=$( cut -d/ -f8 <<<"$VCF" )
  NEW=$( echo ${FICHIER%%.*} )
  OUTPUT=/mnt/beegfs/scratch/m_michel/REANNOTATION/FILTERHIGH/${NEW}.vcf
  echo ${FICHIER}
  zgrep -E '#|HIGH' ${VCF} > ${OUTPUT}  
 done;

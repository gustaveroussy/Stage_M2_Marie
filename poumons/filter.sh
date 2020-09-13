#!/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=3:00:00
#SBATCH --partition=shortq

VCF_FILES=$( find "/mnt/beegfs/scratch/m_michel/REANNOTATION/snpsift/GeneSets/" -type f -name "*.vcf.gz" )

> filter.log

for VCF in ${VCF_FILES}; do
  FICHIER=$( cut -d/ -f9 <<<"$VCF" )
  NEW=$( echo ${FICHIER%%.*} )
  OUTPUT=/mnt/beegfs/scratch/m_michel/REANNOTATION/FILTER2/${NEW}.vcf
  echo ${FICHIER}
  #bcftools filter -i 'QUAL>30 && FORMAT/DP>20 && FORMAT/AD[0:1]>5 && (FORMAT/AD[0:1]*100)/(FORMAT/AD[0:0]+FORMAT/AD[0:1]) >= 20) ' -Oz ${VCF} > ${OUTPUT}.gz 2>> filter.log
  bcftools filter -i 'QUAL>30 & FORMAT/DP>20 & (FORMAT/AD[0:1]>20 && (FORMAT/AD[0:1]*100)/(FORMAT/AD[0:0]+FORMAT/AD[0:1]) >= 35)' -Oz ${VCF} > ${OUTPUT}.gz 2>> filter.log
 done;

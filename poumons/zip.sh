#!/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=1:00:00
#SBATCH --partition=shortq

VCF_FILES=$( find "/mnt/beegfs/scratch/m_michel/REANNOTATION/snpsift/GeneSets" -type f -name "*.vcf.gz" )


for VCF in ${VCF_FILES}; do
 #bgzip ${VCF}
  tabix ${VCF}
 done;

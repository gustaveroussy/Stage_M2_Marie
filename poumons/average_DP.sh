#!/bin/sh

FILE=average_DP.txt

>$FILE

VCF_FILES=$( find "/mnt/beegfs/scratch/m_michel/REANNOTATION/snpsift/GeneSets/" -type f -name "*.vcf.gz" )
#VCF_FILES=$( find "/mnt/beegfs/scratch/m_michel/REANNOTATION/FILTER2/" -type f -name "*.vcf.gz" )
for VCF in ${VCF_FILES}; do
        NEW=$( cut -d/ -f9 <<<"$VCF" )
	avg=$(SnpSift extractFields $VCF "GEN[*].DP" | awk '{ total += $1; count++ } END { print total/count }')
        echo -e "$NEW\t$avg">>$FILE
done;


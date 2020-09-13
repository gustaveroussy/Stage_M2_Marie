#!/bin/sh

FILE=lines_high.txt

>$FILE

#VCF_FILES=$( find "/mnt/beegfs/scratch/m_michel/REANNOTATION/snpsift/GeneSets/" -type f -name "*.vcf.gz" )
#VCF_FILES=$( find "/mnt/beegfs/scratch/m_michel/REANNOTATION/FILTER2/" -type f -name "*.vcf.gz" )
VCF_FILES=$( find "/mnt/beegfs/scratch/m_michel/REANNOTATION/FILTERHIGH/" -type f -name "*.vcf" )

for VCF in ${VCF_FILES}; do
	NEW=$( cut -d/ -f8 <<<"$VCF" )
	#lines=$(gunzip -c ${VCF} | wc -l)
	lines=$(wc -l ${VCF} | cut -f1 -d ' ')
	echo -e "$NEW\t$lines">>$FILE
done;

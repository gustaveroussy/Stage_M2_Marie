#!/usr/bin/env zsh

##Marie MICHEL

##installation requise : tabix

##ICGC germline vcf entier (données non US)

## position connue sur HG37 on peut récupérer directement la ligne
##on prend région 1000kb autours du snp qu'on avait repéré

# lien pour télécharger https://dcc.icgc.org/api/v1/download?fn=/PCAWG/germline_variations/pcawg8.snps.indels.svs.phased.icgc.v2.controlled.vcf.gz
# /!\ on doit être co !!!

tabix pcawg8.snps.indels.svs.phased.icgc.v2.controlled.vcf.gz
tabix -h pcawg8.snps.indels.svs.phased.icgc.v2.controlled.vcf.gz 9:21016240-21018240 > pol_1kb.vcf

while IFS= read -r line; do
		if ! [[ $line =~ (^#) ]]; then awk -F"\t" 'BEGIN {print "CHR\tPOS\tID\tREF\tALT\tnTot\tnHet\tnHomRef\tnHomAlt\tnref\tnalt"} \
	      {nhet=gsub(/0\|1|1\|0|0\/1|1\/0/, ""); nhomref=gsub(/0\|0|0\/0/, ""); nhomalt=gsub(/1\|1|1\/1/, ""); ntot=(nhet+nhomref+nhomalt);
	        print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"ntot"\t"nhet"("(nhet/ntot)*100"%)\t"nhomref"("(nhomref/ntot)*100"%)\t"nhomalt"("(nhomalt/ntot)*100"%)\t"(nhomref*2+nhet)"("((nhomref*2+nhet)/(ntot*2))*100"%)\t"(nhomalt*2+nhet)"("((nhomalt*2+nhet)/(ntot*2))*100"%)"}' > pol_stat_1kb.vcf; fi
done < pol_1kb.vcf

#snps randoms : 
tabix -h pcawg8.snps.indels.svs.phased.icgc.v2.controlled.vcf.gz 9 | shuf -n 10  > random.vcf

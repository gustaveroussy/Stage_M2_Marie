
#!/usr/bin/env zsh

##Marie MICHEL

##installation requise : tabix

##1000Genome project

## position connue sur HG37 on peut récupérer directement la ligne
## mais il est possible de sélectionner une région
## 9:21017240-21017240 chr:deb-fin
echo "Getting vcf files"
tabix -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr9.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 9:21017240-21017240 > pol.vcf

echo "Statistics > 1000G_stat.vcf"
#pour être sûr qu'on regarde bien le bon snp, intéressant quand on a pris une région plutôt qu'une position directement
grep rs12553564 pol.vcf | \
	awk -F"\t" 'BEGIN {print "CHR\tPOS\tID\tREF\tALT\tnTot\tnHet\tnHomRef\tnHomAlt\tnref\tnalt"} \
      {nhet=gsub(/0\|1|1\|0|0\/1|1\/0/, ""); nhomref=gsub(/0\|0|0\/0/, ""); nhomalt=gsub(/1\|1|1\/1/, ""); ntot=nhet+nhomref+nhomalt;
        print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"ntot"\t"nhet*2"("(nhet/ntot)*100"%)\t"nhomref"("(nhomref/ntot)*100"%)\t"nhomalt"("(nhomalt/ntot)*100"%)\t"(nhomref*2+nhet)"("()(nhomref*2+nhet)/ntot)*100"%)\t"(nhomalt*2+nhet)"("((nhomalt*2+nhet)/ntot)*100"%)"}' > 1000G_stat.vcf

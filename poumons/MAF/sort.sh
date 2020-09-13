#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --mem=5GB

#on enlève une ligne partiellement
#sed '17015532d' final_maf.csv > final_maf_cut.csv
#sed 's/chr1/1/g' final_maf_cut.csv > final_maf_sed.csv
cut -f1,2,5,6,7,9,10,11,12,16,33,35,44 final_maf_sed.csv | (head -n 1 && tail -n +2 | sort)| uniq > final_uniq.csv


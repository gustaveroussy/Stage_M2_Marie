#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --mem=5GB

grep -E 'Hugo_Symbol|HIGH' final_maf.csv > final_high.csv
cut -f1,2,5,6,7,9,10,11,12,16,33,35,44,45 final_high.csv | (head -n 1 && tail -n +2 | sort)| uniq > final_uniq.csv


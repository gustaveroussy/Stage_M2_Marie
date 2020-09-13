#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --mem=5GB

#Rscript --vanilla variant.R
Rscript --vanilla script.R

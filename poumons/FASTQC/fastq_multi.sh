#!/bin/sh

job_ids=$(for FASTQC in 'cat /mnt/beegfs/scratch/m_michel/FASTQC/filename.txt'; do
  srun --cpus-per-task 2 \
       --mem 1G \
       --partition mediumq \
      fastqc ${FASTQ} -o /mnt/beegfs/scratch/m_michel/DATA/FASTQC > ${FASTQ}.log 2>&1;
done);

srun --cpus-per-task 2 \
     --mem 1G \
     --partition mediumq \
     --dependency afterok$(printf ":%s" "${job_ids[@]}") \
     multiqc . -o /mnt/beegfs/scratch/m_michel/DATA/FASTQC/MULTIQC &

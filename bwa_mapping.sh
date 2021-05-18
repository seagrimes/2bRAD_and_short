module load bwa/0.7.17
module load samtools/1.11

bwa mem -R "@RG\tID:Op262\tLB:Op262\tSM:Op262\tPL:ILLUMINA" -M -t 100 astrotoma_ref  /scratch/cjg0067/astrotoma/Astrotoma_agassizii_Op262_R2.fastq /scratch/cjg0067/astrotoma/Astrotoma_agassizii_Op262_R1.fastq >  /scratch/cjg0067/astrotoma/astrotoma_262.sam
samtools flagstat  astrotoma_262.sam >  astrotoma_262.samstat.txt
samtools view -b  astrotoma_262.sam >  astrotoma_262.bam
samtools sort  astrotoma_262.bam -o  astrotoma_262.sorted.bam

done

module load bwa/0.7.17
module load samtools/1.11

bwa mem -R "@RG\tID:NAME\tLB:NAME\tSM:NAME\tPL:ILLUMINA" -M -t 100 genome_ref  forward_read.fastq reverse_read.fastq >  combined.sam
samtools flagstat  combined.sam >  combined.samstat.txt
samtools view -b  combined.sam >  combined.bam
samtools sort  combined.bam -o  combined.sorted.bam

done

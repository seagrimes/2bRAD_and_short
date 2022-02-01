#!/bin/sh
module load stacks
module load python
module load gcc/9.3.0

# Run gstacks to build loci from the aligned paired-end data. We have instructed
# gstacks to remove any PCR duplicates that it finds.
gstacks -I aligned -M popmap --rm-pcr-duplicates -O output -t 16

# Run populations. Calculate Hardy-Weinberg deviation, population statistics, f-statistics and 
# smooth the statistics across the genome. 
populations -P output -O output_pops -M popmap --genepop --fstats --smooth --hwe -k --sigma=150000 --vcf

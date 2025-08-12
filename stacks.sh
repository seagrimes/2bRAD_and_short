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

# Downstream filtering
vcftools --vcf output_pops/populations.snps.vcf --max-missing 0.8 --maf 0.05 --recode --out output_pops/filtered

# Prepare STRUCTURE format
java -Xmx4g -jar PGDSpider2.jar -inputfile output_pops/filtered.recode.vcf -inputformat VCF -outputfile output_pops/structure.str -outputformat STRUCTURE -spid vcf2structure.spid

# Run STRUCTURE (example for K=3)
structure -m mainparams -e extraparams -K 3 -i output_pops/structure.str -o results_dir/K3_run1

# Post-STRUCTURE analysis
# Evanno method with Structure Harvester
# Merge replicates with CLUMPP
# Plot Q-matrices in R:

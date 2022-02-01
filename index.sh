ce#!/bin/bash
module load bwa/0.7.17

bwa index -a bwtsw -p reference_genome genome_assembly.fa

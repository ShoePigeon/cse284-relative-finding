#!/bin/bash

SAMPLEINFO=~/public/1000Genomes/igsr_samples.tsv

awk -F'\t' '
BEGIN { OFS="\t" }
NR > 1 {
    print $1, $4
}' $SAMPLEINFO > sample_populations.txt
#!/bin/bash
# run_1000g_analysis.sh
# Prepare 1000 Genomes chr22 data and run PLINK + KING
# This uses the full dense VCF which should work with KING --ibdseg

set -e

DATA_DIR=~/cse284-relative-finding/data
RESULTS_DIR=~/cse284-relative-finding/results
KING=~/king
CHR22_VCF=~/public/1000Genomes/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz

mkdir -p $DATA_DIR $RESULTS_DIR

echo "=== Step 1: Convert chr22 VCF to PLINK binary format ==="
echo "This may take a few minutes..."
START=$(date +%s)

plink --vcf $CHR22_VCF \
      --make-bed \
      --out $DATA_DIR/1000g_chr22 \
      --allow-extra-chr

END=$(date +%s)
echo "Conversion took $((END-START)) seconds"

echo ""
echo "=== Step 2: Check data dimensions ==="
wc -l $DATA_DIR/1000g_chr22.fam
wc -l $DATA_DIR/1000g_chr22.bim

echo ""
echo "=== Step 3: Run PLINK --genome on chr22 ==="
echo "Timing PLINK..."
START=$(date +%s)

plink --bfile $DATA_DIR/1000g_chr22 \
      --genome \
      --min 0.1 \
      --out $RESULTS_DIR/1000g_chr22_plink

END=$(date +%s)
PLINK_TIME=$((END-START))
echo "PLINK took $PLINK_TIME seconds"

echo ""
echo "=== Step 4: Run KING --related on chr22 ==="
echo "Timing KING..."
START=$(date +%s)

$KING -b $DATA_DIR/1000g_chr22.bed \
      --related --degree 2 \
      --prefix $RESULTS_DIR/1000g_chr22_king_related

END=$(date +%s)
KING_RELATED_TIME=$((END-START))
echo "KING --related took $KING_RELATED_TIME seconds"

echo ""
echo "=== Step 5: Run KING --ibdseg on chr22 ==="
echo "Timing KING ibdseg..."
START=$(date +%s)

$KING -b $DATA_DIR/1000g_chr22.bed \
      --ibdseg \
      --prefix $RESULTS_DIR/1000g_chr22_king_ibdseg

END=$(date +%s)
KING_IBDSEG_TIME=$((END-START))
echo "KING --ibdseg took $KING_IBDSEG_TIME seconds"

echo ""
echo "=== Step 6: Check outputs ==="
echo "PLINK output:"
wc -l $RESULTS_DIR/1000g_chr22_plink.genome 2>/dev/null || echo "  No output file"
head -5 $RESULTS_DIR/1000g_chr22_plink.genome 2>/dev/null || true

echo ""
echo "KING --related output:"
ls -la $RESULTS_DIR/1000g_chr22_king_related* 2>/dev/null || echo "  No output files"
head -5 $RESULTS_DIR/1000g_chr22_king_related.kin0 2>/dev/null || true

echo ""
echo "KING --ibdseg output:"
ls -la $RESULTS_DIR/1000g_chr22_king_ibdseg* 2>/dev/null || echo "  No output files"

echo ""
echo "=== RUNTIME SUMMARY ==="
echo "PLINK --genome:  $PLINK_TIME seconds"
echo "KING --related:  $KING_RELATED_TIME seconds"
echo "KING --ibdseg:   $KING_IBDSEG_TIME seconds"
echo ""
echo "Data: 1000 Genomes Phase 3, chr22, 2504 samples"
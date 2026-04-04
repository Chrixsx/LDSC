#!/bin/bash
#SBATCH --job-name=munge_ldsc
#SBATCH --time=1:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --mail-user=le.c@wehi.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --output=/vast/projects/Epilepsy_Metabolites/scripts/LDSC/Lotta2020/_slurm_logs/munge_Lotta2020_%A_%a.out
#SBATCH --error=/vast/projects/Epilepsy_Metabolites/scripts/LDSC/Lotta2020/_slurm_logs/munge_Lotta2020_%A_%a.err
#SBATCH --array=1-174%50

# NOTE: LDSC have issue with p_value lower than 1e-300 => Need to cap p_value by changing any p_value <1e-300 to 1e-300

# Load conda environment
source /home/users/allstaff/le.c/miniconda3/etc/profile.d/conda.sh
conda activate ldsc

# Define directories
APP_DIR="/home/users/allstaff/le.c/ldsc"
TUT_DIR="/home/users/allstaff/le.c/eur_w_ld_chr_file"

SUMSTATS_DIR="/vast/projects/Epilepsy_Metabolites/data/Lotta2020/reformatted/reformatted_gwas"
OUT_DIR="/vast/projects/Epilepsy_Metabolites/scripts/LDSC/Lotta2020/1_munge"

# Get all summary stat files into an array
mapfile -t files < <(ls ${SUMSTATS_DIR}/*_reformatted_Lotta2020.tsv.gz)

# Get the file for this SLURM array task (adjust for zero-based index)
file="${files[$((SLURM_ARRAY_TASK_ID-1))]}"
filename=$(basename "$file")
metabolite="${filename%_reformatted_Lotta2020.tsv.gz}"

echo "Processing $metabolite with file $file"

# Run munge_sumstats.py
${APP_DIR}/munge_sumstats.py \
--sumstats "$file" \
--snp SNP \
--a1 A1 \
--a2 A2 \
--p P \
--chunksize 500000 \
#--N N \ #if use fixed number
--N-col N \
--signed-sumstats BETA,0 \
--out "${OUT_DIR}/${metabolite}_Lotta2020_munge" \
--merge-alleles "${TUT_DIR}/w_hm3.snplist"

echo "Completed $metabolite"

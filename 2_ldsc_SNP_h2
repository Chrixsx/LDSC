#!/bin/bash
#SBATCH --job-name=ldsc_h2
#SBATCH --time=1:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --mail-user=le.c@wehi.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --output=/vast/projects/Epilepsy_Metabolites/scripts/LDSC/Lotta2020/_slurm_logs/snph2_Lotta2020_%A_%a.out
#SBATCH --error=/vast/projects/Epilepsy_Metabolites/scripts/LDSC/Lotta2020/_slurm_logs/snph2_Lotta2020_%A_%a.err
#SBATCH --array=1-174%50

# Load conda environment
source /home/users/allstaff/le.c/miniconda3/etc/profile.d/conda.sh
conda activate ldsc

APP_DIR="/home/users/allstaff/le.c/ldsc"
REF_DIR="/home/users/allstaff/le.c/eur_w_ld_chr_file"

MUNGE_DIR="/vast/projects/Epilepsy_Metabolites/scripts/LDSC/Lotta2020/1_munge/munge"
OUT_DIR="/vast/projects/Epilepsy_Metabolites/scripts/LDSC/Lotta2020/2_ldsc_h2"


# Get the file corresponding to the SLURM_ARRAY_TASK_ID
FILES=(${MUNGE_DIR}/*_Lotta2020_munge.sumstats.gz)
FILE=${FILES[$SLURM_ARRAY_TASK_ID-1]}

# Extract basename without path
BASENAME=$(basename "$FILE")

# Extract metabolite name by removing suffix "_munge.sumstats.gz"
METABOLITE_NAME=${BASENAME%_Lotta2020_munge.sumstats.gz}

# Run ldsc munge_sumstats.py to estimate SNP-based heritability (h2)
${APP_DIR}/ldsc.py \
--h2 "${FILE}" \
--ref-ld-chr ${REF_DIR}/ \
--w-ld-chr ${REF_DIR}/ \
--out "${OUT_DIR}/${METABOLITE_NAME}_Lotta2020_snph2_observedscale"



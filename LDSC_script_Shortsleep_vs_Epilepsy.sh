##############################################################################
# LDSC example of two traits: Short Sleep and Common Epilepsy traits (All Epilepsy; Genetic Generalized Epilepsy; Focal Epilepsy)

##### Step 1: Format and Clean + QC the raw GWAS Sumstats with munge_sumstats.py #####

conda activate ldsc

# a/ Save file_directory as variables for easy fix (when change file location).
export APP_DIR="/stornext/Bioinf/data/lab_bahlo/users/le.c/LD_reg/ldsc"  										# LDSC tool directory
export TUT_DIR="/stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic"								# Reference panel directory
export SUMSTATS_DIR="/stornext/Bioinf/data/lab_bahlo/users/le.c/Data/download_sleepreview_data/sleep_duration" 	# Raw GWAS directory
export OUT_DIR="/stornext/Bioinf/data/lab_bahlo/users/le.c/Data/download_sleepreview_data/sleep_duration"		# Munge output directory 

#####Munge_Sumstat####
# b/ Munge_sumstats for Trait 1- Short Sleep
${APP_DIR}/munge_sumstats.py \
--sumstats ${SUMSTATS_DIR}/shortsumstats.txt \
--snp SNP \
--a1 ALLELE1 \
--a2 ALLELE0 \
--p P_SHORTSLEEP \
--chunksize 500000 \   # Argument to read chunk of 50,000 SNPs at a time to avoid munge_sumstats.py crashing
--N 106192 \
--signed-sumstats BETA_SHORTSLEEP,0 \
--out ${OUT_DIR}/test_shortsleep_sumstat \
--merge-alleles ${TUT_DIR}/w_hm3.snplist

# c/ Munge_sumstats for Trait 1- GGE
# Munged files for epilepsy traits received from KO, but the step is similar to b/


##### Step 2: Cross-trait LD score regression with ldsc.py #####
# a/ Save file_directory as variables for easy fix (when change file location).
export APP_DIR="/stornext/Bioinf/data/lab_bahlo/users/le.c/LD_reg/ldsc"										# LDSC tool directory
export SUMSTATS_DIR="/stornext/Bioinf/data/lab_bahlo/users/le.c/Data"										# Munged file directory
export REF_DIR="/stornext/Bioinf/data/lab_bahlo/users/le.c/Data/toy_munge_data/eur_w_ld_chr"  				# European LD scores (from 1000 Genomes) directory
export OUT_DIR="/stornext/Bioinf/data/lab_bahlo/users/le.c/Data/download_sleepreview_data/sleep_duration" 	# LDSC outcome directory

# b/ Running LDSC function

# Short sleep vs All Epilepsy
${APP_DIR}/ldsc.py \
--rg ${SUMSTATS_DIR}/download_sleepreview_data/sleep_duration/sumstats_shortsleep.sumstats.gz,\
${SUMSTATS_DIR}/Summary_Statistic/Epilepsi/Karen_File/ILAE3.7_Caucasian_all_epilepsy1.sumstatsKO.gz \
--ref-ld-chr ${REF_DIR}/ \
--w-ld-chr ${REF_DIR}/ \
--out ${OUT_DIR}/shortsleep_allepilepsy
##End Short sleep vs All Epilepsy

# Short sleep vs GGE
${APP_DIR}/ldsc.py \
--rg ${SUMSTATS_DIR}/download_sleepreview_data/sleep_duration/sumstats_shortsleep.sumstats.gz,\
${SUMSTATS_DIR}/Summary_Statistic/Epilepsi/Karen_File/ILAE3.7_Caucasian_generalised1.sumstatsKO.gz \
--ref-ld-chr ${REF_DIR}/ \
--w-ld-chr ${REF_DIR}/ \
--out ${OUT_DIR}/shortsleep_GGE
#End Short sleep vs GGE
${APP_DIR}/ldsc.py \

# Short sleep vs Focal Epilepsy
${APP_DIR}/ldsc.py \
--rg ${SUMSTATS_DIR}/download_sleepreview_data/sleep_duration/sumstats_shortsleep.sumstats.gz,\
${SUMSTATS_DIR}/Summary_Statistic/Epilepsi/Karen_File/ILAE3.7_Caucasian_focal1.sumstatsKO.gz \
--ref-ld-chr ${REF_DIR}/ \
--w-ld-chr ${REF_DIR}/ \
--out ${OUT_DIR}/shortsleep_focalepilepsy
#End Short sleep vs Focal Epilepsy























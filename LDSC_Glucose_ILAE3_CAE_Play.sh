-----Note-----
#Get w_hm3.snplist from https://ibg.colorado.edu/cdrom2021/Day06-nivard/GenomicSEM_practical/eur_w_ld_chr/w_hm3.snplist
#Get European LD scores from 1000 Genomes) from https://zenodo.org/records/8182036/files/eur_w_ld_chr.tar.gz?download=1 (

ssh vc7-shared.wehi.edu.au 
conda activate ldsc 
-----Command_Start_Here -----

#####glucose.log####
/stornext/Bioinf/data/lab_bahlo/users/le.c/LD_reg/ldsc/munge_sumstats.py \
--sumstats /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/blood_glucose/GCST90271557.tsv \
--snp rs_id \
--a1 effect_allele \
--a2 other_allele \
--p p_value \
--out /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/blood_glucose/glucose \
--merge-alleles /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/w_hm3.snplist \


# /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/blood_glucose/glucose.log

/stornext/Bioinf/data/lab_bahlo/users/le.c/LD_reg/ldsc/munge_sumstats.py \
--sumstats /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/Epilepsi/ILAE3_CAE_final.tbl \
--snp MarkerName \
--N 100000 \
--out /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/Epilepsi/CAE \
--merge-alleles /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/w_hm3.snplist \

# /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/blood_glucose/CAE.log


#LD score Regression---------(NOT COMPLETE)
/stornext/Bioinf/data/lab_bahlo/users/le.c/LD_reg/ldsc/ldsc.py \
--/stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/Epilepsi/CAE.log,/stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/blood_glucose/glucose.log
--ref-ld-chr /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/


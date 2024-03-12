#Get w_hm3.snplist from https://ibg.colorado.edu/cdrom2021/Day06-nivard/GenomicSEM_practical/eur_w_ld_chr/w_hm3.snplist
# /stornext/Bioinf/data/lab_bahlo/users/le.c/LD_reg/ldsc/munge_sumstats.py \ 

--sumstats /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/blood_glucose/GCST90271557.tsv \
--snp rs_id \
--a1 effect_allele \
--a2 other_allele \
--p p_value \
--N-col n \
--out /stornext/Bioinf/data/lab_bahlo/users/le.c/Data/Summary_Statistic/blood_glucose/output/GCST90271557.tsv
--merge-alleles /stornext/Bioinf/data/lab_bahlo/users/le.c/LD_reg/ldsc/ref_data/w_hm3.snplist \


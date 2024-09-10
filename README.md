LD Score Regression to estimate the genetic correlation between a pair of traits.  
Aim: Estimate the genetic correlation (r<sup>2</sup>) between epilepsy traits versus other traits (i.e., metabolites/biomarkers, habitual sleep duration, circadian-related)  
Example script: refer to LDSC_script_Shortsleep_vs_Epilepsy.sh 

Analysis Overview:  
-- Step 1: Format and Clean the raw GWAS Sumstats with munge_sumstats.py  
-- Step 2: Cross-trait LD score regression with ldsc.py  

##### Useful sources #####
LDSC GitHub: https://github.com/bulik/ldsc   
Useful tutorial: https://cloufield.github.io/GWASTutorial/08_LDSC/

#!/bin/bash
#SBATCH --job-name=fsc_array
#SBATCH -c 20
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=11-12:00:00
## Memory per node
#SBATCH --array=1-100%10

##### ENVIRONMENT SETUP ##########
DATADIR= # The directory containing all of your .tpl .est and .obs files
PREFIX=''
##############################################################################
module load fastsimcoal

## 1. Move into the directory containing the required input files
cd $DATADIR'/'$PREFIX

## 2. This command runs 100 iterations of fastsimcoal using a MAF (-m) while ignoring monomorphic 
##    sites (-0) and SFS entries with less than 10 SNPs (-C). This means that entries with less 
##    than 10 SNPs are pooled together. This option is useful when there are many entries in 
##    the observed SFS with few SNPs and with a limited number of SNPS to avoid overfitting.
##    fastsimcoal will also perform (-n) 500,000 coalescent simulations to approximate the 
##    expected SFS in each cycle and will run (-L) 75 optimization (ECM) cycles to estimate 
##    the parameters. We also specify (-M) that we want to perform parameter estimation. 
##    With -s 0, we can tell fastsimcoal to output SNPs.
i=${SLURM_ARRAY_TASK_ID}
mkdir run$i
cp ${PREFIX}.tpl ${PREFIX}.est ${PREFIX}_jointMAFpop1_0.obs ${PREFIX}_jointMAFpop2_0.obs ${PREFIX}_jointMAFpop2_1.obs run$i"/"
cd run$i
fastsimcoal2 -t ${PREFIX}.tpl -e ${PREFIX}.est -m -0 -C 10 -n 150000 -L 40 -s0 -M -q -c 20

# fastsimcoal_BCQ_rockfish
This README outlines the process for running fastsimcoal on the dataset for ____. Most of the code was modified for use based on [this workshop](https://speciationgenomics.github.io/fastsimcoal2/) which I highly recommend for first-time fastsimcoal users. Below is the step-by-step process, with applicable script names included for easy reference. 

### Models
I attempted to model three scenarios: 
<img width="1133" alt="Screen Shot 2023-11-15 at 2 58 58 PM" src="https://github.com/anita-wray/fastsimcoal_BCQ_rockfish/assets/82060951/9615931f-cba4-4965-8c12-93757822c859">
In the scenarios, the admixture was modeled as 'ancient' and stopped at least 100 generations (~1,000 years) ago.

Generation time was adapted from: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8923369/#SD1

Divergence time was from: https://pubmed.ncbi.nlm.nih.gov/17320419/

Mutation rate was from: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8923369/#SD1

### Easy SFS
I used [easySFS](https://github.com/isaacovercast/easySFS) to convert VCF files into SFS files for fastsimcoal. This program was built specifically for RADseq data and accounts for missing data during the conversion. For this dataset, the best projection values were BR_SPS = 38; CO_SPS =  40; QB_SPS = 30. Projection values reported by easySFS are not # of individuals, but 2x # of individuals for diploids. 

```  ../easySFS.py -i ${PREFIX}.bs.$i.vcf.gz -p ${pop_file} -a -f --proj 38,40,30```

### Fastsimcoal Run
To run fastsimcoal, I ran the below code 100 times:

```fastsimcoal2 -t ${PREFIX}.tpl -e ${PREFIX}.est -m -0 -C 10 -n 150000 -L 40 -s0 -M -q```

This command runs 100 iterations of fastsimcoal using a MAF (-m) while ignoring monomorphic sites (-0) and SFS entries with less than 10 SNPs (-C). This means that entries with less than 10 SNPs are pooled together. This option is useful when there are many entries in the observed SFS with few SNPs and with a limited number of SNPS to avoid overfitting. Fastsimcoal will also perform (-n) 150,000 coalescent simulations to approximate the expected SFS in each cycle and will run (-L) 40 optimization (ECM) cycles to estimate the parameters. We also specify (-M) that we want to perform parameter estimation. With -s 0, we can tell fastsimcoal to output SNPs.

As mentioned above, this was run 100 times each in a separate 'run' folder. The best run was chosen based on the minimum difference between the MaxEstLhood	and MaxObsLhood using the find_best_fsc_run.sh script.

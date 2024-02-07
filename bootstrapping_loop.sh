PREFIX='CQB_boot'
pop_file='pops_file.txt'
# Generate 50 files each with randomly concatenated blocks and compute the SFS for each:
for i in {1..100}
do
  # Move to folder for each bootstrapping iteration:
  cd bs$i

  # Compress the vcf file again
  gzip ${PREFIX}.bs.$i.vcf

  # Make an SFS from the new bootstrapped file
  ../easySFS.py -i ${PREFIX}.bs.$i.vcf.gz -p ${pop_file} -a -f --proj 38,40,30

  # Say that it is finished with iteration $i
  echo bs$i" ready"

  cd ..
done
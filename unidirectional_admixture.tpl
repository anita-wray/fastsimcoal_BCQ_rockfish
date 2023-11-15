//Parameters for the coalescence simulation program : fastsimcoal.exe
3 samples to simulate :
//Population effective sizes (number of genes)
NMB$
NMC$
NMQ$
//samples sizes 
46
46
44
//Growth rates: negative growth implies population expansion
0
0
0
//Number of migration matrices : 0 implies no migration between demes
3
//Migration matrix 0
0	0	0
0	0	0
0	0	0
//Migration matrix 1
0	0	0
0	0	0
MIG1	MIG1 	0
//Migration matrix 2
0	0	0
0	0	0
0	0	0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
3 historical event
TMIGSTART$ 0 0 0 1 0 1
TD1$ 2 1 1 NANC01$ 0 2 
TD2$ 0 1 1 NANC02$ 0 2
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ 1 0 1e-9 OUTEXP

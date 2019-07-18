# Week 13 notes

The files Osativa_323_v7.0.defline.txt, Osativa_323_v7.0.gene.gff3.gz,
Osativa_323_v7.0.hardmasked.fa.gz, and Osativa_323_v7.0.transcript.fa.gz
can be downloaded from
[Oryza sativa v7_JGI](https://phytozome.jgi.doe.gov/pz/portal.html#!info?alias=Org_Osativa)
on Phytozome.

The study is listed on NCBI here: https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=DRP000159

To get the FASTQ files of the sequencing data, first download and unzip the
fastq-dump program: https://ncbi.github.io/sra-tools/fastq-dump.html

Then run the command

`fastq-dump -O myfolder DRR000349 DRR000350 DRR000351 DRR000352 DRR000353 DRR000354 DRR000355 DRR000356 DRR000357`

where "myfolder" is a path to a folder where you want to save the files.

Mizuno H et al., "Massive parallel sequencing of mRNA in identification of
unannotated salinity stress-inducible transcripts in rice (*Oryza sativa* L.).",
BMC Genomics, 2010 Dec 2;11:683

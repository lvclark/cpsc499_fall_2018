# packages for today
# install with BiocManager::install() if necessary
# BiocManager::install("Rsamtools") for example
library(Biostrings)
library(GenomicRanges)
library(GenomicFeatures)
library(Rsamtools)

myDNA <- DNAString("ATGACCAAAGGT")
myDNA

myDNA2 <- DNAStringSet(c("ATGACCAAAGGT", 
                         "GGGGGAC", "TAGGATTT"))
myDNA2
myDNA2[1:2]
myDNA2[[1]][3:6]

# importing sequences
slyco_cds_file <-  "Slycopersicum_390_ITAG2.4.cds_primaryTranscriptOnly.fa"

tomato_cds <- readDNAStringSet(slyco_cds_file)
tomato_cds
writeXStringSet(tomato_cds[100:110], file = "some_genes.fa")

# working with XStrings
length(tomato_cds)
nchar(tomato_cds)
width(tomato_cds)

myDNA2 == "GGGGGAC"
match("GGGGGAC", myDNA2)

reverseComplement(tomato_cds[1:2])
translate(tomato_cds[1])
translate(tomato_cds[[1]][2:300])

matchPattern("GGGCAC", tomato_cds[[1]])
matchPattern("ATG", tomato_cds[[1]])

mymatches <- vmatchPattern("GGGCAC", tomato_cds)
length(mymatches)
?`MIndex-class` # learn more about methods for this object
tomato_cds[elementNROWS(mymatches) > 0]

matchPattern("ATR", tomato_cds[[1]],
             fixed = FALSE)

# mini-exercise - look at aa sequences from Lab 4
rice_protein <- readAAStringSet("../Lecture_4/Osativa_323_v7.0.protein.fa")
rice_protein
names(rice_protein)
rice_matches <- vmatchPattern("HSF", rice_protein)
rice_matches

# pairwise alignment
arabidopsis_TFL1 <- readDNAStringSet("Arabidopsis_thaliana_TFL1_sequence.fa")
arabidopsis_TFL1
potato_TFL1 <- readDNAStringSet("Solanum_tuberosum_PGSC0003DMG400040097_sequence.fa")
potato_TFL1

myalign <- pairwiseAlignment(potato_TFL1, arabidopsis_TFL1,
                             type = "global")
myalign
writePairwiseAlignments(myalign, file = "myalign.txt")
as.matrix(myalign)
indel(myalign)

myalign <- pairwiseAlignment(translate(potato_TFL1),
                             translate(arabidopsis_TFL1),
                             type = "global")
myalign
potato_TFL1[[1]][3:50]
subseq(potato_TFL1, 3, 50) # efficient way to get subsequence on whole set

small_potato_TFL1 <- subseq(potato_TFL1, 3, 50)

myalign1 <- pairwiseAlignment(small_potato_TFL1, arabidopsis_TFL1,
                              type = "global")
myalign1
myalign2 <- pairwiseAlignment(small_potato_TFL1, arabidopsis_TFL1,
                              type = "local")
myalign2

# working with whole genome
myfafile <- "Slycopersicum_390_v2.5.fa"
#indexFa(myfafile) # use once to create .fai file

tomato_genome <- FaFile(myfafile)
countFa(tomato_genome)
seqinfo(tomato_genome) # Seqinfo object - used a lot in Bioconductor
seqnames(seqinfo(tomato_genome))
seqlengths(seqinfo(tomato_genome)) > 60000000

myposition <- GRanges(c("SL2.50ch09","SL2.50ch09"),
                      IRanges(c(40000, 60000), 
                              c(40999, 61999)))
myposition

getSeq(tomato_genome, myposition)
seqinfo(myposition)

names(myposition) <- c("gene1", "gene2")
myposition
mcols(myposition) <- data.frame(experiment = c("Exp1", "Exp2"),
                                stringsAsFactors = FALSE)
myposition
mcols(myposition)

# genome annotation
# tomato_TxDb <- makeTxDbFromGFF("Slycopersicum_390_ITAG2.4.gene.gff3",
#                                format = "gff3",
#                                organism = "Solanum lycopersicum",
#                                dataSource = "Phytozome 12")
# saveDb(tomato_TxDb, file = "tomato_TxDb.sqlite")
loadDb("tomato_TxDb.sqlite")

tomato_TxDb
seqlevels(tomato_TxDb)
columns(tomato_TxDb)
keytypes(tomato_TxDb)
keys(tomato_TxDb, keytype = "GENEID")
keys(tomato_TxDb, keytype = "CDSID")

myexons <- exons(tomato_TxDb, filter = list(GENEID = c("Solyc01g005920.2",
                                            "Solyc01g005780.1",
                                            "Solyc01g006120.2")))
getSeq(tomato_genome, myexons)

mysnp <- GRanges("SL2.50ch01",
                 IRanges(20900000, 20950000))
candidate_genes <- transcriptsByOverlaps(tomato_TxDb, mysnp)
mcols(candidate_genes)$tx_name

tomato_exons_by_gene <- exonsBy(tomato_TxDb, by = "gene")
tomato_exons_by_gene
tomato_exons_by_gene[["Solyc01g006120.2"]]

myseq <- getSeq(tomato_genome, tomato_exons_by_gene[["Solyc01g006120.2"]])
myseq
unlist(myseq) # put them all together into one sequence
unlist(rev(myseq)) # put in reverse order for - strand

library(Biostrings)
library(Rsamtools)

oryzagenes <- readAAStringSet("Osativa_323_v7.0.protein.fa")

oryzagenes

grep("MARA[QS]", oryzagenes)

matchPattern("MAR", oryzagenes[[52420]])

At_TFL1 <- readDNAStringSet("Arabidopsis_thaliana_TFL1_sequence.fa")
St_TFL1 <- readDNAStringSet("Solanum_tuberosum_PGSC0003DMG400040097_sequence.fa")

At_TFL1
St_TFL1

myalign <- pairwiseAlignment(St_TFL1, At_TFL1[[1]])
myalign

consensusString(myalign)
indel(myalign)
myalign2 <- pairwiseAlignment(translate(St_TFL1), translate(At_TFL1[[1]]))
myalign2

writePairwiseAlignments(myalign2, file = "TFL1aa.txt")

testrange <- GRanges(c("Chr01", "Chr02", "Chr02"),
        IRanges(c(200, 110046, 3005),
                c(340, 115077, 4200)))
names(testrange) <- c("favorite gene", "okay gene", "meh gene")
testrange
mcols(testrange) <- data.frame(When_I_decided_it_was_cool = as.Date(c("2018-09-05", "2018-09-07", "2018-10-20")),
                               stringsAsFactors = FALSE)
testrange

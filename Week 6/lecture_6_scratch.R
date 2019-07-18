# making a matrix from scratch

testmat <- matrix(1:6, nrow = 3, ncol = 2,
                  dimnames = list(c("A", "B", "C"), c("d", "e")),
                  byrow = TRUE)

testmat

rownames(testmat)
colnames(testmat)
colnames(testmat) <- c("D", "E")
testmat

# index matrix as vector
testmat[1, 2]
testmat[3]
testmat[4]

# importing to a matrix
myfile <- "GG_SNPs.csv"
snp_mat <- as.matrix(read.csv(myfile, header = TRUE, row.names = 1))
snp_mat[1:5,1:5]

# using scan
snp_vect <- scan("GG_SNPs_nonames.csv", what = integer(),
                 sep = ",")
snp_mat2 <- matrix(snp_vect, nrow = nrow(snp_mat),
                   ncol = ncol(snp_mat))

# custom function to import using scan
source("scan_matrix.R")
snp_mat3 <- scan_matrix(myfile)

system.time(snp_mat <- as.matrix(read.csv(myfile, header = TRUE, row.names = 1)))
system.time(snp_mat3 <- scan_matrix(myfile))

# math with matrices
testmat + 2
testmat * 2
testmat + testmat[1,, drop = FALSE] # drop = FALSE prevents conversion to vector

t(testmat)

# matrix multiplication
snp_effects <- as.matrix(read.csv("SNP_effects.csv", row.names = 1,
                                  header = TRUE))
head(snp_effects)

# genomic estimated breeding values
GEBVs <- snp_mat %*% snp_effects
head(GEBVs)

# visualize a matrix
image(snp_mat[1:50, 1:50])

pdf("giant_heatmap.pdf", 30, 30)
heatmap(snp_mat[,])
dev.off()

# get distances
mydist <- dist(snp_mat)
str(mydist)
distmat <- as.matrix(mydist)
image(distmat)

# principal coordinates analysis
mypcoa <- cmdscale(mydist)
head(mypcoa)
plot(mypcoa[,1], mypcoa[,2])

# principal components analysis
princomp
prcomp # if more variables than observations

mypca <- prcomp(snp_mat)
str(mypca)
plot(mypca$x[,1], mypca$x[,2])

# indexing square matrix
distmat[upper.tri(distmat)]
upper.tri(matrix(nrow = 3, ncol = 3))

# cbind
testmat2 <- matrix(1:9, nrow = 3, ncol = 3,
              dimnames = list(c('A', 'B', 'C'),
                              c('g', 'h', 'i')))
testmat
testmat2
testmat3 <- cbind(testmat, testmat2)
testmat3

# make a 3D array
my3d <- array(1:24, dim = c(2, 3, 4),
              dimnames = list(c('a', 'b'),
                              c('c', 'd', 'e'),
                              c('f', 'g', 'h', 'i')))
my3d
my3d[1, 1,]
my3d[1,,]

my3dt <- aperm(my3d, c(3, 1, 2))
my3dt[1,1,]
my3dt

# row means, col means
allelefreq <- colMeans(snp_mat)/2 # allele frequencies in populations
allelefreq[1:10]

rowMeans(my3dt)
colMeans(my3dt)
rowMeans(my3dt, dims = c(2))

# apply
apply(testmat, MARGIN = 2, FUN = max, na.rm = TRUE)
testmat
apply(testmat, MARGIN = 1, FUN = max, na.rm = TRUE)

# function to get inbreeding statistic
inbreeding <- function(geno){
  # observed heterozygosity
  Ho <- mean(geno == 1)
  # allele frequency
  freq <- mean(geno)/2
  # expected heterozygosity
  He <- 2 * freq * (1 - freq)
  # inbreeding
  inbreed <- 1 - Ho/He
  return(inbreed)
}

inbreeding(snp_mat[,1])
myF <- apply(snp_mat, 2, inbreeding)
myF[1:20]
mean(myF)
sd(myF)

# apply with multiple dimensions
apply(testmat, c(1,2), max)
apply(my3d, c(1,2), max)
apply(my3d, 1, max)

# center a matrix using sweep
mymeans <- colMeans(snp_mat)
centered_snps <- sweep(snp_mat, 2, mymeans, FUN = "-")
centered_snps[1:10,1:5]
colMeans(centered_snps)[1:20]

# have a function return two things
snp_summary <- function(snp_mat){
  freq <- colMeans(snp_mat)/2
  inbreed <- inbreeding(snp_mat) # forgot to use apply
  
  return(list(frequecy = freq, 
              inbreeding = inbreed))
}

mysumm <- snp_summary(snp_mat)
mysumm$frequecy
mysumm$inbreeding

# sapply
mymatches <- gregexpr("M", rownames(snp_mat))
mymatches
nmatches <- sapply(mymatches, length)
nmatches

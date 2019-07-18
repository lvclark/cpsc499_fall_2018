# open a connection
mycon <- file("numbers.txt", open = "r")
mycon

mylines <- readLines(mycon, 5)
mylines
mylines2 <- readLines(mycon, 2) # picks up reading where I left off
mylines2

# close the connection
close(mycon)

# read the file in a loop
mycon <- file("numbers.txt", open = "r")
count <- 0
while(length(mylines <- readLines(mycon, 3)) > 0){
  count <- count + 1
  print(paste("read", count, "chunks"))
  print(mylines)
}
close(mycon)

# putting an assignment inside a function call
length(myvect <- 1:6)
myvect

myvect <- 1:6
length(myvect)

# hit stop sign to interrupt loop
while(TRUE){
  
}

# combine readLines and read.table on one file
mycon2 <- file("../Lecture_4/Plant.1.0 New Msa.txt",
               open = "r")
headers <- readLines(mycon2, 13)
headers
mytable <- read.table(mycon2, sep = "\t", header = TRUE)
close(mycon2)

# open a connection for writing
mycon3 <- file("out.txt", open = "w")
writeLines(c('hi', 'bye'), mycon3)
close(mycon3)

# loop through a FASTQ file and just write sequences
incon <- file("Illumina_seq_example.fastq", open = 'r')
outcon <- file("just_seq.txt", open = 'w')

while(length(mylines <- readLines(incon, 4)) > 0){
  writeLines(mylines[2], outcon)
}

close(incon)
close(outcon)

# loop through a FASTQ file and just write sequences -- faster version
incon <- file("Illumina_seq_example.fastq", open = 'r')
outcon <- file("just_seq.txt", open = 'w')

while(length(mylines <- readLines(incon, 4000)) > 0){
  nlines <- length(mylines)
  seqindex <- seq(2, nlines - 2, by = 4)
  writeLines(mylines[seqindex], outcon)
}

close(incon)
close(outcon)

# open zipped file
incon <- gzfile("Illumina_seq_example.fastq.gz", open = 'r')

readLines(incon, 8)
close(incon)

outcon <- gzfile("out.txt.gz", open = "w")
writeLines(c('1', '2', '3'), outcon)
close(outcon)

incon <- gzfile("out.txt.gz", open = "r")
readLines(incon)
close(incon)

# appending
outcon <- file("out.txt", open = "a")
writeLines("hello", outcon)
close(outcon)

outcon <- file("out.txt", open = "w") # this overwrites the file
writeLines("hello", outcon)
close(outcon)

# counting sequence matches in fastq
incon <- file("Illumina_seq_example.fastq", open = 'r')
count <- 0

while(length(mylines <- readLines(incon, 4000)) > 0){
  nlines <- length(mylines)
  seqindex <- seq(2, nlines - 2, by = 4)
  mymatches <- grep("^TTCAAGCATGCAG", mylines[seqindex])
  count <- count + length(mymatches)
}

close(incon)

# subsetting a data frame
mytable$sample_title
# handier if you are working in a loop:
mytable[["sample_title"]]
mytable[[2]]
mytable[1:5, "sample_title"]

# factors vs. strings
mytable[1:5, "sample_title"] == "Leaf sample from Miscanthus sacchariflorus clone UI10-00117"

# using names for indexing -- beware
myvect <- c(b = 5, c = 6, e = 7, a = 8, d = 9)
myvect

letters <- c('a', 'b', 'c', 'd', 'e')
myvect[letters]

myvect[as.factor(letters)]

mytable$blah

# tibble package for solving some data frame issues

# na.strings example
read.table(myfile, na.strings = c("", "NA", "#N/A"))

# mini exercise
read.table("lecture5_germplasm_example.txt", skip = 6,
           sep = ";", header = FALSE, na.strings = "nodata",
           colClasses = c("character", "character", "character",
                          "Date", "integer"))

germplasm <- read.table("lecture5_germplasm_example.txt", 
           sep = ";", header = FALSE, na.strings = "nodata",
           colClasses = c("character", "character", "character",
                          "Date", "integer"),
           comment.char = "%")

# export to CSV
write.csv(germplasm, file = "germplasm.csv", row.names = FALSE)

# temporary file
mytemp <- tempfile()
mytemp

save(germplasm, file = "germplasm.RData")
load("germplasm.RData")
cat("\u16A9")

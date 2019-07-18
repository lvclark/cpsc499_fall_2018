# single quotes or double quotes to make string
mystrings <- c("A", 'and')
class(mystrings)

# importing text in table (stringsAsFactors = FALSE)
germplasm_data <- read.table("Plant.1.0 New Msa.txt",
                             sep = "\t", comment.char = "#",
                             stringsAsFactors = FALSE,
                             header = TRUE)
str(germplasm_data)

germplasm_data$X.organism # character vector

# importing lines of text
germplasm_lines <- readLines("Plant.1.0 New Msa.txt")
head(germplasm_lines)

# comparison operators
germplasm_data$X.organism == "Miscanthus sinensis"

# using paste - elementwise
paste(germplasm_data$X.sample_name,
      ", species: ",
      germplasm_data$X.organism, sep = "")

# using paste - whole vector to one string
paste(germplasm_data$X.sample_name[1:10],
      collapse = " ")

# other common seperators
# "\t" tab
# "\n" newline

newstring <- paste(germplasm_data$X.sample_name[1:10],
      collapse = "\n")
cat(newstring) # print line breaks as line breaks

# nchar
nchar(germplasm_data$X.sample_name)

# substring
species_name <- substring(germplasm_data$X.organism,
          12, nchar(germplasm_data$X.organism))
species_name

# strsplit
species_split <- strsplit(germplasm_data$X.organism, 
                          split = " ")
species_split[[50]]

strsplit("hi bye", split = " ")[[1]]

# split completely into characters
strsplit("hi bye", split = "")[[1]]

# format numbers
mynum <- c(2000, 1.80, 1.4568293)
formatC(mynum, digits = 3, format = "f") # digits after decimal place
formatC(mynum, digits = 3, format = "fg", flag = "#") # significant digits
mynum2 <- 1:10
formatC(mynum2, flag = "0", width = 2) # pad with zeros on left

prettyNum(mynum, big.mark = ",") # comma for thousands, millions
prettyNum(mynum, big.mark = " ") # space instead of comma

# add column of sample names to table
germplasm_data$samplenum <- 
  paste("Sample", formatC(1:558, flag = 0, width = 3), sep = "")

# match for joins
height_data <- data.frame(sample = c("UI11-00006", "KMS356", "KMS350"),
                          height = c(2, 3, 1.5),
                          stringsAsFactors = FALSE)
match_rows <- match(height_data$sample, germplasm_data$X.sample_name) # na if not found

germplasm_data[match_rows, 1:3]
height_data$sample_title <- germplasm_data$sample_title[match_rows]

germplasm_data[c(3, NA), ] # what happens when we index by missing data
any(is.na(match_rows)) # check for if there is missing data

# naming vectors
myvect <- c(0, 4, 6)
names(myvect) <- c('a', 'b', 'c')
myvect
myvect[2] == 4
myvect[2] == 'b'
names(myvect)[2] == 'b'
myvect['b']
myvect[c('b', 'a')]

mypch <- c(0, 1, 2, 3)
names(mypch) <- c("Miscanthus sinensis", 
                  "Miscanthus sacchariflorus",
                  "Miscanthus x giganteus",
                  "Miscanthus lutarioriparius")
unique(germplasm_data$X.organism)
mypch
pch_to_plot <- mypch[germplasm_data$X.organism]
str(pch_to_plot)

plot(1:50, 1:50, pch = pch_to_plot[1:50])

c(`Miscanthus sinensis` = 0)
c(a = 4)

# adding row names to a table
rownames(germplasm_data) <- 
  germplasm_data$X.sample_name
mysamples <- paste("JY", c("012", "001", "028"),
                   sep = "")
germplasm_data[mysamples, 1:3]

germplasm_data2 <- read.table("Plant.1.0 New Msa.txt",
                             sep = "\t", comment.char = "#",
                             stringsAsFactors = FALSE,
                             header = TRUE,
                             row.names = 1)

## pattern matching
fruits <- c("apple", "orange", "banana")
grep("a", fruits)
grep("an", fruits)
grepl("an", fruits)

gsub("an", "ern", fruits) # find and replace all
sub("an", "ern", fruits) # find and replace first match

regexpr("an", fruits)
gregexpr("an", fruits)

# regular expressions
grep("^Chr", c("Chr01", "blahChr")) # beginning of string
grep("Chr", c("Chr01", "blahChr"))

grep("a$", fruits) # end of string
fruits

grep("^a.*e$", fruits) # begins with a, ends with e

grep("(an)+", fruits) # one or more "an"
grep("(an){2}", fruits) # exactly two "an"
grep("anan", fruits)

grep("an[ag]", fruits) # "an" followed by "a" or "g"
grep("an[^g]", fruits) # "an" followed by anything but "g"
gregexpr("(an|or)", fruits) # "an" or "or"

banana_match <- gregexpr("(an)+", fruits)[[3]]
banana_match == 2
attr(banana_match, "match.length") # extract match length

grep("^JM2014-[SK]-[0-9]{1,2}$", germplasm_data$X.sample_name,
     value = TRUE)

cat("loc1\\.5")

grep("^JM2014-[SK]-[[:digit:]]{1,2}$", germplasm_data$X.sample_name,
     value = TRUE)
"^JM2014-[SK]-[[:digit:][:punct:]]{1,2}$"

grep("^JY[[:digit:]]{3}$", germplasm_data$X.sample_name,
     value = TRUE)

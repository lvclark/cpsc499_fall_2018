# from Lab 5

myfile <- "Msinensis_chr01genes.vcf"

incon <- file(myfile, open = 'r')
outcon <- file("Msinensis_chr01genes_filtered.vcf", open = 'w')

total_lines_read <- 0

while(length(mylines <- readLines(incon, 500))){
  # determine which (if any) lines are headers
  headers <- substr(mylines, 1, 1) == "#"
  # determine which lines have 100 or fewer missing data points
  missing_matches <- gregexpr("\t\\.:", mylines)
  
#  missing_counts <- sapply(missing_matches, length)
#  pass_filter <- missing_counts <= 50
  pass_filter <- sapply(missing_matches, 
                        function(x) length(x) <= 50)
  
#  pass_filter <- logical(length(mylines))
#  for(i in 1:length(mylines)){
#    pass_filter[i] <- length(missing_matches[[i]]) <= 50
#  }
  
  # output lines
  outlines <- mylines[headers | pass_filter]
  writeLines(outlines, outcon)
  
  # print message
  total_lines_read <- total_lines_read + length(mylines)
  message(paste(total_lines_read, "lines read."))
}
close(incon)
close(outcon)

mycon <- file("Msinensis_chr01genes_filtered.vcf", open = "r")
headers <- readLines(mycon, 12)

geno_tab <- read.table(mycon, header = TRUE, sep = "\t", 
                       stringsAsFactors = FALSE, comment.char = "")
close(mycon)

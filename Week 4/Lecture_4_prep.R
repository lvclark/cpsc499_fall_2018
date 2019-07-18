mydata <- read.table("Plant.1.0 New Msa.txt", sep = "\t", 
                     stringsAsFactors = FALSE, comment.char = "#",
                     header = TRUE)
head(mydata)
which(mydata$X.organism == "Miscanthus sinensis")
mydata$X.sample_name

## working with attributes
fruits <- c("apple", "orange", "banana")
mymatches <- gregexpr("a", fruits)

attr(mymatches[[1]], "match.length")
attr(mymatches[[1]], "index.type")

myvect <- 1:10
attr(myvect, "what.is.it") <- "some numbers"
myvect
attr(myvect, "mat") <- matrix(1:9, nrow = 3, ncol = 3)
myvect

# convert miles to km
miles_to_km <- function(distance, nautical = FALSE){
  if(!is.numeric(distance)){
    stop("Something that is not a number was given to distance")
  }
  
  if(nautical){
    out <- distance * 1.85
    attr(out, "original.units") <- "nautical miles"
  } else {
    out <- distance * 1.61
    attr(out, "original.units") <- "miles"
  }
  attr(out, "units") <- "km"
  # out <- distance * conv # don't do this
  return(out)
}

miles_to_km(50)

## looking at S4 classes
install.packages("BiocManager")
BiocManager::install("Biostrings")

library(Biostrings)

myDNA <- DNAString("AAGCATATTAGGG")
myDNA
length(myDNA)
as.character(myDNA)

View(myDNA)

myDNA@length
myDNA@elementMetadata

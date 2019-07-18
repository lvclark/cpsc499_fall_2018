## to run with Rscript, and demonstrate using arguments
## e.g. Rscript printargs.R -e --hello 

myargs <- commandArgs(trailingOnly = TRUE) # get arguments passed from bash/Rscript

cat(myargs, sep = "\n")

if("--hello" %in% myargs){
  cat("Why hello!\n")
}

## Script to read part of a file and write it to STDOUT

mylines <- readLines("Osativa_323_v7.0.defline.txt",
                     n = 100) # read some lines

cat(mylines, sep = "\n") # print out the lines

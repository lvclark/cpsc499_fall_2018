# function to take a csv with row and column names and turn it
# into a matrix more quickly than as.matrix(read.csv())
scan_matrix <- function(myfile){
  # open a connection
  mycon <- file(myfile, open = "r")
  # read the headers
  headers <- scan(mycon, what = character(), nlines = 1, sep = ",")
  # get rid of blank header for row names
  headers <- headers[-1]
  # number of columns
  nCol <- length(headers)
  # set up 'what' for scan
  mywhat <- list(character(), integer())
  mywhat <- mywhat[c(1, rep(2, nCol))]
  # run scan
  scanout <- scan(mycon, what = mywhat, sep = ",")
  close(mycon)
  # figure out number of rows
  nRow <- length(scanout[[1]])
  # create a vector to make a matrix
  myvect <- unlist(scanout[-1])
  # make the matrix
  outmat <- matrix(myvect, nrow = nRow, ncol = nCol,
                   dimnames = list(scanout[[1]],
                                   headers))
  return(outmat)
}
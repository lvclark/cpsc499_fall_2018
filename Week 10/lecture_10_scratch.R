#install.packages(c("htmlwidgets", "profvis",
#                   "microbenchmark", "Rcpp"))

library(microbenchmark)

x <- runif(100)

y1 <- x + 3
y2 <- sapply(x, function(a) a + 3)
identical(y1, y2)

microbenchmark(x + 3, 
               sapply(x, function(a) a + 3))

# most inefficient way possible
center1 <- function(x){
  out <- c()
  for(i in 1:length(x)){
    out[i] <- x[i] - mean(x)
  }
  
  return(out)
}

center1(y1)

# don't calculate mean repeatedly
center2 <- function(x){
  out <- c()
  mymean <- mean(x)
  for(i in 1:length(x)){
    out[i] <- x[i] - mymean
  }
  
  return(out)
}

# preallocation
center3 <- function(x){
  out <- numeric(length(x))
  mymean <- mean(x)
  for(i in 1:length(x)){
    out[i] <- x[i] - mymean
  }
  
  return(out)
}

# fully vectorized version
center4 <- function(x){
  mymean <- mean(x)
  out <- x - mymean
  
  return(out)
}

identical(center1(y1),
          center2(y1),
          center3(y1),
          center4(y1))

microbenchmark(center1(y1),
          center2(y1),
          center3(y1),
          center4(y1))

# mini exercise
rando <- runif(400)
for(i in 1:length(rando)){
  rando[i] <- rando[i] * 3 ^ -6
}

rando <- rando * 3 ^ -6 # the fastest way

mynum <- 3 ^ -6 # taking math out of loop
for(i in 1:length(rando)){
  rando[i] <- rando[i] * mynum
}

# garbage collection

myvect <- c()

for(i in 1:10000){
  myvect <- c(myvect, runif(100))
}

myvect <- numeric(100 * 10000)

for(i in 1:10000){
  myvect[((i-1)*100 + 1):(i*100)] <- runif(100)
}

# mini exercise
microbenchmark({
mat <- matrix(runif(500),
              nrow = 500, ncol = 1)
for(i in 1:100){
  mat <- cbind(mat,
               matrix(runif(500),
                      nrow = 500, ncol = 1))
}
}, # group the whole script with curly braces
{
n <- 100
mat <- matrix(c(runif(500),rep(NA, 500*n)),
              nrow = 500, ncol = n + 1)
for(i in 1:n){
  mat[,i+1] <- runif(500)
}
}) # end of microbenchmark call

# fastmatch
library(fastmatch)
mynames <- paste("Sample", 1:500)

microbenchmark(
match("Sample 30", mynames),
fmatch("Sample 30", mynames)
)

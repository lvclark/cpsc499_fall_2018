library(compiler)
library(microbenchmark)
library(Rcpp)
enableJIT(0) # turn off compilation for this example

fibonacci <- function(n){
  out <- integer(n)
  out[1:2] <- 1L
  for(i in 3:n){
    out[i] <- out[i - 1] + out[i - 2]
  }
  return(out)
}

fibonacci(10)

# compile the function
fibonacciC <- cmpfun(fibonacci)

fibonacciC(10)

microbenchmark(fibonacci(20), fibonacciC(20))

enableJIT(3) # turn compilation back on

# C++ functions
sourceCpp("fibonacci.cpp")
fibonacciCpp(10)
fibonacci(10)

microbenchmark(fibonacci(10),
               fibonacciC(10),
               fibonacciCpp(10))

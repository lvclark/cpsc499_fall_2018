#include <Rcpp.h>
using namespace Rcpp;

// Function to get FibonacciSequence

// [[Rcpp::export]]
IntegerVector fibonacciCpp(int n) {
  IntegerVector out(n);
  out[0] = 1;
  out[1] = 1;
  
  for(int i = 2; i < n; i++){
    out[i] = out[i - 1] + out[i - 2];
  }
  
  return out;
}



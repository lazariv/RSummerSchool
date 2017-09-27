#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
bool allC(LogicalVector x) {
  int n = x.size();
  //bool result = 1;
  for (int i = 0; i<n; i++) {
    if (!x(i)) return(0);  
  }
  return(1);
}

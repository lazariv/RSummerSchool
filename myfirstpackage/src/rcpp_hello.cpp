#include <Rcpp.h>
using namespace Rcpp;

//' Rcpp list
//'
//' using Rcpp to create a list
//'
//' @return list
//' @examples
//' rcpp_hello()
//' @export
// [[Rcpp::export]]
List rcpp_hello() {
  CharacterVector x = CharacterVector::create("foo", "bar");
  NumericVector y   = NumericVector::create(0.0, 1.0);
  List z            = List::create(x, y);
  return z;
}

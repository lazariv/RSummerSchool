## ----eval=FALSE, echo=FALSE----------------------------------------------
## ls()

## ----eval=TRUE, echo=TRUE------------------------------------------------
  Rcpp::evalCpp("2+2")

## ----eval=TRUE, echo=TRUE------------------------------------------------
  library(Rcpp)

## ----eval=TRUE, echo=TRUE------------------------------------------------
  evalCpp("sqrt(2)")

## ----eval=TRUE, echo=TRUE------------------------------------------------
  x <- 2
  evalCpp(paste0("sqrt(",x,")"))

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('int add2(int x, int y) {
   int sum = x + y;
   return sum;
 }')

## ----eval=TRUE, echo=TRUE------------------------------------------------
  add2(2,3)
  add2(2,3.2323) # will be converted to integer

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('int add2(int x, int y) {
   int sum = x + y;
   return sum;
 }')

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('double sumC(NumericVector x) {
  int n = x.size();
  double total = 0;
  for(int i = 0; i < n; ++i) {
    total += x[i];
  }
  return total;
}')
sumC(rnorm(10))

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('double sumC0(NumericVector x) {
// this is a comment
  int n = x.size();
  double total = 0;
  for(int i = 0; i < n; ++i) {
    if(x[i]>0){ // if looks like in R
      total += x[i];
    }
  }
  return total;
}')
sumC0(rnorm(10))

## ----eval=TRUE, echo=TRUE------------------------------------------------
sumR <- function(x){
	result <- 0
	for(i in 1:length(x)){
		result <- result + x
	}
	return(x)
}
x <- runif(1e3)
microbenchmark::microbenchmark(
  sum(x),
  sumC(x),
  sumR(x)
)

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('NumericVector cumSumC(NumericVector x) {
  int n = x.size();
  for(int i = 1; i < n; ++i) {
    x[i] += x[i-1];
  }
  return x;
}')
cumSumC(1:10)

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('NumericMatrix stupidMatrix(NumericMatrix x) {
  int nrow = x.nrow();
  int ncol= x.ncol();
  for(int i = 0; i < nrow; ++i) {
    for(int j = 0; j < ncol; ++j) {
      if(x(i,j)>5){
        x(i,j)-=5;
      }
    }
  }
  return x;
}')
stupidMatrix(matrix(1:9,nrow=3))

## ----eval=TRUE, echo=TRUE------------------------------------------------
  sourceCpp("sumC.cpp")
  sumC(1:10)

## ----eval=TRUE, echo=TRUE------------------------------------------------
  sourceCpp("meanC.cpp")
  meanC(1:10)

## ----eval=TRUE, echo=TRUE------------------------------------------------
  sourceCpp("allC.cpp")
  allC(c(TRUE,TRUE,TRUE))
  allC(c(TRUE,TRUE,FALSE))

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('double sugarSum(NumericVector x) {
// function sum on a NumericVector object from Rcpp  
  double total = sum(x);
  return total;
}')
sugarSum(rnorm(10))

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('NumericVector sugarCos(NumericVector x) {
// function cos on a NumericVector object from Rcpp  
  NumericVector out = cos(x);
  return out;
}')
sugarCos(rnorm(10))

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('NumericVector sugarPlus(NumericVector x, NumericVector y) {
// elementwise + 
  NumericVector out = x+y;
  return out;
}')
sugarPlus(1:10,10:1)

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('List miMa(NumericVector x) {
  double mi=min(x);
  double ma=max(x);
  return List::create(
    Named( "min" ) = mi,
    Named( "max" ) = ma
  );
}')
miMa(1:10)

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('SEXP listOrVector(NumericVector x) {
  if(x[0]==1){
    return x;
  }else{
    return List::create( Named( "vec" ) =x );
  }
}')
listOrVector(1:10)
listOrVector(2:3)

## ----eval=TRUE, echo=TRUE------------------------------------------------
cppFunction('
List scalar_missings() {
  int int_s = NA_INTEGER;
  String chr_s = NA_STRING;
  bool lgl_s = NA_LOGICAL;
  double num_s = NA_REAL;
  bool na_ind = is_true( any( is_na( NumericVector::create(int_s) ) ) );
  return List::create(int_s, chr_s, lgl_s, num_s, na_ind);
}')
scalar_missings()

## ----eval=FALSE, echo=TRUE-----------------------------------------------
## Rcpp.package.skeleton("NewPackage", example_code = FALSE,
##                       cpp_files = c("sumC.cpp","meanC.cpp","allC.cpp"))


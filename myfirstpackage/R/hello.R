# Hello, world!
#

#' Print Hello World using R
#'
#' @return Character staring containing Hello World
#' @export
#'
#' @examples
#' hello()
#'
#' @importFrom Rcpp evalCpp
#' @useDynLib myfirstpackage




hello <- function() {
  print("Hello, world!")
}

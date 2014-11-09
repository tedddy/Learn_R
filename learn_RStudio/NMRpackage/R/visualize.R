##' Make a times series plot using ggplot2
##'
##' @param x a possibly multidimensional zoo object
##' @return a ggplot object to be printed
##' @export
nmrTsPlot <- function(x) {
  if(all(class(x) != "zoo")) stop("x must be a zoo object")
  x.df <- data.frame(dates=index(x), coredata(x))
  x.df <- melt(x.df, id="dates", variable="value")
  x.df <- melt(x.df, id="dates", variable="value")
  x.df <- melt(x.df, id="dates", variable="value")
  names(x.df)[2] = "ID"
  ggplot(x.df, aes(x=dates, y=value, group=ID, colour=ID)) + 
    geom_line() + opts(legend.position = "none")
}

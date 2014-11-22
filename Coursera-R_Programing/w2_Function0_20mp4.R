# add two numbers

add2 <- function(x,y) {
  x + y
}

z <- add2(3,7)

# show numbers above a level

above10 <- function(x) {
  use <- x > 10
  x[use]
}
x <- 1:20
above10(x)

above <- function(x, n=10) {
  use <- x > n
  x[use]
}
x <- 1:20
above(x, 5)

# take a matrix or a dataframe and calculate the mean of each column. Function name: columnmean

columnmean <- function (y, removeNA = TRUE) {
  nc <- ncol(y) ##
  means <- numeric(nc) ##
  for (i in 1:nc) {
    means[i] = mean(y[, i], na.rm = removeNA)
  }
  means
}

columnmean(airquality)

columnmean(airquality, removeNA = FALSE)

formals(columnmean) ## returns a list of all the formal arguments of a function.
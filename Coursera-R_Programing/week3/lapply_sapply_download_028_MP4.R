lapply #lapply returns a list of the same length as X, each element of which is the result of applying FUN to the corresponding element of X.

x <- list(a=1:5,b=rnorm(10))
lapply(x,mean)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

x <- 1:4
lapply(x, runif)

x <- 1:4
lapply(x, runif, min = 0, max = 10)

x <- list(a=matrix(1:4,2,2), b=matrix(1:6,3,2))
x
lapply(x, function(elt) elt[,1]) #lapply and friends make heavy use of anonymous functions. Here is an anonymous function for extracting the first column of each matrix.

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)
sapply(x, mean)

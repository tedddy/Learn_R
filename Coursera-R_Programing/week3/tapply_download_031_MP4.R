x <- c(rnorm(10), runif(10), rnorm(10, 1))
x
f <- gl(3, 10) #Generate factors by specifying the pattern of their levels.
f
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
temp <- tapply(x, f, mean, simplify = FALSE)
tapply(x, f, range)

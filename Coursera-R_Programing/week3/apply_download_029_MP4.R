str(apply) #function (X, MARGIN, FUN, ...)

# X is an array
# MARGIN is an integer vector indicating which margins should be “retained”.
# FUN is a function to be applied
# ... is for other arguments to be passed to FUN

x <- matrix(rnorm(200), 20, 10)
x

apply(x,2,mean) # Column should be “retained”.
colMeans(x)

apply(x,1,mean)
rowMeans(x)

rowSums = apply(x, 1, sum)
rowMeans = apply(x, 1, mean)
colSums = apply(x, 2, sum)
colMeans = apply(x, 2, mean)

temp <- apply(x, 1, quantile, probs = c(0.25, 0.75)) 
#The generic function quantile produces sample quantiles corresponding to the given probabilities. The smallest observation corresponds to a probability of 0 and the largest to a probability of 1.

a <- array(rnorm(2 * 2 * 10), c(2, 2, 10)) # 3 dimentional array
a
apply(a, c(1, 2), mean)
rowMeans(a,dims=2) # rowMeans is much quicker than apply(x, 1, mean), because it is optimized for calculating means.

# Learn function quantile: quantile(x <- rnorm(1001),probs = c(0.25, 0.75))


Examples

## Compute row and column sums for a matrix:
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))

dimnames(x)[[1]] <- letters[1:8] 
# NULL or a list of length 2 giving the row and column names respectively. An empty list is treated as NULL, and a list of length one as row names. The list can be named, and the list names will be used as names for the dimensions. 

apply(x, 2, mean, trim = .2)

col.sums <- apply(x, 2, sum)
row.sums <- apply(x, 1, sum)
rbind(cbind(x, Rtot = row.sums), Ctot = c(col.sums, sum(col.sums)))
# total row and total col

t <- stopifnot( apply(x, 2, is.vector)) # ?

## Sort the columns of a matrix
apply(x, 2, sort)

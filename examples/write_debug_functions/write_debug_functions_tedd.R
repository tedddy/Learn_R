

square.it <- function(x) { 
    square <- x * x 
    return(square)
}

# the following does not use return, but it works.
square.it.tedd <- function(x) { 
    square <- x * x 
    Lst <- data.frame(square)
}

square.it.tedd(5)

temp.tedd <- square.it.tedd(5)


square.it(5)

square.it(c(1,4,2))

matrix1 <- cbind(c(3,10), c(4,5))

square.it(matrix1)

my.fun<-function(X.matrix, y.vec, z.scalar) {
    # use my previous function square.it() to square the scalar and save result
    sq.scalar <- square.it(z.scalar)
    
    # multiply the matrix by the vector using %*% operator
    mult <- X.matrix %*% y.vec
    
    # multiply the two resulting objects together to get a final object 
    final <- mult * sq.scalar
    
    # return the result
    return(final)
}

# save a matrix and a vector object 
my.mat <- cbind(c(1, 3, 4), c(5, 4, 3)) 
my.vec <- c(4, 3)

# pass my.mat and my.vec into the my.fun function 
my.fun(X.matrix = my.mat, y.vec = my.vec, z.scalar = 9)

another.fun <- function(sq.matrix, vector) {
    
    # transpose matrix and square the vector 
    step1 <- t(sq.matrix) 
    step2 <- vector * vector 
    # save both results in a list and return 
    final <- list(step1, step2) 
    return(final) 
}

# call the function and save result in object called outcome 
outcome <- another.fun(sq.matrix = cbind(c(1, 2), c(3, 4)), vector = c(2, 3))



























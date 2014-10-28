# intro-2_1

assign("x", c(10.4, 5.6, 3.1, 6.4, 21.7))

x<- c(10.4, 5.6, 3.1, 6.4, 21.7)

c(10.4, 5.6, 3.1, 6.4, 21.7) -> x

y <- c(x,0,x)

# intro-2_2

v <- 2*x+y+1

range(x)

sum(x)

sum(x)/length(x)

mean(x)

var(x)

x-mean(x)

(x-mean(x))^2

sum((x-mean(x))^2)

sum((x-mean(x))^2)/(length(x)-1)

sort(x)

order(x)

sort.list(x)

sqrt(-17)

sqrt(-17+0i)

# intro-2_3

1:30

2*1:30

2*1:15

n <- 10
1:n-1
1:(n-1)

30:1

seq(0, 1, length.out = 11)

# seq() Examples
seq(0, 1, length.out = 11)
seq(stats::rnorm(20)) # effectively 'along'
seq(1, 9, by = 2)     # matches 'end'
seq(1, 9, by = pi)    # stays below 'end'
seq(1, 6, by = 3)
seq(1.575, 5.125, by = 0.05)
seq(17) # same as 1:17, or even better seq_len(17)

s5 <- rep(x, times=5)

s6 <- rep(x, each=5)

# intro-2_4

temp <- x>13

# logical operators:
# <, <=, >, >=, == for exact equality
# != for inequality
# & for "and", | for "or"

# Logical vectors may be used in ordinary arithmetic, in which case they are coerced into
# numeric vectors, FALSE becoming 0 and TRUE becoming 1.

z <- c(1:3,NA)

ind <- is.na(z)

x == NA

Inf - Inf

# intro-2_6

# Character strings are entered using either matching double (") or single (') quotes, 
# but are printed using double quotes (or sometimes without quote). They use C-style 
# escape sequences. \\, \n, \t, \b. 

?Quotes
?paste()

paste(1:12) # same as as.character(1:12)

paste("A", 1:6, sep = "")

paste("Today is", date())

temp2_6 <- paste("A", 1:6, sep = "")

temp2_6[1]

labs <- paste(c("X","Y"),1:10,sep="")

# 2.7 index vectors

y <- x[!is.na(x)]

z <- (x+1)[(!is.na(x)) & x>0]

temp7 <- x[1:10]

z <- (temp7+1)[(!is.na(temp7)) & x>0]

x[1:10]

c("X","y")[rep(c(1,2,2,1), times=4)]

temp7_2 <- c("X","y")[rep(c(1,2,2,1), times=4)]

y <- x[-(1:5)]

fruit <- c(5, 10, 1, 20)

names(fruit) <- c("orange", "banana", "apple", "peach")

lunch <- fruit[c("apple","orange")]

x[is.na(x)] <- 0

y[y<0] <- -y[y<0]

y <- abs(y)

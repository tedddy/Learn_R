# Subsetting

x <- c("a","b","c","c","d","a")
x[1]
x[2]
x[1:4] # find the first four elements.
x[x>"a"] # find elements which are greater than "a".
u <- x>"a" # a logic vector to show whether the elements is greater than "a".

u

x[u] # subset a vector with a logic vector

# Subsetting a Matrix

  # subsetted in the usual way with (i,j)
x <- matrix(1:6,2,3) # pr(practice and remember)
x[1,2]
x[2,1]
x[1,3]

  # indices can also be missing

x[1,]
x[,2]

# Subsetting a Matrix 2

x <- matrix(1:6,2,3)
x
tedd <- x[1,2]
class(tedd)
x[1,2,drop=FALSE] # false is not correct
class(x)

# Subsetting a Matrix 2

x <- matrix(1:6,2,3)
x[1,]
x[1,,drop=FALSE]

# Subsetting Lists

x <- list(foo=1:4,bar=0.6)
tedd1 <- x[1]
x[[1]]
tedd2 <- x[[1]]

x$bar
x[["bar"]]
tedd3 <- x[["bar"]]
x["bar"]
tedd4 <-x["bar"] 

# Subsetting Lists 2

x <- list(foo=1:4,bar=0.6, baz="hello")
x[c(1,3)]

# Subsetting Lists 3 
  # The [[]] operator can be use with computed indices; $ can only be used wieth literal names.

x <- list(foo=1:4,bar=0.6, baz="hello")
name <- "foo"
x[[name]] ## computed index for 'foo'
x$name ## 'name' does not exist
x$foo

# subsetting Nested Elements of a List
  # the [[]] can take an integer sequence.

x <- list(a=list(10,12,14),b=c(3.14,2.81))
x[[c(1,3)]]
x[[1]][[3]]
x[[c(2,1)]]

# Partial Matching
  # Partial matching of names is allowed with [[]] and $

x <- list(aardvark=1:5)
x$a
x[["a"]]
x[["a",exact=FALSE]]
#x[[a]] does not work.

# Removing NA Values
  # A commont task is to remove missing values(NAS)

x <- c(1,2,NA,4,NA,5)
bad <- is.na(x)
x[!bad]

# Removing NA Values 2
  # What if there are multiple things and you want to take teh subset with no missing values?

x <- c(1,2,NA,4,NA,5)
y <- c("a","b",NA,"d",NA,"f")
good <- complete.cases(x,y)
good
x[good]
y[good]

# Removing NA Values 3

airquality[1:6,]
good <- complete.cases(airquality)
good
airquality
airquality[good,]
airquality[good,][1:6,]



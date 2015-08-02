vector()

1

1L

1/0

0/0

1/Inf

x <- 1

print(x)

x

msg <- "hello"

x <- 1:20 #not [1:20]

x <- c(0.5,0.6)

x <- c(TRUE,TRUE)

x <- c(T,F)

x <- c("a","b","c")

x <- 9:29

x <- c(1+0i,2+4i)

x <- vector("numeric",length=10)

y <- c(1.7,"a")

y <- c(TRUE,2)

y <- c("a",TRUE)

x <- 0:6

class(x) # 

as.numeric(x)

as.logical(x) # not logic

as.character(x)

x <- c("a","b","c")

as.numeric(x)

as.logical(x)

as.complex(x) # not the same as that in the slide.

m <- matrix(nrow = 2, ncol = 3)

m

dim(m)

attributes(m)

m <- matrix(1:6, nrow=2, ncol=3)

m

m <- 1:10

dim(m) <- c(2,5) # create a matrix from a vector

m

# cbind-ing and rbind-ing

x <- 1:3

y <- 10:12

cbind(x,y)

rbind(x,y)

# Lists

x <- list(1,"a",TRUE,1+4i)

x

# factors

x <- factor(c("yes","yes","no","yes","no"))

x

# ?unclass()

table(x) #

unclass(x) #?

x <- factor(c("yes","yes","no","yes","no"), levels = c("yes","no"))

x

# missing values
# A NaN value ia also NA but the converse is not true.

x <- c(1,2,NA,10,3)

is.na(x)

is.nan(x)

x <- c(1,2,NaN,NA,4)

is.na(x)

is.nan(x) # not NaN

# Data frames: 1. special type of list; 2. Each element of the list can be thought of as a column and the length of each element of the list is the nubmer of rows; 3. Unlike matrices, data frames can store different classes of objects in each column; 4. Data frames also have a special attribute called row.names; 5. Data frames are usually created by callign read.table() or read.csv(); 6. Can be converted to a matrix by calling data.matrix().

x <- data.frame(foo = 1:4, bar=c(T,T,F,F)) # ecch row is an observation.

nrow(x)

ncol(x)

# Names: R objects can also have names, which is very useful for writing readable code and self-describing objects.

x <- 1:3

names(x)

names(x) <- c("foo", "bar", "norf")

x

x <- list (a=1,b=2,c=3)

x

m <- matrix(1:4,nrow=2,ncol=2)

View(m)

dimnames(m) <- list(c("a","b"),c("c","d"))

m



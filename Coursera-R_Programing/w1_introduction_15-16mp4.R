y <- data.frame(a=1, b="a")

dput(y)
dput(y,file="y.R")
new.y <- dget("y.R")
new.y
# read.table

data <- read.table("foo.txt")

## from root of NMRpackage. The txt file from trimmed rtf file
f <- "inst/sampledata/degas.txt"

readNMRData <- function (f) {
  x <- read.csv(f, sep=";", header=FALSE, comment.char="\\")
  x <- x[, - 5]
  names(x) <- c("RFID", "date", "time", "gate")
  x$datetime  <- paste(x$date, x$time)
  x$time <- as.POSIXct(x$datetime, format="%m/%d/%Y %H:%M:%S")
}

l <- split(x, x$RFID)

l1 <- lapply(l, function(x) {
  trimmed <- x[duplicated(x),]
  trimmed$time <- trimmed$time + (1:nrow(trimmed))/(1000 * nrow(trimmed))
  trimmed
})



l2 <- sapply(l1, function(x) {
  nr <- nrow(x)
  x$bubble <- numeric(nr)
  x$bubble[1] <- x$gate[1]              ## start somewhere
  for(i in 2:nr) {
    x$bubble[i] <- x$gate[i] +
      as.numeric(x$gate[i] >= x$bubble[i - 1])
  }
  x
}, simplify=FALSE)

require(zoo)
l3  <- sapply(l2, function(x) zoo(x$bubble, x$time), simplify=FALSE)
x  <- na.locf(do.call(merge, l3), na.rm=FALSE)

plot(x[, 1:5], plot.type="single", col=1:5)

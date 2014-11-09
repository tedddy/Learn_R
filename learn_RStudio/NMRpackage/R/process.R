##' Function to read in nmr data from txt csv-like file
##' 
##' @param x file containing data
##' @return data frame with time component being of POSIXct class
##' @seealso \code{\link{createZooObjects}}, \code{\link{createStateMatrix}}
##' @export
##' @examples
##' ## f <- "~/NMRpackage/inst/sampledata/degas.txt"
##' f <- system.file("sampledata","degas.txt", package="NMRpackage")
##' a <- readNMRData(f)
##' b <- createZooObjects(a)
##' m <-  createStateMatrix(b)
##' nmrTsPlot(m[, 1:4])
readNMRData <- function (f) {
  x <- read.table(f, sep=";", comment.char="\\")
  x[5] <- NULL
  names(x) <- c("ID","date", "time","gate")
  x$datetime <- paste(x$date, x$time)
  x$time <- as.POSIXct(x$datetime, format="%m/%d/%Y %H:%M:%S")
  x
}

##' Create zoo objects per mole rat from data frame
##'
##' @param matrix produced by readNMRData
##' @param list of zoo objects, one for reach ID in data set
##' @export  
createZooObjects <- function (x) {
  
  l <- split(x, x$ID)
  
  lapply(l, function(i) {
      trimmed <- i[duplicated(i),]
      ## adjust times now 
      trimmed$time <- trimmed$time + (1:nrow(trimmed))/(1000*nrow(trimmed))
  
      ## now map gate to bubble. The gate are a crossing
      trimmed$bubble <- numeric(nrow(trimmed))
      trimmed$bubble[1] <- trimmed$gate[1]
      ## assume bubbles 1,2,3,4 gates 1,2,3 in gate, bubble, gate, bubble, gate
      for(row in 2:nrow(trimmed)) {
        trimmed$bubble[row] <- trimmed$gate[row] + 
          as.numeric(trimmed$gate[row] >= trimmed$bubble[row-1])
      }
      
      ## convert to zoo
      z <- zoo(trimmed$bubble, trimmed$time)
      z
  })

}

##' Create state matrix (one row per time holding bubble for each mole rat
##' 
##' @param x list of zoo objects from createZooObjects
##' @return a multivariate zoo object
##' @export
createStateMatrix <- function (x) {
  m <- do.call(merge, x)
  m <- na.locf(m, na.rm=FALSE)
  m
}
 
  
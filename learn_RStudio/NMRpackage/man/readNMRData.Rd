\name{readNMRData}
\alias{readNMRData}
\title{Function to read in nmr data from txt csv-like file...}
\usage{readNMRData(f)
}
\description{Function to read in nmr data from txt csv-like file}
\value{data frame with time component being of POSIXct class}
\seealso{\code{\link{createZooObjects}}, \code{\link{createStateMatrix}}}
\arguments{\item{x}{file containing data}
}
\examples{f <- "~/NMR/CopyOfDegas8_13_2010_12_1AM.txt"
#f <- system.file("data/degas.txt", package="NMR")
a <- readNMRData(f)
b <- createZooObjects(a)
m <-  createStateMatrix(b)
nmrTsPlot(m[, 1:4])}


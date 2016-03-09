library(quantmod)

# args(getSymbols)

getSymbols("510050.SS") ## Correct way

SSEC_2 <- getSymbols("000016.ss", auto.assign=FALSE)
SSEC_3 <- getSymbols("000001.ss")

sh50 <- getSymbols("000001.ss")

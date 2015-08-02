require(quantmod)

start <- Sys.Date()-30
end <- Sys.Date()-2

code <- "601318"

tckr_601318= paste(code,"SS",sep=".")

data_601318 <- getSymbols(tckr_601318, from = start, to = end, auto.assign = FALSE)

tckr <- c("GRPN") 

data <- getSymbols(tckr, from = "2015-01-01", to = "2015-05-01", auto.assign = FALSE)


macd  <- MACD( data[,"Close"], 12, 26, 9, maType="EMA" )

macd2 <- MACD( data[,"Close"], 12, 26, 9, maType=list(list(SMA), list(EMA, wilder=TRUE), list(SMA)) )

View(macd)



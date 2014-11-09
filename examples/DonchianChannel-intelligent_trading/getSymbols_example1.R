library(quantmod)
library(plyr)

tickers <- c("SPY","DIA","IWM","SMH","OIH","XLY","XLP","XLE","XLI","XLB","XLK","XLU")
getSymbols(tickers, from="2010-03-01", to="2011-03-11")
ClosePrices <- do.call(merge, lapply(tickers, function(x) Cl(get(x))))
head(ClosePrices)

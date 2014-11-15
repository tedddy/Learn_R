# refer to note "r - getSymbols and using lapply, Cl, and merge to extract close prices - Stack Overflow" (https://app.yinxiang.com/shard/s22/nl/4928451/888168e6-4cfe-452b-8cc8-391a99b4e138)
# hk stock cannot directly use the method in the note, and tedd has revised accordingly. Refer to signal_hk03818.R

library(quantmod)
library(TTR)
library(stringr)

code <- 2357
tckr = paste(code,"hk",sep=".")
tickers  <- paste("hk",code,sep="_")
start <- "2011-09-26"
end <- "2014-11-14"
hk_2357 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)


tckr <- "0719.hk"
#class(tckr)
tickers = c(tickers,"hk_0719")
start <- "2011-09-26"
end <- "2014-11-14"
hk_0719 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

ClosePrices <- do.call(merge, lapply(tickers, function(x) Cl(get(x))))
head(ClosePrices)

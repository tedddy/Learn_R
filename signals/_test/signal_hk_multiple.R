# refer to note "r - getSymbols and using lapply, Cl, and merge to extract close prices - Stack Overflow" (https://app.yinxiang.com/shard/s22/nl/4928451/888168e6-4cfe-452b-8cc8-391a99b4e138)
# hk stock cannot directly use the method in the note, and tedd has revised accordingly. Refer to signal_hk3818.R

library(quantmod)
library(TTR)

code <- 2357
tckr = paste(code,"hk",sep=".")
tickers  <- paste("hk",code,sep="_")
start <- "2011-09-26"
end <- "2014-11-14"
hk_2357 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)
hk_2357.H <- hk_2357[,2]
hk_2357_high <- runMax(hk_2357.H, n = 10, cumulative = FALSE)

tckr <- "0719.hk"
#class(tckr)
tickers = c(tickers,"hk_0719")
start <- "2011-09-26"
end <- "2014-11-14"
hk_0719 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)
hk_0719.H <- hk_0719[,2]
hk_0719_high <- runMax(hk_0719.H, n = 10, cumulative = FALSE)
hk_0719_buy <- tail(hk_0719_high, n=1)
hk_0719.L <- hk_0719[,3]
hk_0719_low <- runMin(hk_0719.L, n = 10, cumulative = FALSE)
hk_0719_sell <- tail(hk_0719_low, n=1)
View(hk_0719_sell)


# Merge close price for stocks.
ClosePrices <- do.call(merge, lapply(tickers, function(x) Cl(get(x))))
head(ClosePrices)

# Merge high price for stocks.
HighPrices <- do.call(merge, lapply(tickers, function(x) Hi(get(x))))
head(HighPrices)

# runMax(HighPrices[,1], n = 10, cumulative = FALSE)
# runMax(HighPrices[,2], n = 10, cumulative = FALSE)


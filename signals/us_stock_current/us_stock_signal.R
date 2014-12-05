# Packages loading
library(quantmod)

current <- c("GRPN") 

current <- c("LITB", "CMCM") 

signal_BuySell <- function (tckr) { 
  
  # Set start date and end date
  Sys.Date()-30 -> start
  Sys.Date() -> end
  
  # Fetch data from Yahoo
  data <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)
  
  # subset Adjusted Close column
  data.AC <- data[,6]
  # subset the price on the last day 
  data_AC <- tail(data.AC, n=1)
  
  data_AC_numeric <- as.numeric(data_AC[1])
  
  # subset High
  data.H <- data[,2]
  # time series of 20 days 
  data_high <- runMax(data.H, n = 20, cumulative = FALSE)
  # buy price
  data_buy <- tail(data_high, n=1)
  
  data_buy_numeric <- as.numeric(data_buy[1])
  
  # subset Low
  data.L <- data[,3]
  # time series of 20 days
  data_low <- runMin(data.L, n = 20, cumulative = FALSE)
  # sell price
  data_sell <- tail(data_low, n=1)
  
  data_sell_numeric <- as.numeric(data_sell[1])
  
  Lst <- data.frame(code = tckr, buy = data_buy_numeric, close = data_AC_numeric, sell = data_sell_numeric, buy_diff = 100*(data_buy_numeric-data_AC_numeric)/data_AC_numeric, sell_diff = 100*(data_sell_numeric-data_AC_numeric)/data_AC_numeric)
  
}

view_results <- function (tickers) {
  for (i in seq_along(tickers)) {
    if (i == 1) {
      signal <- signal_BuySell(tickers[[i]])
    }  else {
      signal <- rbind(signal, signal_BuySell(tickers[[i]]))
    }
  }
  
  View(signal)
  
  signal_ordered <- signal[ order(signal[,5], signal[,6]), ]
  
  View(signal_ordered)
}

view_results(current)



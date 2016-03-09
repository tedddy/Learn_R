# Packages loading
library(quantmod)

getDataDaily <- function (code) {
  
  tckr = if (substr(code, 1, 1) == "6") {
    paste(code,"SS",sep=".")
  } else if (substr(code, 1, 1) == "0") {
    paste(code,"SZ",sep=".")
  } else if (substr(code, 1, 1) == "3") {
    paste(code,"SZ",sep=".")
  }         
  
  # Set start date and end date
  Sys.Date()-252 -> start
  Sys.Date()-1 -> end
  
  # Fetch data from Yahoo
  ttrc <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)
  return(ttrc)
}

ttrc <- getDataDaily('002183')
# save ttrc to a file
save(ttrc, file= 'ttrc002183.rda', ascii = FALSE)

ttrc <- getDataDaily('601318')
# save ttrc to a file
save(ttrc, file= 'ttrc601318.rda', ascii = FALSE)

signal_BuySell <- function (code) {
  
  tckr = if (substr(code, 1, 1) == "6") {
    paste(code,"SS",sep=".")
  } else if (substr(code, 1, 1) == "0") {
    paste(code,"SZ",sep=".")
  } else if (substr(code, 1, 1) == "3") {
    paste(code,"SZ",sep=".")
  }         
  
  # Set start date and end date
  Sys.Date()-30 -> start
  Sys.Date()-1 -> end
  
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

watch_GuQi <- c("000031", "000900", "000996", "600208", "600638","600755")

signal_BuySell(watch_GuQi[[1]])


watch_GuQi[[1]]
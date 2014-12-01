# Load Package
library(quantmod)

signal_BuySell <- function (code) {
    
    tckr = if (substr(code, 1, 1) == "6") {
        paste(code,"SS",sep=".")
    } else if (substr(code, 1, 1) == "0") {
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

code_current <- c("000002", "600030", "600048", "600428", "600600", "601288", "601668") 

# failed: "601318"

for (i in seq_along(code_current)) {
    if (i == 1) {
        signal_current <- signal_BuySell(code_current[[i]])
    }  else {
        signal_current <- rbind(signal_current, signal_BuySell(code_current[[i]]))
    }
}
View(signal_current)

signal_current_ordered <- signal_current[ order(signal_current[,5], signal_current[,6]), ]
View(signal_current_ordered)

# getSymbols("601318.SS", from = Sys.Date()-30, to = Sys.Date()-1, auto.assign = FALSE)

watch_XinSanBan <- c("600128","600082","600895","000628","000998","600736","600064","000786","000917","000931","600210","000661","600872","600624","600862","600266","600658","600783","600851","000836","002673","000783","600884","000686","000551","000938","000532","600133","000776","000728","600283","601377","600635")

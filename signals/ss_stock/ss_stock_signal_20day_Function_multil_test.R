# Packages loading
library(quantmod)
library(RMySQL)

p <- c("000002", "000039", "000338", "002024", "600019", "600030", "600048", "600109", , "601668") ## First code is put in " " to make the vector charactor vector, and the code with 0 at the first postion should be quoted. "600030", "601318", 

s <- c("600428","600600", "601288")

watch_realestate <- c("600048", "600162", "600185", "600256", "600266", "600383", 600663, 600648, 600748, "600325", 600657, 600675, 600638, "600823")

watch_bank <- c("600016",  "601328",	"000001",	"600015",	"601818",	"002142",	"601998",	"601939",	"600000",	"601166",	"601988",	"601288",	"600036",	"601169",	"601009",	"601398")

watch_splite <- c("000977","300196","300295","300304","300336","300347","300349","300382","300383","600436","600486","600587","300171","002725","002695","002391","002393","002441","002550","002582","002588","002589","002595","002612","002661","002664","002672","601799","002574") ##  "300294","300358",

code_watch_ShuiLi <- c("600068","600075","600116","600131","600283","600502","601669")

code_watch_YiYao <- c("600062","600079","600085","600129","600161","600196","600216","600222","600252","600267","600276","600285","600297","600329","600332","600351","600352","600353","600354","600355","600356","600357","600358","600359","600360","600361","600362","600363","600364","600365","600366","600367","600368")

watch_3market <- c("600783","000661","000532","600635","000836","600872","600736","000776","600884","600658","600133","600210","000551","000686","000628","000783","600082","601377","002673","600624","000917","000998","600064","000728","600895","000786","000938","600128","600851","600266","000931","600283") ##  "600862",
view_results(watch_3market)

watch_GuQi <- c("000031", "000900", "000996", "600208", "600638","600755") ## ,"600369"

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
  
  dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
  
  dbWriteTable(dbh, 'temp', data, row.names = FALSE, overwrite = TRUE)
  
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
  
  # View(signal_current)
  
  signal_ordered <- signal[ order(signal[,5], signal[,6]), ]
  
  View(signal_ordered)
}

view_results(code_current)

view_results(watch_realestate)

view_results(watch_bank)

view_results(watch_splite)

view_results(watch_GuQi)

# e start

# Set start date and end date
Sys.Date()-30 -> start
Sys.Date()-1 -> end

data <- getSymbols("600256.SS", from = start, to = end, auto.assign = FALSE)

temp <- signal_BuySell("600256")

# e end


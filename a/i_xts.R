require(quantmod)
require(RMySQL)

sqlQuery <- function (query) {
    DB <- dbConnect(MySQL(), user="gxh", password='locoy', dbname='ying_calc', host='192.168.137.172')
    rs <- dbSendQuery(DB, query)
    # get elements from result sets and convert to dataframe
    result <- fetch(rs, -1)
    # close db connection
    dbDisconnect(DB)
    # return the dataframe
    return(result)
}


data_hs000300_day <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_xts where `idi` = '000300' ORDER BY `dt` DESC LIMIT 50;") # query database 5 minutes interval

data_hs000300_day <- data_hs000300_day[order(data_hs000300_day$date),] # order data

rownames(data_hs000300_day) = data_hs000300_day[,1] # change rownames

data_hs000300_day <- data_hs000300_day[,-1] # delete date column

data_hs000300_day <- as.xts(data_hs000300_day) # matrix 2 xts

hs000300_day<-merge(Cl(data_hs000300_day), MACD(Cl(data_hs000300_day), 8, 17, 9, "EMA", FALSE))

hs000300_day$macdOsc <- hs000300_day$macd - hs000300_day$signal           

View(tail(hs000300_day, n=20L))



data_hs000016_day <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_xts where `idi` = '000016' ORDER BY `dt` DESC LIMIT 50;") # query database 5 minutes interval

data_hs000016_day <- data_hs000016_day[order(data_hs000016_day$date),] # order data

rownames(data_hs000016_day) = data_hs000016_day[,1] # change rownames

data_hs000016_day <- data_hs000016_day[,-1] # delete date column

data_hs000016_day <- as.xts(data_hs000016_day) # matrix 2 xts

hs000016_day<-merge(Cl(data_hs000016_day), MACD(Cl(data_hs000016_day), 8, 17, 9, "EMA", FALSE))

hs000016_day$macdOsc <- hs000016_day$macd - hs000016_day$signal           

View(tail(hs000016_day, n=20L))
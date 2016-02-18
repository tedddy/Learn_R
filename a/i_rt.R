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


data_hs000300_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000300' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_hs000300_5 <- data_hs000300_5[order(data_hs000300_5$date),] # order data

rownames(data_hs000300_5) = data_hs000300_5[,1] # change rownames

data_hs000300_5 <- data_hs000300_5[,-1] # delete date column

data_hs000300_5 <- as.xts(data_hs000300_5) # matrix 2 xts

hs000300_5<-merge(Cl(data_hs000300_5), MACD(Cl(data_hs000300_5), 8, 17, 9, "EMA", FALSE))

hs000300_5$macdOsc <- hs000300_5$macd - hs000300_5$signal           

View(tail(hs000300_5, n=20L))

# query database 30 minutes interval
data_hs000300_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '000300' order by dt desc;")

data_hs000300_30 <- data_hs000300_30[order(data_hs000300_30$date),] # order data

rownames(data_hs000300_30) = data_hs000300_30[,1] # change rownames

data_hs000300_30 <- data_hs000300_30[,-1] # delete date column

data_hs000300_30 <- as.xts(data_hs000300_30) # matrix 2 xts

hs000300_30<-merge(Cl(data_hs000300_30), MACD(Cl(data_hs000300_30), 8, 17, 9, "EMA", FALSE))

hs000300_30$macdOsc <- hs000300_30$macd - hs000300_30$signal  

View(tail(hs000300_30, n=18L))

# query database 60 minutes interval
data_hs000300_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '000300' order by dt desc;")

data_hs000300_60 <- data_hs000300_60[order(data_hs000300_60$date),] # order data

rownames(data_hs000300_60) = data_hs000300_60[,1] # change rownames

data_hs000300_60 <- data_hs000300_60[,-1] # delete date column

data_hs000300_60 <- as.xts(data_hs000300_60) # matrix 2 xts

hs000300_60<-merge(Cl(data_hs000300_60), MACD(Cl(data_hs000300_60), 8, 17, 9, "EMA", FALSE))

hs000300_60$macdOsc <- hs000300_60$macd - hs000300_60$signal   

View(tail(hs000300_60, n=12L))

data_hs000016_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000016' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_hs000016_5 <- data_hs000016_5[order(data_hs000016_5$date),] # order data

rownames(data_hs000016_5) = data_hs000016_5[,1] # change rownames

data_hs000016_5 <- data_hs000016_5[,-1] # delete date column

data_hs000016_5 <- as.xts(data_hs000016_5) # matrix 2 xts

hs000016_5<-merge(Cl(data_hs000016_5), MACD(Cl(data_hs000016_5), 8, 17, 9, "EMA", FALSE))

hs000016_5$macdOsc <- hs000016_5$macd - hs000016_5$signal           

View(tail(hs000016_5, n=20L))

# query database 30 minutes interval
data_hs000016_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '000016' order by dt desc;")

data_hs000016_30 <- data_hs000016_30[order(data_hs000016_30$date),] # order data

rownames(data_hs000016_30) = data_hs000016_30[,1] # change rownames

data_hs000016_30 <- data_hs000016_30[,-1] # delete date column

data_hs000016_30 <- as.xts(data_hs000016_30) # matrix 2 xts

hs000016_30<-merge(Cl(data_hs000016_30), MACD(Cl(data_hs000016_30), 8, 17, 9, "EMA", FALSE))

hs000016_30$macdOsc <- hs000016_30$macd - hs000016_30$signal   

View(tail(hs000016_30, n=18L))

# query database 60 minutes interval
data_hs000016_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '000016' order by dt desc;")

data_hs000016_60 <- data_hs000016_60[order(data_hs000016_60$date),] # order data

rownames(data_hs000016_60) = data_hs000016_60[,1] # change rownames

data_hs000016_60 <- data_hs000016_60[,-1] # delete date column

data_hs000016_60 <- as.xts(data_hs000016_60) # matrix 2 xts

hs000016_60<-merge(Cl(data_hs000016_60), MACD(Cl(data_hs000016_60), 8, 17, 9, "EMA", FALSE))

hs000016_60$macdOsc <- hs000016_60$macd - hs000016_60$signal   

View(tail(hs000016_60, n=12L))

# 399959

data_hs399959_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '399959' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_hs399959_5 <- data_hs399959_5[order(data_hs399959_5$date),] # order data

rownames(data_hs399959_5) = data_hs399959_5[,1] # change rownames

data_hs399959_5 <- data_hs399959_5[,-1] # delete date column

data_hs399959_5 <- as.xts(data_hs399959_5) # matrix 2 xts

hs399959_5<-merge(Cl(data_hs399959_5), MACD(Cl(data_hs399959_5), 8, 17, 9, "EMA", FALSE))

hs399959_5$macdOsc <- hs399959_5$macd - hs399959_5$signal           

View(tail(hs399959_5, n=20L))

# query database 30 minutes interval
data_hs399959_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '399959' order by dt desc;")

data_hs399959_30 <- data_hs399959_30[order(data_hs399959_30$date),] # order data

rownames(data_hs399959_30) = data_hs399959_30[,1] # change rownames

data_hs399959_30 <- data_hs399959_30[,-1] # delete date column

data_hs399959_30 <- as.xts(data_hs399959_30) # matrix 2 xts

hs399959_30<-merge(Cl(data_hs399959_30), MACD(Cl(data_hs399959_30), 8, 17, 9, "EMA", FALSE))

hs399959_30$macdOsc <- hs399959_30$macd - hs399959_30$signal   

View(tail(hs399959_30, n=18L))

# query database 60 minutes interval
data_hs399959_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '399959' order by dt desc;")

data_hs399959_60 <- data_hs399959_60[order(data_hs399959_60$date),] # order data

rownames(data_hs399959_60) = data_hs399959_60[,1] # change rownames

data_hs399959_60 <- data_hs399959_60[,-1] # delete date column

data_hs399959_60 <- as.xts(data_hs399959_60) # matrix 2 xts

hs399959_60<-merge(Cl(data_hs399959_60), MACD(Cl(data_hs399959_60), 8, 17, 9, "EMA", FALSE))

hs399959_60$macdOsc <- hs399959_60$macd - hs399959_60$signal   

View(tail(hs399959_60, n=12L))


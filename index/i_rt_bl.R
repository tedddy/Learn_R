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


iclose5 <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` =",idi," ORDER BY `dt` DESC LIMIT 500;"))
    
    rownames(data) <- as.POSIXct(data[,1])
  
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
  
    close<-merge(Cl(data), MACD(Cl(data), 8, 17, 9, "EMA", FALSE))
  
    close$macdOsc <- close$macd - close$signal
  
    macd_close <-cbind(idi, close, diff(close$close), diff(close$macdOsc)) 
    
    macd_close <- setNames(bl, c("idi", "close", "macd_cl", "signal_cl", "macdOsc_cl", "close_d1", "macdOsc_cl_d1"))
  
    return(bl)
}
bl_5 <- i5('000016')
View(bl_5)





remove (bl)

data_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000300' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

rownames(data_5) <- as.POSIXct(data_5[,1])

data_temp <- xts(data_5[,-1], order.by=as.POSIXct(data_5[,1]))

close_5<-merge(Cl(data_temp), MACD(Cl(data_temp), 8, 17, 9, "EMA", FALSE), MACD(data_temp[,3], 8, 17, 9, "EMA", FALSE))

close_5$macdOsc <- close_5$macd - close_5$signal 
close_5$macdOsc.1 <- close_5$macd.1 - close_5$signal.1             


# View(tail(close_5, n=24L))

bl<-cbind(close_5, diff(close_5$close), diff(close_5$macdOsc), diff(close_5$macdOsc.1)) 

View(bl)




# query database 30 minutes interval
data_hs000300_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '000300' order by dt desc;")

data_hs000300_30 <- data_hs000300_30[order(data_hs000300_30$date),] # order data

rownames(data_hs000300_30) = data_hs000300_30[,1] # change rownames

data_hs000300_30 <- data_hs000300_30[,-1] # delete date column

data_hs000300_30 <- as.xts(data_hs000300_30) # matrix 2 xts

hs000300_30<-merge(Cl(data_hs000300_30), MACD(Cl(data_hs000300_30), 8, 17, 9, "EMA", FALSE))

hs000300_30$macdOsc <- hs000300_30$macd - hs000300_30$signal  

View(tail(hs000300_30, n=24L))

# query database 60 minutes interval
data_hs000300_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '000300' order by dt desc;")

data_hs000300_60 <- data_hs000300_60[order(data_hs000300_60$date),] # order data

rownames(data_hs000300_60) = data_hs000300_60[,1] # change rownames

data_hs000300_60 <- data_hs000300_60[,-1] # delete date column

data_hs000300_60 <- as.xts(data_hs000300_60) # matrix 2 xts

hs000300_60<-merge(Cl(data_hs000300_60), MACD(Cl(data_hs000300_60), 8, 17, 9, "EMA", FALSE))

hs000300_60$macdOsc <- hs000300_60$macd - hs000300_60$signal   

View(tail(hs000300_60, n=24L))

data_hs000016_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000016' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_hs000016_5 <- data_hs000016_5[order(data_hs000016_5$date),] # order data

rownames(data_hs000016_5) = data_hs000016_5[,1] # change rownames

data_hs000016_5 <- data_hs000016_5[,-1] # delete date column

data_hs000016_5 <- as.xts(data_hs000016_5) # matrix 2 xts

hs000016_5<-merge(Cl(data_hs000016_5), MACD(Cl(data_hs000016_5), 8, 17, 9, "EMA", FALSE))

hs000016_5$macdOsc <- hs000016_5$macd - hs000016_5$signal           

View(tail(hs000016_5, n=24L))
View(tail(hs000016_5, n=88L))
# query database 30 minutes interval
data_hs000016_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '000016' order by dt desc;")

data_hs000016_30 <- data_hs000016_30[order(data_hs000016_30$date),] # order data

rownames(data_hs000016_30) = data_hs000016_30[,1] # change rownames

data_hs000016_30 <- data_hs000016_30[,-1] # delete date column

data_hs000016_30 <- as.xts(data_hs000016_30) # matrix 2 xts

hs000016_30<-merge(Cl(data_hs000016_30), MACD(Cl(data_hs000016_30), 8, 17, 9, "EMA", FALSE))

hs000016_30$macdOsc <- hs000016_30$macd - hs000016_30$signal   

View(tail(hs000016_30, n=24L))

# query database 60 minutes interval
data_hs000016_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '000016' order by dt desc;")

data_hs000016_60 <- data_hs000016_60[order(data_hs000016_60$date),] # order data

rownames(data_hs000016_60) = data_hs000016_60[,1] # change rownames

data_hs000016_60 <- data_hs000016_60[,-1] # delete date column

data_hs000016_60 <- as.xts(data_hs000016_60) # matrix 2 xts

hs000016_60<-merge(Cl(data_hs000016_60), MACD(Cl(data_hs000016_60), 8, 17, 9, "EMA", FALSE))

hs000016_60$macdOsc <- hs000016_60$macd - hs000016_60$signal   

View(tail(hs000016_60, n=24L))

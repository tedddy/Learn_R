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


data_fg_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '399974' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_fg_5 <- data_fg_5[order(data_fg_5$date),] # order data

rownames(data_fg_5) = data_fg_5[,1] # change rownames

data_fg_5 <- data_fg_5[,-1] # delete date column

data_fg_5 <- as.xts(data_fg_5) # matrix 2 xts

fg_5<-merge(Cl(data_fg_5), MACD(Cl(data_fg_5), 8, 17, 9, "EMA", FALSE))

fg_5$macdOsc <- fg_5$macd - fg_5$signal           

View(tail(fg_5, n=20L))

# query database 30 minutes interval
data_fg_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '399974' order by dt desc;")

data_fg_30 <- data_fg_30[order(data_fg_30$date),] # order data

rownames(data_fg_30) = data_fg_30[,1] # change rownames

data_fg_30 <- data_fg_30[,-1] # delete date column

data_fg_30 <- as.xts(data_fg_30) # matrix 2 xts

fg_30<-merge(Cl(data_fg_30), MACD(Cl(data_fg_30), 8, 17, 9, "EMA", FALSE))

fg_30$macdOsc <- fg_30$macd - fg_30$signal  

View(tail(fg_30, n=18L))

# query database 60 minutes interval
data_fg_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '399974' order by dt desc;")

data_fg_60 <- data_fg_60[order(data_fg_60$date),] # order data

rownames(data_fg_60) = data_fg_60[,1] # change rownames

data_fg_60 <- data_fg_60[,-1] # delete date column

data_fg_60 <- as.xts(data_fg_60) # matrix 2 xts

fg_60<-merge(Cl(data_fg_60), MACD(Cl(data_fg_60), 8, 17, 9, "EMA", FALSE))

fg_60$macdOsc <- fg_60$macd - fg_60$signal   

View(tail(fg_60, n=12L))

# 

data_fz_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000016' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_fz_5 <- data_fz_5[order(data_fz_5$date),] # order data

rownames(data_fz_5) = data_fz_5[,1] # change rownames

data_fz_5 <- data_fz_5[,-1] # delete date column

data_fz_5 <- as.xts(data_fz_5) # matrix 2 xts

fz_5<-merge(Cl(data_fz_5), MACD(Cl(data_fz_5), 8, 17, 9, "EMA", FALSE))

fz_5$macdOsc <- fz_5$macd - fz_5$signal           

View(tail(fz_5, n=20L))

# query database 30 minutes interval
data_fz_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '000016' order by dt desc;")

data_fz_30 <- data_fz_30[order(data_fz_30$date),] # order data

rownames(data_fz_30) = data_fz_30[,1] # change rownames

data_fz_30 <- data_fz_30[,-1] # delete date column

data_fz_30 <- as.xts(data_fz_30) # matrix 2 xts

fz_30<-merge(Cl(data_fz_30), MACD(Cl(data_fz_30), 8, 17, 9, "EMA", FALSE))

fz_30$macdOsc <- fz_30$macd - fz_30$signal   

View(tail(fz_30, n=18L))

# query database 60 minutes interval
data_fz_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '000016' order by dt desc;")

data_fz_60 <- data_fz_60[order(data_fz_60$date),] # order data

rownames(data_fz_60) = data_fz_60[,1] # change rownames

data_fz_60 <- data_fz_60[,-1] # delete date column

data_fz_60 <- as.xts(data_fz_60) # matrix 2 xts

fz_60<-merge(Cl(data_fz_60), MACD(Cl(data_fz_60), 8, 17, 9, "EMA", FALSE))

fz_60$macdOsc <- fz_60$macd - fz_60$signal   

View(tail(fz_60, n=12L))

# 399959

data_fj_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '399959' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_fj_5 <- data_fj_5[order(data_fj_5$date),] # order data

rownames(data_fj_5) = data_fj_5[,1] # change rownames

data_fj_5 <- data_fj_5[,-1] # delete date column

data_fj_5 <- as.xts(data_fj_5) # matrix 2 xts

fj_5<-merge(Cl(data_fj_5), MACD(Cl(data_fj_5), 8, 17, 9, "EMA", FALSE))

fj_5$macdOsc <- fj_5$macd - fj_5$signal           

View(tail(fj_5, n=20L))

# query database 30 minutes interval
data_fj_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '399959' order by dt desc;")

data_fj_30 <- data_fj_30[order(data_fj_30$date),] # order data

rownames(data_fj_30) = data_fj_30[,1] # change rownames

data_fj_30 <- data_fj_30[,-1] # delete date column

data_fj_30 <- as.xts(data_fj_30) # matrix 2 xts

fj_30<-merge(Cl(data_fj_30), MACD(Cl(data_fj_30), 8, 17, 9, "EMA", FALSE))

fj_30$macdOsc <- fj_30$macd - fj_30$signal   

View(tail(fj_30, n=18L))

# query database 60 minutes interval
data_fj_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '399959' order by dt desc;")

data_fj_60 <- data_fj_60[order(data_fj_60$date),] # order data

rownames(data_fj_60) = data_fj_60[,1] # change rownames

data_fj_60 <- data_fj_60[,-1] # delete date column

data_fj_60 <- as.xts(data_fj_60) # matrix 2 xts

fj_60<-merge(Cl(data_fj_60), MACD(Cl(data_fj_60), 8, 17, 9, "EMA", FALSE))

fj_60$macdOsc <- fj_60$macd - fj_60$signal   

View(tail(fj_60, n=12L))


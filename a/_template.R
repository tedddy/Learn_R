data_hs000016_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000016' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_hs000016_5 <- data_hs000016_5[order(data_hs000016_5$date),] # order data

rownames(data_hs000016_5) = data_hs000016_5[,1] # change rownames

data_hs000016_5 <- data_hs000016_5[,-1] # delete date column

data_hs000016_5 <- as.xts(data_hs000016_5) # matrix 2 xts

hs000016_5<-merge(Cl(data_hs000016_5), MACD(Cl(data_hs000016_5), 8, 17, 9, "EMA", FALSE))

hs000016_5$macdOsc <- hs000016_5$macd - hs000016_5$signal           

View(tail(hs000016_5, n=25L))

# query database 30 minutes interval
data_hs000016_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '000016' order by dt desc;")

data_hs000016_30 <- data_hs000016_30[order(data_hs000016_30$date),] # order data

rownames(data_hs000016_30) = data_hs000016_30[,1] # change rownames

data_hs000016_30 <- data_hs000016_30[,-1] # delete date column

data_hs000016_30 <- as.xts(data_hs000016_30) # matrix 2 xts

hs000016_30<-merge(Cl(data_hs000016_30), MACD(Cl(data_hs000016_30), 8, 17, 9, "EMA", FALSE))

hs000016_30$macdOsc <- hs000016_30$macd - hs000016_30$signal   

# query database 60 minutes interval
data_hs000016_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '000016' order by dt desc;")

data_hs000016_60 <- data_hs000016_60[order(data_hs000016_60$date),] # order data

rownames(data_hs000016_60) = data_hs000016_60[,1] # change rownames

data_hs000016_60 <- data_hs000016_60[,-1] # delete date column

data_hs000016_60 <- as.xts(data_hs000016_60) # matrix 2 xts

hs000016_60<-merge(Cl(data_hs000016_60), MACD(Cl(data_hs000016_60), 8, 17, 9, "EMA", FALSE))

hs000016_60$macdOsc <- hs000016_60$macd - hs000016_60$signal   

View(tail(hs000016_60, n=25L))

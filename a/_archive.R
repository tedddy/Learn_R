#calc_macd of hs000016 

dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
res=dbSendQuery(dbh, "SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000016' ORDER BY `dt` DESC LIMIT 500;")

data_hs000016 =fetch(res)
data_hs000016 <- data_hs000016[order(data_hs000016$date),] 

# View(tail(data_hs000016, n=5L))

data_hs000016 <- data_hs000016[order(data_hs000016$date),] # order data

rownames(data_hs000016) = data_hs000016[,1] # change rownames
data_hs000016 <- data_hs000016[,-1] # delete date column
data_hs000016 <- as.xts(data_hs000016) # matrix 2 xts
hs000016<-merge(Cl(data_hs000016), MACD(Cl(data_hs000016), 8, 17, 9, "EMA", FALSE))

hs000016$macdOsc <- hs000016$macd - hs000016$signal           

View(tail(hs000016, n=25L))
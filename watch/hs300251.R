require(quantmod)  # https://app.yinxiang.com/shard/s22/nl/4928451/cd48717b-a33a-4801-a646-71f25cd95c3f
require(RMySQL)
# getSymbols("IBM", source="google")
#ibm <- merge(Cl(IBM), MACD(Cl(IBM), 8, 17, 9, "EMA", FALSE))
#ibm$macdOsc <- ibm$macd - ibm$signal
#tail(ibm)

dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")

dbSendQuery(dbh,'SET NAMES utf8 ')

res=dbSendQuery(dbh, "select a.`dt`, a.`open`, a.`high`, a.`low`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `open`, `high`, `low`, `close`, `volume`, `amount` FROM `ying_calc`.`s_xts_adj` where ids = '300251' order by `dt` desc limit 98) as a order by a.`dt`;")

data_300251 =fetch(res)

rownames(data_300251) = data_300251[,1]

data_xts_temp <- data_300251[,-1]
data_xts_300251 <- as.xts(data_xts_temp) # https://app.yinxiang.com/shard/s22/nl/4928451/6eb45b4d-bb5e-4e29-a2cc-6f5379b00f2e

hs300251<-merge(Cl(data_xts_300251), MACD(Cl(data_xts_300251), 8, 17, 9, "EMA", FALSE))

hs300251$macdOsc <- hs300251$macd - hs300251$signal           

View(tail(hs300251))


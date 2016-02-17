require(quantmod)  # https://app.yinxiang.com/shard/s22/nl/4928451/cd48717b-a33a-4801-a646-71f25cd95c3f
require(RMySQL)
# getSymbols("IBM", source="google")
#ibm <- merge(Cl(IBM), MACD(Cl(IBM), 8, 17, 9, "EMA", FALSE))
#ibm$macdOsc <- ibm$macd - ibm$signal
#tail(ibm)

dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying", host="192.168.137.172")

dbSendQuery(dbh,'SET NAMES utf8 ')

res=dbSendQuery(dbh, "select a.`date`, a.`open`, a.`high`, a.`low`, a.`close`, a.`volume`, a.`amount` from (SELECT `date`, `open`, `high`, `low`, `close`, `volume`, `amount` FROM `ying`.`hk_s_xts` where code = '02823' order by `date` desc limit 48) as a order by a.`date`;")

data_02823 =fetch(res)

rownames(data_02823) = data_02823[,1]

data_xts_temp <- data_02823[,-1]
data_xts_02823 <- as.xts(data_xts_temp) # https://app.yinxiang.com/shard/s22/nl/4928451/6eb45b4d-bb5e-4e29-a2cc-6f5379b00f2e

hk02823<-merge(Cl(data_xts_02823), MACD(Cl(data_xts_02823), 8, 17, 9, "EMA", FALSE))

hk02823$macdOsc <- hk02823$macd - hk02823$signal           

View(tail(hk02823))


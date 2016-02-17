require(quantmod)  # https://app.yinxiang.com/shard/s22/nl/4928451/cd48717b-a33a-4801-a646-71f25cd95c3f
require(RMySQL)
# getSymbols("IBM", source="google")
#ibm <- merge(Cl(IBM), MACD(Cl(IBM), 8, 17, 9, "EMA", FALSE))
#ibm$macdOsc <- ibm$macd - ibm$signal
#tail(ibm)

dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying", host="192.168.137.172")

dbSendQuery(dbh,'SET NAMES utf8 ')

res=dbSendQuery(dbh, "SELECT `date`, `open`, `high`, `low`, `close`, `volume`, `amount` FROM `ying`.`hk_s_xts` where code = '03888' and datediff(curdate(), `date`) < 88 order by date;")

data_imported =fetch(res)

data_imported[,1]

rownames(data_imported) = data_imported[,1]

data_xts_pre <- data_imported[,-1]
data_xts <- as.xts(data_xts_pre) # https://app.yinxiang.com/shard/s22/nl/4928451/6eb45b4d-bb5e-4e29-a2cc-6f5379b00f2e

Cl(data_xts)

head(data_xts)

data_xts[,1]

MACD(Cl(data_xts), 8, 17, 9, "EMA", FALSE)

hk03888<-merge(Cl(data_xts), MACD(Cl(data_xts), 8, 17, 9, "EMA", FALSE))

hk03888$macdOsc <- hk03888$macd - hk03888$signal           

tail(hk03888)


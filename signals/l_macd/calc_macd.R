require(quantmod)  # https://app.yinxiang.com/shard/s22/nl/4928451/cd48717b-a33a-4801-a646-71f25cd95c3f
require(RMySQL)
# getSymbols("IBM", from = "2015-01-01", src = "yahoo")
ibm <- merge(Cl(IBM), MACD(Cl(IBM), 8, 17, 9, "EMA", FALSE))
ibm$macdOsc <- ibm$macd - ibm$signal
tail(ibm)

data(ttrc)

macd <- MACD( ttrc[,"Close"], 12, 26, 9, maType="EMA" )

macd2 <- MACD( ttrc[,"Close"], 12, 26, 9, maType=list(list(SMA), list(EMA, wilder=TRUE), list(SMA)) )

spy<-getSymbols(("SPY") , src = 'yahoo', from = '2007-01-01', auto.assign = T)

spy<-cbind(SPY)
SPY$SMI3MA <- SMI(SPY[,c("SPY.High","SPY.Low","SPY.Close")], maType=list(list(SMA), list(EMA, wilder=TRUE), list(SMA)) )
SPY$SMI3MA_T <- Lag(SPY$SMI3MA  , k = 1 )
tail(SPY)


dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")

dbSendQuery(dbh,'SET NAMES utf8 ')

dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
res=dbSendQuery(dbh, "SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000300' ORDER BY `dt` DESC LIMIT 500;")
dat=fetch(res)
dat1 <- dat[order(dat$date),] 

# hs300 <- merge(Cl(dat), MACD(Cl(dat), 8, 17, 9, "EMA", FALSE))

#calc macd without using matrix

temp<-merge(dat1[,1], MACD(dat[,2], 8, 17, 9, "EMA", FALSE))
            

hs300MACD <- MACD(dat1[,2], 8, 17, 9, "EMA", FALSE)

hs300MACD[,1]

hs300MACD[,2] 

hs300MACD_macdOsc <- hs300MACD[,1] - hs300MACD[,2] 

data <- cbind(dat1, MACD(dat1[,2], 8, 17, 9, "EMA", FALSE),hs300MACD_macdOsc)


getSymbols("IBM", source="google")

#calc macd without using xts

data_hs300 =fetch(res)

data_hs300 <- dat[order(data_hs300$date),] 

rownames(data_hs300) = data_hs300[,1]

data_xts_temp <- data_hs300[,-1]
data_xts_hs300 <- as.xts(data_xts_temp) # https://app.yinxiang.com/shard/s22/nl/4928451/6eb45b4d-bb5e-4e29-a2cc-6f5379b00f2e

hs300<-merge(Cl(data_xts_hs300), MACD(Cl(data_xts_hs300), 8, 17, 9, "EMA", FALSE))

hs300$macdOsc <- hs300$macd - hs300$signal           

View(tail(hs300))

View(hs300)


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

# function to get xts data from mysql database

i_xts_sqlData <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT 500;"))
    # converting data.frame to xts
    rownames(data) <- as.POSIXct(data[,1])
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    return(data)
}
xts_399934 <- i_xts_sqlData('399934')
ttrc <- xts_399934
macd <- MACD( ttrc[,"Close"], 12, 26, 9, maType="EMA" )
macd2 <- MACD( ttrc[,"Close"], 8, 17, 9, maType="EMA" )


# e start
idi <- '399934'
data <- sqlQuery(paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT 500;"))
# converting data.frame to xts
rownames(data) <- as.POSIXct(data[,1])
ttrc <- xts(data[,-1], order.by=as.POSIXct(data[,1]))

ema.12 <- EMA(ttrc[,"Close"], 12)
ema.26 <- EMA(ttrc[,"Close"], 26)

ema.12-ema.26

macd <- MACD( ttrc[,"Close"], 12, 26, 9, maType="EMA", percent = FALSE )
macd_sma <- MACD( ttrc[,"Close"], 12, 26, 9, maType="SMA", percent = FALSE )

macd2 <- MACD( ttrc[,"Close"], 8, 17, 9, maType="EMA" )




dmi.adx <- ADX(ttrc[,c("High","Low","Close")])
bbands.HLC <- BBands( ttrc[,c("High","Low","Close")] )
bbands.close <- BBands( ttrc[,"Close"] )
roc <- ROC(ttrc[,"Close"])
mom <- momentum(ttrc[,"Close"])
price <- ttrc[,"Close"]
# Default case
rsi <- RSI(price)
# Case of one 'maType' for both MAs
rsiMA1 <- RSI(price, n=14, maType="WMA", wts=ttrc[,"Volume"])
# Case of two different 'maType's for both MAs
rsiMA2 <- RSI(price, n=14, maType=list(maUp=list(EMA,ratio=1/5),maDown=list(WMA,wts=1:10)))

stochOSC <- stoch(ttrc[,c("High","Low","Close")])
stochWPR <- WPR(ttrc[,c("High","Low","Close")])
plot(tail(stochOSC[,"fastK"], 100), type="l",
     main="Fast %K and Williams %R", ylab="",
     ylim=range(cbind(stochOSC, stochWPR), na.rm=TRUE) )
lines(tail(stochWPR, 100), col="blue")
lines(tail(1-stochWPR, 100), col="red", lty="dashed")
stoch2MA <- stoch( ttrc[,c("High","Low","Close")],maType=list(list(SMA), list(EMA, wilder=TRUE), list(SMA)) )
SMI3MA <- SMI(ttrc[,c("High","Low","Close")],maType=list(list(SMA), list(EMA, wilder=TRUE), list(SMA)) )
stochRSI <- stoch( RSI(ttrc[,"Close"]) )

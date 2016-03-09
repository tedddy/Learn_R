diff(1:10, 2)
diff(1:10, 2, 2)
x <- cumsum(cumsum(1:10))
diff(x, lag = 2)
diff(x, differences = 2)

diff(.leap.seconds)


# http://stackoverflow.com/questions/20724203/need-to-calculate-rate-of-change-of-two-data-sets-over-time-individually-and-net 
# all this just to get sample data.
# daily close for AAPL from 2013.01.01 - today
library(tseries)
library(zoo)
ts <- get.hist.quote(instrument="AAPL", 
                     start="2013-01-01", end="2014-01-01", 
                     quote="AdjClose", provider="yahoo", origin="1970-01-01",
                     compression="d", retclass="zoo")
df <- data.frame(ts)
df <- data.frame(date=as.Date(rownames(df)),price=df$AdjClose)
df <- df[!is.na(df$price),]

# calculate daily rate of change...
rate <- 100*diff(df$price)/df[-nrow(df),]$price

plot(df[-nrow(df),]$date,rate,type="l",xlab="2013",ylab="Pct. Change",main="APPL")


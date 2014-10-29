# http://intelligenttradingtech.blogspot.hk/2010/03/modified-dochian-band-trend-follower.html

# We will need the quantmod package for charting and pulling
# data and the TTR package to calculate Donchian Bands.
# You can install packages via: install.packages("packageName")
# install.packages(c("quantmod","TTR"))
# See Foss Trading Blog for RSI template

library(quantmod)
library(TTR)

tckr <- "QQQ"

# Since NASDAQ changed the symbols from QQQQ from QQQ, we revise it accordingly.

# tckr_obj <- QQQ
#Note: there might be a typo in the original document, and this line should be after "getSymbols(tckr,from=start,to=end)".

start <- "2011-01-01"
end <- "2014-10-28"

# Pull tckr index data from Yahoo! Finance
getSymbols(tckr,from=start,to=end)

tckr_obj <- QQQ

QQQ.cl <- QQQ[,6]

QQQ.H <- QQQ[,2]

QQQ.L <- QQQ[,3]

dc <- DonchianChannel(cbind(QQQ.H,QQQ.L),n=80)

#Plotting Donchian Channel
ymin=25
ymax=55

par(mfrow=c(2,2),oma=c(2,2,2,2))

plot(dc[,1],col="red",ylim=c(ymin,ymax),main="")

par(new=T)

plot(dc[,2],col="blue",ylim=c(ymin,ymax),main="")

par(new=T)

plot(dc[,3],col="green",ylim=c(ymin,ymax),main="")

par(new=T)

# !!! Error in axis(1, at = xycoords$x, labels = FALSE, col = "#BBBBBB", ...) : 
# formal argument "col" matched by multiple actual arguments
# http://stackoverflow.com/questions/19220301/change-of-col-argument-throwing-an-error-and-how-to-store-individual-graphical-p

plot(QQQ.cl,ylim=c(ymin,ymax),pch=15,main="donchian bands max/avg/min")

lines(QQQ.cl,ylim(ymin,ymax))

###################################################

# Create the long (up) and short (dn) signals
sigup <-ifelse(QQQ.cl > dc[,2],1,0)
sigdn <-ifelse(QQQ.cl < dc[,2],-1,0)

# Lag signals to align with days in market,
# not days signals were generated
sigup <- lag(sigup,1) # Note k=1 implies a move *forward*
sigdn <- lag(sigdn,1) # Note k=1 implies a move *forward*

# Replace missing signals with no position
# (generally just at beginning of series)
sigup[is.na(sigup)] <- 0
sigdn[is.na(sigdn)] <- 0

# Combine both signals into one vector
sig <- sigup + sigdn

# Calculate Close-to-Close returns
ret <- ROC(tckr_obj[,6])
ret[1] <- 0

# Calculate equity curves
eq_up <- cumprod(1+ret*sigup)
eq_dn <- cumprod(1+ret*sigdn)
eq_all <- cumprod(1+ret*sig)

#graphics
mfg=c(1,2)
plot(eq_up,ylab="Long",col="green")
mfg=c(2,2)
plot(eq_all,ylab="Combined",col="blue",main="combined L/S equity")
mfg=c(2,1)
plot(eq_dn,ylab="Short",col="red")
title("Modified Donchian Band Trend Following System (intelligenttradingtech.blogspot.com)", outer = TRUE)


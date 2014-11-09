# http://intelligenttradingtech.blogspot.hk/2010/03/modified-dochian-band-trend-follower.html
# Refer to quantmod-vignette.pdf
# http://www.quantmod.com/documentation/getSymbols.yahoo.html
# troubleshooting: http://stackoverflow.com/questions/8562197/quantmod-save-tickers-to-files-in-a-loop-or-lapply

library(quantmod)
library(TTR)

# Tedd: ruan this block for only once, and then comment them out.  
# Set up symbol, start date, and end date. 2011-09-26 is the local minimum of shanhai index. 
# empty "end" means end is today
# Pull tckr index data from Yahoo! Finance

# tckr <- "3818.hk"
# start <- "2011-09-26"
# end <- "2014-11-08"
# data_hk_3818 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# Tedd: ruan this block for only once, and then comment them out. end

# Tedd: Run the code below before market is open.
# Tedd: generate yestoday's quote. Note: cannot get today's data from yahoo.
tckr <- "3818.hk"
data_hk_3818_rbind <- getSymbols(tckr, from = Sys.Date()-1, auto.assign = FALSE)
data_hk_3818 <- rbind(data_hk_3818, data_hk_3818_rbind)

#  search()
data_hk_3818[,6]
data_hk_3818.cl <- data_hk_3818[,6]  
data_hk_3818.H <- data_hk_3818[,2]  
data_hk_3818.L <- data_hk_3818[,3]  

# Generate DonchianChannel object  
# ?DonchianChannel


dc <- DonchianChannel(cbind(data_hk_3818.H,data_hk_3818.L),n=10)

###################################################

# Create the long (up) and short (dn) signals

sigup <-ifelse(data_hk_3818.cl > dc[,2],1,0)
sigdn <-ifelse(data_hk_3818.cl < dc[,2],-1,0)

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

ret <- ROC(data_hk_3818[,6])
ret[1] <- 0

# Calculate equity curves

eq_up <- cumprod(1+ret*sigup)
eq_dn <- cumprod(1+ret*sigdn)
eq_all <- cumprod(1+ret*sig)

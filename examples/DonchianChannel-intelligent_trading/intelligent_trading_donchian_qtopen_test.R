# http://intelligenttradingtech.blogspot.hk/2010/03/modified-dochian-band-trend-follower.html

  library(quantmod)
  library(TTR)
  
# Set up symbol, start date, and end date.
  
  tckr <- "QQQ"
  start <- "2011-01-01"
  end <- "2014-10-28"

# Write a function to get data
  
  getDataYahoo <- function(symbol, startDate, endDate) {
    tckr <- symbol
    start <- startDate
    end <- endDate    
    getSymbols(tckr,from=start,to=end)
  }

  getDataYahoo <- getDataYahoo(tckr,start,end)
# Pull tckr index data from Yahoo! Finance
  
  getSymbols(tckr,from=start,to=end)  
  tckr_obj <- QQQ  
  QQQ.cl <- QQQ[,6]  
  QQQ.H <- QQQ[,2]  
  QQQ.L <- QQQ[,3]  

# Generate DonchianChannel object  

  dc <- DonchianChannel(cbind(QQQ.H,QQQ.L),n=80)

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

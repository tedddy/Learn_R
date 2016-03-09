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


iclose5 <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` =",idi," ORDER BY `dt` DESC LIMIT 500;"))
    
    rownames(data) <- as.POSIXct(data[,1])
    
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    macd_close<-merge(Cl(data), MACD(Cl(data), 8, 17, 9, "EMA", FALSE))
    
    macd_close$macdOsc <- macd_close$macd - macd_close$signal
    
    macd_close <-cbind(idi, macd_close, diff(macd_close$close), diff(macd_close$macdOsc)) 
    
    macd_close <- setNames(macd_close, c("idi", "close", "macd_cl", "signal_cl", "macdOsc_cl", "close_d1", "macdOsc_cl_d1"))
    
    macd_close <- tail(macd_close,n=488L)
    
    return(macd_close)
}

m5_399006 <- iclose5('399006')

period.min(m5_399006$close,c(0,96))

which.min(m5_399006$close)

m5_399006_min <- m5_399006[which.min(m5_399006$close)]
m5_399006_max <- m5_399006[which.max(m5_399006$close)]
min_max <- rbind(m5_399006_min, m5_399006_max)

diff(rbind (tail(m5_399006,n=1L),m5_399006_min)$close)
diff(rbind (tail(m5_399006,n=1L),m5_399006_min)$macd_cl)

tail(cbind(diff(rbind (tail(m5_399006,n=1L),m5_399006_min)$close),diff(rbind (tail(m5_399006,n=1L),m5_399006_min)$macd_cl)),n=1L)

diff(rbind (tail(m5_399006,n=1L),m5_399006_max)$close)
diff(rbind (tail(m5_399006,n=1L),m5_399006_max)$macd_cl)

tail(cbind(diff(rbind (tail(m5_399006,n=1L),m5_399006_max)$close),diff(rbind (tail(m5_399006,n=1L),m5_399006_max)$macd_cl)),n=1L)

# min_max <- min_max[order.by = rownames] # order data
rbind(m5_399006_max, m5_399006_min)$close


m5_399006[which.min(m5_399006$close)]$close

Cl(m5_399006[which.min(m5_399006$close)])

View(m5_399006)

m5_399006 <- tail(m5_399006,n=24L)

runMin(m5_399006$close, n = 10, cumulative = FALSE)

View(tail(m5_399006,n=24L))

iclose30 <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, close, amount FROM ying_calc.view_i_rt_hst_30 where `idi` =",idi," ORDER BY `dt` DESC LIMIT 500;"))
    
    rownames(data) <- as.POSIXct(data[,1])
    
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    macd_close<-merge(Cl(data), MACD(Cl(data), 8, 17, 9, "EMA", FALSE))
    
    macd_close$macdOsc <- macd_close$macd - macd_close$signal
    
    macd_close <-cbind(macd_close, diff(macd_close$close), diff(macd_close$macdOsc)) 
    
    macd_close <- setNames(macd_close, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1"))
    
    return(macd_close)
}


iclose60 <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, close, amount FROM ying_calc.view_i_rt_hst_60 where `idi` =",idi," ORDER BY `dt` DESC LIMIT 500;"))
    
    rownames(data) <- as.POSIXct(data[,1])
    
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    macd_close<-merge(Cl(data), MACD(Cl(data), 8, 17, 9, "EMA", FALSE))
    
    macd_close$macdOsc <- macd_close$macd - macd_close$signal
    
    macd_close <-cbind(macd_close, diff(macd_close$close), diff(macd_close$macdOsc)) 
    
    macd_close <- setNames(macd_close, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1"))
    
    return(macd_close)
}

fgfclose5 <- iclose5('399974')

View(tail(fgfclose5, n=20L))

fjrclose30 <- iclose30('399974')

View(tail(fjrclose30, n=20L))


fjrclose60 <- iclose60('399974')

View(tail(fjrclose60, n=20L))

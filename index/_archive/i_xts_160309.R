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

# function to calculate macd for close 

i_xts <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, close, volume, amount FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT 500;"))
    
    rownames(data) <- as.POSIXct(data[,1])
    
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    macd_close<-merge(Cl(data), MACD(Cl(data), 8, 17, 9, "EMA", FALSE))
    
    macd_close$macdOsc <- macd_close$macd - macd_close$signal
    
    macd_close <-cbind(macd_close, diff(macd_close$close), diff(macd_close$macdOsc)) 
    
    macd_close <- setNames(macd_close, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1"))
    
    return(macd_close)
}

macd_close <- i_xts('399934')

# function to 1. calculate macd for close and amount; 2. import into database 

i_xts_import <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT 99;"))
    
    rownames(data) <- as.POSIXct(data[,1])
    
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    macd_close <- merge(Cl(data), MACD(Cl(data), 11, 26, 9, "EMA", percent = TRUE))
    
    macd_close$macdOsc <- macd_close$macd - macd_close$signal
    
    macd_amount <- merge(data[,3], MACD(data[,3], 11, 26, 9, "EMA", percent = TRUE))
    
    macd_amount$macdOsc <- macd_amount$macd - macd_amount$signal
    
    macd <-cbind(macd_close, diff(macd_close$close), diff(macd_close$macdOsc), macd_amount, diff(macd_amount$amount), diff(macd_amount$macdOsc)) 
    
    macd <- setNames(macd, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1","amount","macd_amount","signal_amount","macdOsc_amount","amount_d1","macdOsc_amount_d1"))
    
    macd_data.frame <- data.frame(idi, dt=index(macd), value=coredata(macd))
    
    dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
    
    dbWriteTable(dbh, 'temp_i_macd', macd_data.frame, row.names = FALSE, overwrite = TRUE)
    
    dbSendQuery(dbh,'call ying_calc.i_macd_import();')
    
    temp_close <- as.numeric(unclass(tail(macd, n=1)$close[1])) # the last close
    
    macd$close = macd$close - temp_close
    
    temp_macd_cl <- as.numeric(unclass(tail(macd, n=1)$macd_cl[1])) # the last macd_close
    
    macd$macd_cl = macd$macd_cl - temp_macd_cl
    
    temp_amount <- as.numeric(unclass(tail(macd, n=1)$amount[1])) # the last amount
    
    macd$amount = macd$amount - temp_amount
    
    temp_macd_amount <- as.numeric(unclass(tail(macd, n=1)$macd_amount[1])) # the last macd_amount
    
    macd$macd_amount = macd$macd_amount - temp_macd_amount
    
    bl <- macd$close * macd$macd_cl
    
    macd <-cbind(macd, bl) 
    
    macd <- setNames(macd, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1","amount","macd_amount","signal_amount","macdOsc_amount","amount_d1","macdOsc_amount_d1","bl"))
    
    macd_data.frame <- data.frame(idi, dt=index(macd), value=coredata(macd)) # converting a xts to data.frame; add field idi; convert rowname to a field
    
    dbWriteTable(dbh, 'temp_i_macd_bl', macd_data.frame, row.names = FALSE, overwrite = TRUE)
    
    dbSendQuery(dbh,'call ying_calc.i_macd_bl_archive_import();')
    
    macd_data.frame <- tail(macd_data.frame, n=66L)
    
    dbSendQuery(dbh,'call ying_calc.i_macd_bl_import();')
    
    dbDisconnect(dbh)
    
    # return(macd)
}

# run daily begin
i_FJ_info <- sqlQuery("SELECT `idi`, `name_i` FROM ying_calc.i_info WHERE `fFJ`='1';")
dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
dbSendQuery(dbh,'TRUNCATE `ying_calc`.`i_macd_bl`;')
dbDisconnect(dbh)

for (i in i_FJ_info[,1]) {
    macd <- i_xts_import(i)
}
# run daily end
idi <- '399934'
ttrc <- sqlQuery(paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT 500;"))
# converting data.frame to xts
rownames(ttrc) <- as.POSIXct(ttrc[,1])

ttrc <- xts(ttrc[,-1], order.by=as.POSIXct(ttrc[,1]))

macd_close <- merge(Cl(ttrc), MACD(Cl(ttrc), 11, 26, 9, "EMA", percent = FALSE))

macd_close$macdOsc <- macd_close$macd - macd_close$signal


i_xts_import('399934')



# use this function kill all open connections at once
killDbConnections <- function () { 
    all_cons <- dbListConnections(MySQL()) 
    print(all_cons) 
    for(con in all_cons) dbDisconnect(con) 
    print(paste(length(all_cons), " connections killed.")) 
}

killDbConnections()

# outdated version
# data_hs000300_day <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_xts where `idi` = '000300' ORDER BY `dt` DESC LIMIT 50;") # query database 
# 
# data_hs000300_day <- data_hs000300_day[order(data_hs000300_day$date),] # order data
# 
# rownames(data_hs000300_day) = data_hs000300_day[,1] # change rownames
# 
# data_hs000300_day <- data_hs000300_day[,-1] # delete date column
# 
# data_hs000300_day <- as.xts(data_hs000300_day) # matrix 2 xts
# 
# hs000300_day<-merge(Cl(data_hs000300_day), MACD(Cl(data_hs000300_day), 8, 17, 9, "EMA", FALSE))
# 
# hs000300_day$macdOsc <- hs000300_day$macd - hs000300_day$signal           
# 
# View(tail(hs000300_day, n=20L))
# 
# 
# data_hs000016_day <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_xts where `idi` = '000016' ORDER BY `dt` DESC LIMIT 50;") # query database 5 minutes interval
# 
# data_hs000016_day <- data_hs000016_day[order(data_hs000016_day$date),] # order data
# 
# rownames(data_hs000016_day) = data_hs000016_day[,1] # change rownames
# 
# data_hs000016_day <- data_hs000016_day[,-1] # delete date column
# 
# data_hs000016_day <- as.xts(data_hs000016_day) # matrix 2 xts
# 
# hs000016_day<-merge(Cl(data_hs000016_day), MACD(Cl(data_hs000016_day), 8, 17, 9, "EMA", FALSE))
# 
# hs000016_day$macdOsc <- hs000016_day$macd - hs000016_day$signal           
# 
# View(tail(hs000016_day, n=20L))
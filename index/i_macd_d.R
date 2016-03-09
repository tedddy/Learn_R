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

fun_i_macd_daily <- function (idi, limit = '66') {
    # setup connection to database
    dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
    # make query 
    query <- paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT ", limit, ";") # Note that we use amount as volume in the xts since volume has no much meaning for an index.
    # mysql result
    result <- dbSendQuery(dbh, query)
    # fetch data
    ttrc <- fetch(result, -1)
    # converting ttrc to xts
    rownames(ttrc) <- as.POSIXct(ttrc[,1])
    ttrc <- xts(ttrc[,-1], order.by=as.POSIXct(ttrc[,1]))
    # save ttrc to a file
    # save(ttrc, file= paste("xts", idi, ".rda", sep=""), ascii = FALSE)
    # merge cl and macd for close 
    macd_cl <- merge(Cl(ttrc), MACD(Cl(ttrc), 11, 26, 9, "EMA", percent = TRUE))
    # macd histogram for close
    macd_cl$macdOsc <- macd_cl$macd - macd_cl$signal
    
    macd_cl <- setNames(macd_cl, c("close","macd_cl","signal_cl","mOsc_cl"))
    # merge amount and macd for amount 
    macd_am <- merge(Vo(ttrc), MACD(Vo(ttrc), 11, 26, 9, "EMA", percent = TRUE))
    # macd histogram for amount
    macd_am$mOsc_am <- macd_am$macd - macd_am$signal
    
    macd_am <- setNames(macd_am, c("amount","macd_am","signal_am","mOsc_am"))
    
    # first difference for close: diff(macd_cl$close); first difference for close Oscillator: diff(macd_cl$mOsc_cl); first difference for amount: diff(macd_am$amount); first difference for close Oscillator: diff(macd_am$mOsc_am)
    
    # merge 
    macd <-cbind(macd_cl, diff(macd_cl$close), diff(macd_cl$mOsc_cl), macd_am, diff(macd_am$amount), diff(macd_am$mOsc_am)) 
    # macd BeiLi for close
    macd$bl_cl <- (100*(macd$close - as.numeric(unclass(tail(macd, n=1)$close[1])))/as.numeric(unclass(tail(macd, n=1)$close[1]))) * (macd$macd_cl - as.numeric(unclass(tail(macd, n=1)$macd_cl[1])))
    # macd BeiLi for close
    macd$bl_am <- (100*(macd$amount - as.numeric(unclass(tail(macd, n=1)$amount[1])))/as.numeric(unclass(tail(macd, n=1)$amount[1]))) * (macd$macd_am - as.numeric(unclass(tail(macd, n=1)$macd_am[1])))
    # rename
    macd <- setNames(macd, c("close","macd_cl","signal_cl","mOsc_cl","close_d1","mOsc_cl_d1","amount","macd_am","signal_am","mOsc_am","amount_d1","mOsc_am_d1", "bl_cl","bl_am"))
    # converting xts to data.frame, since xts cannot be send to database. 
    macd_data.frame <- data.frame(idi, dt=index(macd), value=coredata(macd))
    # write data to a temp table of the database
    dbWriteTable(dbh, 'temp_i_macd', macd_data.frame, row.names = FALSE, overwrite = TRUE)
    # run a procedure to import data from temp table to permanent table.
    dbSendQuery(dbh,'call ying_calc.i_macd_import();')
    # disconnect database
    dbDisconnect(dbh)
}

# fun_i_macd_daily('399934',limit = '9999')

# run daily begin
i_FJ_info <- sqlQuery("SELECT `idi`, `name_i` FROM ying_calc.i_info WHERE `fFJ`='1';")
i_FJ_info$idi

for (idi in i_FJ_info$idi) {
    fun_i_macd_daily(idi,limit = '9999')
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
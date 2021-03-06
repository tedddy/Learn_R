require(quantmod)
require(RMySQL)

fun_s_macd_daily <- function (ids, limit = '66') {    
    # setup connection to database
    dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying", host="192.168.137.172")
    # make query 
    query <- paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying.s_xts_adj where `ids` =",ids," and `dt` <> '0000-00-00' ORDER BY `dt` DESC LIMIT ", limit, ";") # Note that we use amount as volume in the xts since volume has no much meaning for an index.
    # mysql result
    result <- dbSendQuery(dbh, query)
    # fetch data
    ttrc <- fetch(result, -1)
    # converting ttrc to xts
    rownames(ttrc) <- as.POSIXct(ttrc[,1])
    ttrc <- xts(ttrc[,-1], order.by=as.POSIXct(ttrc[,1]))
    # save ttrc to a file
    # save(ttrc, file= paste("xts", ids, ".rda", sep=""), ascii = FALSE)
    # merge cl and macd for close 
    macd_cl <- merge(Cl(ttrc), MACD(Cl(ttrc), 11, 26, 9, "EMA", percent = TRUE))
    # change names of fields
    macd_cl <- setNames(macd_cl, c("close","macd_cl","signal_cl"))
    # macd histogram for close
    macd_cl$mOsc_cl <- macd_cl$macd_cl - macd_cl$signal_cl
    # first difference for close
    macd_cl$close_d1 <- diff(macd_cl$close)
    # SD/close for close Oscillator
    macd_cl$close_SD_relative <- runSD(macd_cl$close, n = 10, sample = TRUE, cumulative = FALSE)/macd_cl$close
    # first difference for close Oscillator
    macd_cl$mOsc_cl_d1 <- diff(macd_cl$mOsc_cl)
    # EMA of first difference for close Oscillator
    macd_cl$mOsc_cl_d1_EMA <- EMA(diff(macd_cl$mOsc_cl),10)
    # second difference for close Oscillator
    macd_cl$mOsc_cl_d2 <- diff(macd_cl$mOsc_cl, differences = 2)
    # EMA of first difference for close Oscillator
    macd_cl$mOsc_cl_d2_EMA <- EMA(diff(macd_cl$mOsc_cl),10)
    # merge amount and macd for amount 
    macd_am <- merge(Vo(ttrc), MACD(Vo(ttrc), 11, 26, 9, "EMA", percent = TRUE))
    # change names of fields
    macd_am <- setNames(macd_am, c("amount","macd_am","signal_am"))
    # macd histogram for amount
    macd_am$mOsc_am <- macd_am$macd_am - macd_am$signal_am
    #  first difference for amount
    macd_am$amount_d1 <- diff(macd_am$amount)
    # SD/amount for amount Oscillator
    macd_am$amount_SD_relative <- runSD(macd_am$amount, n = 10, sample = TRUE, cumulative = FALSE)/macd_am$amount
    # first difference for amount Oscillator
    macd_am$mOsc_am_d1 <- diff(macd_am$mOsc_am)
    # EMA of first difference for am Oscillator
    macd_am$mOsc_am_d1_EMA <- EMA(diff(macd_am$mOsc_am),5)
    # second difference for am Oscillator
    macd_am$mOsc_am_d2 <- diff(macd_am$mOsc_am, differences = 2)
    # EMA of first difference for am Oscillator
    macd_am$mOsc_am_d2_EMA <- EMA(diff(macd_am$mOsc_am),5)
    # merge 
    macd <-cbind(macd_cl, macd_am) 
    # macd BeiLi for close: percent change of macd$close * percent change of macd$macd_cl
    macd$bl_cl <- (100*(macd$close - as.numeric(unclass(tail(macd, n=1)$close[1])))/as.numeric(unclass(tail(macd, n=1)$close[1]))) * (macd$macd_cl - as.numeric(unclass(tail(macd, n=1)$macd_cl[1])))
    # macd BeiLi for amount: percent change of macd$amount * percent change of macd$macd_am
    macd$bl_am <- (100*(macd$amount - as.numeric(unclass(tail(macd, n=1)$amount[1])))/as.numeric(unclass(tail(macd, n=1)$amount[1]))) * (macd$macd_am - as.numeric(unclass(tail(macd, n=1)$macd_am[1])))
    # rename
    # macd <- setNames(macd, c("close","macd_cl","signal_cl","mOsc_cl","close_d1","mOsc_cl_d1","amount","macd_am","signal_am","mOsc_am","amount_d1","mOsc_am_d1", "bl_cl","bl_am"))
    # converting xts to data.frame, since xts cannot be send to database. 
    macd_data.frame <- data.frame(ids, dt=index(macd), value=coredata(macd))
    # write data to a temp table of the database
    dbWriteTable(dbh, 'temp_s_macd', macd_data.frame, row.names = FALSE, overwrite = TRUE)
    # run a procedure to import data from temp table to permanent table.
    dbSendQuery(dbh,'call ying.s_macd_import();')
    # disconnect database
    dbDisconnect(dbh)
    
}

# fun_s_macd_daily('601318',limit = '66')
# 
# fun_s_macd_daily('601318')
# 
# 
# # e start
# 
#     ids <- '601318'
#     limit <- '9999'
#     
    

# version 01 2016-03-08

#     fun_i_macd_daily <- function (ids, limit = '66') {
#     # setup connection to database
#     dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying", host="192.168.137.172")
#     # make query 
#     query <- paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying.s_xts_adj where `ids` =",ids," ORDER BY `dt` DESC LIMIT ", limit, ";") # Note that we use amount as volume in the xts since volume has no much meaning for an index.
#     # mysql result
#     result <- dbSendQuery(dbh, query)
#     # fetch data
#     ttrc <- fetch(result, -1)
#     # converting ttrc to xts
#     rownames(ttrc) <- as.POSIXct(ttrc[,1])
#     ttrc <- xts(ttrc[,-1], order.by=as.POSIXct(ttrc[,1]))
#     # save ttrc to a file
#     # save(ttrc, file= paste("xts", ids, ".rda", sep=""), ascii = FALSE)
#     # merge cl and macd for close 
#     macd_cl <- merge(Cl(ttrc), MACD(Cl(ttrc), 11, 26, 9, "EMA", percent = TRUE))
#     # macd histogram for close
#     macd_cl$macdOsc <- macd_cl$macd - macd_cl$signal
#     
#     macd_cl <- setNames(macd_cl, c("close","macd_cl","signal_cl","mOsc_cl"))
#     # merge amount and macd for amount 
#     macd_am <- merge(Vo(ttrc), MACD(Vo(ttrc), 11, 26, 9, "EMA", percent = TRUE))
#     # macd histogram for amount
#     macd_am$mOsc_am <- macd_am$macd - macd_am$signal
#     
#     macd_am <- setNames(macd_am, c("amount","macd_am","signal_am","mOsc_am"))
#     
#     # first difference for close: diff(macd_cl$close); first difference for close Oscillator: diff(macd_cl$mOsc_cl); first difference for amount: diff(macd_am$amount); first difference for close Oscillator: diff(macd_am$mOsc_am)
#     
#     # merge 
#     macd <-cbind(macd_cl, diff(macd_cl$close), diff(macd_cl$mOsc_cl), macd_am, diff(macd_am$amount), diff(macd_am$mOsc_am)) 
#     # macd BeiLi for close
#     macd$bl_cl <- (100*(macd$close - as.numeric(unclass(tail(macd, n=1)$close[1])))/as.numeric(unclass(tail(macd, n=1)$close[1]))) * (macd$macd_cl - as.numeric(unclass(tail(macd, n=1)$macd_cl[1])))
#     # macd BeiLi for close
#     macd$bl_am <- (100*(macd$amount - as.numeric(unclass(tail(macd, n=1)$amount[1])))/as.numeric(unclass(tail(macd, n=1)$amount[1]))) * (macd$macd_am - as.numeric(unclass(tail(macd, n=1)$macd_am[1])))
#     # rename
#     macd <- setNames(macd, c("close","macd_cl","signal_cl","mOsc_cl","close_d1","mOsc_cl_d1","amount","macd_am","signal_am","mOsc_am","amount_d1","mOsc_am_d1", "bl_cl","bl_am"))
#     # converting xts to data.frame, since xts cannot be send to database. 
#     macd_data.frame <- data.frame(ids, dt=index(macd), value=coredata(macd))
#     # write data to a temp table of the database
#     dbWriteTable(dbh, 'temp_i_macd', macd_data.frame, row.names = FALSE, overwrite = TRUE)
#     # run a procedure to import data from temp table to permanent table.
#     dbSendQuery(dbh,'call ying.i_macd_import();')
#     # disconnect database
#     dbDisconnect(dbh)
# }




require(quantmod)
require(RMySQL)

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
    save(ttrc, file= paste("xts", idi, ".rda", sep=""), ascii = FALSE)
    # merge cl and macd for close 
    macd_cl <- merge(Cl(ttrc), MACD(Cl(ttrc), 11, 26, 9, "EMA", percent = TRUE))
    # change names of fields
    macd_cl <- setNames(macd_cl, c("close","macd_cl","signal_cl"))
    # macd histogram for close
    macd_cl$mOsc_cl <- macd_cl$macd_cl - macd_cl$signal_cl
    # first difference for close
    macd_cl$close_d1 <- diff(macd_cl$close)
    # first difference for close Oscillator
    macd_cl$mOsc_cl_d1 <- diff(macd_cl$mOsc_cl)
    # EMA of first difference for close Oscillator
    macd_cl$mOsc_cl_d1_EMA <- EMA(diff(macd_cl$mOsc_cl),5)
    # second difference for close Oscillator
    macd_cl$mOsc_cl_d2 <- diff(macd_cl$mOsc_cl, differences = 2)
    # EMA of first difference for close Oscillator
    macd_cl$mOsc_cl_d2_EMA <- EMA(diff(macd_cl$mOsc_cl),5)
    # merge amount and macd for amount 
    macd_am <- merge(Vo(ttrc), MACD(Vo(ttrc), 11, 26, 9, "EMA", percent = TRUE))
    # change names of fields
    macd_am <- setNames(macd_am, c("amount","macd_am","signal_am"))
    # macd histogram for amount
    macd_am$mOsc_am <- macd_am$macd_am - macd_am$signal_am
    #  first difference for amount
    macd_am$amount_d1 <- diff(macd_am$amount)
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
    macd_data.frame <- data.frame(idi, dt=index(macd), value=coredata(macd))
    # write data to a temp table of the database
    dbWriteTable(dbh, 'temp_i_macd', macd_data.frame, row.names = FALSE, overwrite = TRUE)
    # run a procedure to import data from temp table to permanent table.
    dbSendQuery(dbh,'call ying_calc.i_macd_import();')
    # disconnect database
    dbDisconnect(dbh)
}

fun_i_macd_daily('399934',limit = '9999')

fun_i_macd_daily('399934')

# version 01 2016-03-08

#     fun_i_macd_daily <- function (idi, limit = '66') {
#     # setup connection to database
#     dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
#     # make query 
#     query <- paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT ", limit, ";") # Note that we use amount as volume in the xts since volume has no much meaning for an index.
#     # mysql result
#     result <- dbSendQuery(dbh, query)
#     # fetch data
#     ttrc <- fetch(result, -1)
#     # converting ttrc to xts
#     rownames(ttrc) <- as.POSIXct(ttrc[,1])
#     ttrc <- xts(ttrc[,-1], order.by=as.POSIXct(ttrc[,1]))
#     # save ttrc to a file
#     # save(ttrc, file= paste("xts", idi, ".rda", sep=""), ascii = FALSE)
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
#     macd_data.frame <- data.frame(idi, dt=index(macd), value=coredata(macd))
#     # write data to a temp table of the database
#     dbWriteTable(dbh, 'temp_i_macd', macd_data.frame, row.names = FALSE, overwrite = TRUE)
#     # run a procedure to import data from temp table to permanent table.
#     dbSendQuery(dbh,'call ying_calc.i_macd_import();')
#     # disconnect database
#     dbDisconnect(dbh)
# }



# e start
# 
#     idi <- '399934'
#     limit <- '9999'
#     
#     # setup connection to database
#     dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
#     # make query 
#     query <- paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT ", limit, ";") # Note that we use amount as volume in the xts since volume has no much meaning for an index.
#     # mysql result
#     result <- dbSendQuery(dbh, query)
# 
#     ttrc <- fetch(result, -1)

# ttrc <- sqlQuery(paste("SELECT dt as date, high as High, low as Low, close as Close, amount as Volume FROM ying_calc.index_xts where `idi` =",idi," ORDER BY `dt` DESC LIMIT ", limit, ";")) # Note that we use amount as volume in the xts since volume has no much meaning for an index.

# converting ttrc to xts
#     rownames(ttrc) <- as.POSIXct(ttrc[,1])
#     ttrc <- xts(ttrc[,-1], order.by=as.POSIXct(ttrc[,1]))
#     # save ttrc to a file
#     # save(ttrc, file= paste("xts", idi, ".rda", sep=""), ascii = FALSE)
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

# first difference for close: diff(macd_cl$close); first difference for close Oscillator: diff(macd_cl$mOsc_cl); first difference for amount: diff(macd_am$amount); first difference for close Oscillator: diff(macd_am$mOsc_am)

# merge 
#     macd <-cbind(macd_cl, diff(macd_cl$close), diff(macd_cl$mOsc_cl), macd_am, diff(macd_am$amount), diff(macd_am$mOsc_am)) 
#     # macd BeiLi for close
#     macd$bl_cl <- (100*(macd$close - as.numeric(unclass(tail(macd, n=1)$close[1])))/as.numeric(unclass(tail(macd, n=1)$close[1]))) * (macd$macd_cl - as.numeric(unclass(tail(macd, n=1)$macd_cl[1])))
#     # macd BeiLi for close
#     macd$bl_am <- (100*(macd$amount - as.numeric(unclass(tail(macd, n=1)$amount[1])))/as.numeric(unclass(tail(macd, n=1)$amount[1]))) * (macd$macd_am - as.numeric(unclass(tail(macd, n=1)$macd_am[1])))
#     # rename
#     macd <- setNames(macd, c("close","macd_cl","signal_cl","mOsc_cl","close_d1","mOsc_cl_d1","amount","macd_am","signal_am","mOsc_am","amount_d1","mOsc_am_d1", "bl_cl","bl_am"))
#     # converting xts to data.frame, since xts cannot be send to database. 
#     macd_data.frame <- data.frame(idi, dt=index(macd), value=coredata(macd))
#     # write data to a temp table of the database
#     dbWriteTable(dbh, 'temp_i_macd', macd_data.frame, row.names = FALSE, overwrite = TRUE)
#     # run a procedure to import data from temp table to permanent table.
#     dbSendQuery(dbh,'call ying_calc.i_macd_import();')
#     # disconnect database
#     dbDisconnect(dbh)

# the last close: as.numeric(unclass(tail(macd, n=1)$close[1]))
# the latest close is subtracted from every close.
# 100*(macd$close - as.numeric(unclass(tail(macd, n=1)$close[1])))/as.numeric(unclass(tail(macd, n=1)$close[1]))

# the last macd_cl: as.numeric(unclass(tail(macd, n=1)$macd_cl[1])) 
# the latest macd is subtracted from every macd.
# macd$macd_cl - as.numeric(unclass(tail(macd, n=1)$macd_cl[1])) 

# the last amount: as.numeric(unclass(tail(macd, n=1)$amount[1])) 
# the latest amount is subtracted from every amount.
# 100*(macd$amount - as.numeric(unclass(tail(macd, n=1)$amount[1])))/as.numeric(unclass(tail(macd, n=1)$amount[1]))

# the last macd_am: as.numeric(unclass(tail(macd, n=1)$macd_am[1])) 
# macd$macd_am - as.numeric(unclass(tail(macd, n=1)$macd_am[1]))
# 

# macd <- setNames(macd, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1","amount","macd_am","signal_amount","macdOsc_amount","amount_d1","macdOsc_amount_d1","bl"))
# 
# macd_data.frame <- data.frame(idi, dt=index(macd), value=coredata(macd)) # converting a xts to data.frame; add field idi; convert rowname to a field
# 
# dbWriteTable(dbh, 'temp_i_macd_bl', macd_data.frame, row.names = FALSE, overwrite = TRUE)
# 
# dbSendQuery(dbh,'call ying_calc.i_macd_bl_archive_import();')
# 
# macd_data.frame <- tail(macd_data.frame, n=66L)
# 
# dbSendQuery(dbh,'call ying_calc.i_macd_bl_import();')
# 
# dbDisconnect(dbh)


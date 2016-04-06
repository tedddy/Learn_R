require(quantmod)
require(RMySQL)

sqlQuery <- function (query) {
    DB <- dbConnect(MySQL(), user="gxh", password='locoy', dbname='ying', host='192.168.137.172')
    rs <- dbSendQuery(DB, query)
    # get elements from result sets and convert to dataframe
    result <- fetch(rs, -1)
    # close db connection
    dbDisconnect(DB)
    # return the dataframe
    return(result)
}

iclose5 <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, close, volume, amount FROM ying.index_rt_hst where `idi` =",idi," ORDER BY `dt` DESC LIMIT 300;"))
    
    rownames(data) <- as.POSIXct(data[,1])
    
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    macd_close<-merge(Cl(data), MACD(Cl(data), 8, 17, 9, "EMA", percent = TRUE))
    
    macd_close$macdOsc <- macd_close$macd - macd_close$signal
    
    macd_close <-cbind(macd_close, diff(macd_close$close), diff(macd_close$macdOsc)) 
    
    macd_close <- setNames(macd_close, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1"))
    
    return(macd_close)
}

iclose30 <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, close, amount FROM ying.view_i_rt_hst_30 where `idi` =",idi," ORDER BY `dt` DESC LIMIT 200;"))
    
    rownames(data) <- as.POSIXct(data[,1])
    
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    macd_close<-merge(Cl(data), MACD(Cl(data), 8, 17, 9, "EMA", percent = TRUE))
    
    macd_close$macdOsc <- macd_close$macd - macd_close$signal
    
    macd_close <-cbind(macd_close, diff(macd_close$close), diff(macd_close$macdOsc)) 
    
    macd_close <- setNames(macd_close, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1"))
    
    return(macd_close)
}

iclose60 <- function (idi) {
    data <- sqlQuery(paste("SELECT dt as date, close, amount FROM ying.view_i_rt_hst_60 where `idi` =",idi," ORDER BY `dt` DESC LIMIT 200;"))
    
    rownames(data) <- as.POSIXct(data[,1])
    
    data <- xts(data[,-1], order.by=as.POSIXct(data[,1]))
    
    macd_close<-merge(Cl(data), MACD(Cl(data), 8, 17, 9, "EMA", percent = TRUE))
    
    macd_close$macdOsc <- macd_close$macd - macd_close$signal
    
    macd_close <-cbind(macd_close, diff(macd_close$close), diff(macd_close$macdOsc)) 
    
    macd_close <- setNames(macd_close, c("close","macd_cl","signal_cl","macdOsc_cl","close_d1","macdOsc_cl_d1"))
    
    return(macd_close)
}

# i_FJ_info <- sqlQuery("SELECT `idi`, `name_i` FROM ying_calc.i_info WHERE `fFJ`='1';")
# 
# View(i_FJ_info)
# 
# i_FJ_info[,1]

# for(i in seq_along(i_FJ_info[,1])) { out[i] <- iclose5(i) } doesn't work

# 5分钟 数据

# watch_idi_5 <- c("399006", "399934", "399959","399974",	"399393","399975")

# for (i in watch_idi_5) {
#     m5 <- iclose5(i) 
#     save(m5, file= paste(m5, "i.rda", sep="_"), ascii = FALSE) 
# }
# 
# buildm5 <- function(idi) {
#     m5 <- iclose5(idi) 
#     save(m5, file= paste("m", idi, "5.rda", sep="_"), ascii = FALSE)
# }
# 
# lapply(watch_idi_5,buildm5)
# 
# iclose5("399006") 
# m5 <- iclose5("399006") 
# save(xts=m5, file= "m5.rda", ascii = FALSE)


# buildhist <- function(x,start,end) {
#     getSymbols(x, from=start, to=end, adjust=TRUE)
#     X <- toupper(gsub("\\^","",x))  # what getSymbols.yahoo does
#     save(list=X, file= paste(X, "hist.rda", sep="_"), ascii = FALSE)  
# }
# 
# require(quantmod)
# tckr <- c("^GSPC","YHOO","XLB")
# lapply(tckr,buildhist,start="1995-01-01",end="2011-11-30")

# 中证金融
m5_399934 <- iclose5('399934')
View(tail(m5_399934,n=24L))
m30_399934 <- iclose30('399934')
View(tail(m30_399934,n=24L))
m60_399934 <- iclose60('399934')
View(tail(m60_399934,n=24L))
#View(tail(m5_399934,n=500L))
#View(tail(m30_399934,n=500L))
#View(tail(m60_399934,n=500L))

# 军工指数
m5_399959 <- iclose5('399959')
m30_399959 <- iclose30('399959')
m60_399959 <- iclose60('399959')
View(tail(m5_399959,n=24L))
View(tail(m30_399959,n=24L))
View(tail(m60_399959,n=24L))
#View(tail(m5_399959,n=500L))
#View(tail(m30_399959,n=500L))
#View(tail(m60_399959,n=500L))
#str(m30_399959)

# 国证食品指数
m5_399396 <- iclose5('399396')
m30_399396 <- iclose30('399396')
m60_399396 <- iclose60('399396')
View(tail(m5_399396,n=24L))
View(tail(m30_399396,n=24L))
View(tail(m60_399396,n=24L))
View(m60_399396)

# 创业板指数
m5_399006 <- iclose5('399006')
View(tail(m5_399006,n=24L))
m30_399006 <- iclose30('399006')
View(tail(m30_399006,n=24L))
m60_399006 <- iclose60('399006')
View(tail(m60_399006,n=24L))

# 地产指数
m5_000006 <- iclose5('000006')
View(tail(m5_000006,n=24L))
m30_000006 <- iclose30('000006')
View(tail(m30_000006,n=24L))
m60_000006 <- iclose60('000006')
View(tail(m60_000006,n=24L))


# 国证医药指数
m5_399394 <- iclose5('399394')
View(tail(m5_399394,n=24L))
m30_399394 <- iclose30('399394')
View(tail(m30_399394,n=24L))
m60_399394 <- iclose60('399394')
View(tail(m60_399394,n=24L))

# 国企改革 399974
m5_399974 <- iclose5('399974')
m30_399974 <- iclose30('399974')
m60_399974 <- iclose60('399974')
View(tail(m5_399974,n=24L))
View(tail(m30_399974,n=24L))
View(tail(m60_399974,n=24L))
#View(tail(m5_399974,n=500L))
#View(tail(m30_399974,n=500L))
#View(tail(m60_399974,n=500L))
#str(m30_399974)

# 国政地产 399393
m5_399393 <- iclose5('399393')
m30_399393 <- iclose30('399393')
m60_399393 <- iclose60('399393')
View(tail(m5_399393,n=24L))
View(tail(m30_399393,n=24L))
View(tail(m60_399393,n=24L))
#View(tail(m5_399393,n=500L))
#View(tail(m30_399393,n=500L))
#View(tail(m60_399393,n=500L))
#str(m30_399393)

# 证券公司 399975
m5_399975 <- iclose5('399975')
m30_399975 <- iclose30('399975')
m60_399975 <- iclose60('399975')
View(tail(m5_399975,n=24L))
View(tail(m30_399975,n=24L))
View(tail(m60_399975,n=24L))
#View(tail(m5_399975,n=500L))
#View(tail(m30_399975,n=500L))
#View(tail(m60_399975,n=500L))
#str(m30_399975)




# 中证金融
m5_399934 <- iclose5('399934')
m30_399934 <- iclose30('399934')
#str(m30_399934)
m60_399934 <- iclose60('399934')
View(tail(m5_399934,n=24L))
#View(tail(m5_399934,n=500L))
View(tail(m30_399934,n=24L))
#View(tail(m30_399934,n=500L))
View(tail(m60_399934,n=24L))
#View(tail(m60_399934,n=500L))

# 军工指数
m5_399959 <- iclose5('399959')
m30_399959 <- iclose30('399959')
m60_399959 <- iclose60('399959')
View(tail(m5_399959,n=24L))
View(tail(m30_399959,n=24L))
View(tail(m60_399959,n=24L))
#View(tail(m5_399959,n=500L))
#View(tail(m30_399959,n=500L))
#View(tail(m60_399959,n=500L))
#str(m30_399959)

# 国企改革 399974
m5_399974 <- iclose5('399974')
m30_399974 <- iclose30('399974')
m60_399974 <- iclose60('399974')
View(tail(m5_399974,n=24L))
View(tail(m30_399974,n=24L))
View(tail(m60_399974,n=24L))
#View(tail(m5_399974,n=500L))
#View(tail(m30_399974,n=500L))
#View(tail(m60_399974,n=500L))
#str(m30_399974)

# 国政地产 399393
m5_399393 <- iclose5('399393')
m30_399393 <- iclose30('399393')
m60_399393 <- iclose60('399393')
View(tail(m5_399393,n=24L))
View(tail(m30_399393,n=24L))
View(tail(m60_399393,n=24L))
#View(tail(m5_399393,n=500L))
#View(tail(m30_399393,n=500L))
#View(tail(m60_399393,n=500L))
#str(m30_399393)

# 证券公司 399975
m5_399975 <- iclose5('399975')
m30_399975 <- iclose30('399975')
m60_399975 <- iclose60('399975')
View(tail(m5_399975,n=24L))
View(tail(m30_399975,n=24L))
View(tail(m60_399975,n=24L))
#View(tail(m5_399975,n=500L))
#View(tail(m30_399975,n=500L))
#View(tail(m60_399975,n=500L))
#str(m30_399975)

# 创业板指数
m5_399006 <- iclose5('399006')
m30_399006 <- iclose30('399006')
m60_399006 <- iclose60('399006')
View(tail(m5_399006,n=24L))
View(tail(m30_399006,n=24L))
View(tail(m60_399006,n=24L))
View(m60_399006)


# 中证金融
m5_399934 <- iclose5('399934')
m30_399934 <- iclose30('399934')
#str(m30_399934)
m60_399934 <- iclose60('399934')
View(tail(m5_399934,n=24L))
#View(tail(m5_399934,n=500L))
View(tail(m30_399934,n=24L))
#View(tail(m30_399934,n=500L))
View(tail(m60_399934,n=24L))
#View(tail(m60_399934,n=500L))

# 军工指数
m5_399959 <- iclose5('399959')
m30_399959 <- iclose30('399959')
m60_399959 <- iclose60('399959')
View(tail(m5_399959,n=24L))
View(tail(m30_399959,n=24L))
View(tail(m60_399959,n=24L))
#View(tail(m5_399959,n=500L))
#View(tail(m30_399959,n=500L))
#View(tail(m60_399959,n=500L))
#str(m30_399959)

# 国企改革 399974
m5_399974 <- iclose5('399974')
m30_399974 <- iclose30('399974')
m60_399974 <- iclose60('399974')
View(tail(m5_399974,n=24L))
View(tail(m30_399974,n=24L))
View(tail(m60_399974,n=24L))
#View(tail(m5_399974,n=500L))
#View(tail(m30_399974,n=500L))
#View(tail(m60_399974,n=500L))
#str(m30_399974)

# 国政地产 399393
m5_399393 <- iclose5('399393')
m30_399393 <- iclose30('399393')
m60_399393 <- iclose60('399393')
View(tail(m5_399393,n=24L))
View(tail(m30_399393,n=24L))
View(tail(m60_399393,n=24L))
#View(tail(m5_399393,n=500L))
#View(tail(m30_399393,n=500L))
#View(tail(m60_399393,n=500L))
#str(m30_399393)

# 证券公司 399975
m5_399975 <- iclose5('399975')
m30_399975 <- iclose30('399975')
m60_399975 <- iclose60('399975')
View(tail(m5_399975,n=24L))
View(tail(m30_399975,n=24L))
View(tail(m60_399975,n=24L))
#View(tail(m5_399975,n=500L))
#View(tail(m30_399975,n=500L))
#View(tail(m60_399975,n=500L))
#str(m30_399975)

# expriment begin

# m30_399934[m30_399934$macd_cl<0.2 & m30_399934$macd_cl>-0.2]
# 
# m30_399934[m30_399934$macdOsc_cl_d1<0.1 & m30_399934$macdOsc_cl_d1>-0.1]
# 
# m30_399934 <- tail(m30_399934,n=200L)
# rbind(m30_399934[which.max(m30_399934$close)], m30_399934[which.min(m30_399934$close)])
# period.max(m30_399934$close,c(0,which.min(m30_399934$close),nrow(m30_399934)))
# 
# period.max(m30_399934$close,c(0,which.min(m30_399934$close),nrow(m30_399934)))[,1]
# 
# m30_399934[m30_399934$close == 5145.66]
# 
# m30_399934[m30_399934$close == 4723.70]
# 
# View(tail(m30_399934,n=500L))
# 
# which.min(m30_399934$close)
# which.max(m30_399934$close)
# nrow(m30_399934)
# 
# rbind(m30_399934[which.max(m30_399934$close)], m30_399934[which.min(m30_399934$close)])
# 
# period.min(m30_399934$close,c(0,which.max(m30_399934$close),nrow(m30_399934)))
# 
# diff()

# expriment end

# 
# fgfclose5 <- iclose5('399974')
# 
# View(tail(fgfclose5, n=20L))
# 
# 
# fjrclose5 <- iclose5('399974')
# 
# View(tail(fjrclose5, n=20L))
# 
# 
# fjrclose30 <- iclose30('399974')
# 
# View(tail(fjrclose30, n=20L))
# 
# # query database 30 minutes interval
# 
# data_fg_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '399974' order by dt desc;")
# 
# data_fg_30 <- data_fg_30[order(data_fg_30$date),] # order data
# 
# rownames(data_fg_30) = data_fg_30[,1] # change rownames
# 
# data_fg_30 <- data_fg_30[,-1] # delete date column
# 
# data_fg_30 <- as.xts(data_fg_30) # matrix 2 xts
# 
# fg_30<-merge(Cl(data_fg_30), MACD(Cl(data_fg_30), 8, 17, 9, "EMA", FALSE))
# 
# fg_30$macdOsc <- fg_30$macd - fg_30$signal  
# 
# View(tail(fg_30, n=18L))
# 
# # query database 60 minutes interval
# data_fg_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '399974' order by dt desc;")
# 
# data_fg_60 <- data_fg_60[order(data_fg_60$date),] # order data
# 
# rownames(data_fg_60) = data_fg_60[,1] # change rownames
# 
# data_fg_60 <- data_fg_60[,-1] # delete date column
# 
# data_fg_60 <- as.xts(data_fg_60) # matrix 2 xts
# 
# fg_60<-merge(Cl(data_fg_60), MACD(Cl(data_fg_60), 8, 17, 9, "EMA", FALSE))
# 
# fg_60$macdOsc <- fg_60$macd - fg_60$signal   
# 
# View(tail(fg_60, n=18L))
# 
# # 
# 
# data_fz_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000016' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval
# 
# data_fz_5 <- data_fz_5[order(data_fz_5$date),] # order data
# 
# rownames(data_fz_5) = data_fz_5[,1] # change rownames
# 
# data_fz_5 <- data_fz_5[,-1] # delete date column
# 
# data_fz_5 <- as.xts(data_fz_5) # matrix 2 xts
# 
# fz_5<-merge(Cl(data_fz_5), MACD(Cl(data_fz_5), 8, 17, 9, "EMA", FALSE))
# 
# fz_5$macdOsc <- fz_5$macd - fz_5$signal           
# 
# View(tail(fz_5, n=20L))
# 
# # query database 30 minutes interval
# data_fz_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '000016' order by dt desc;")
# 
# data_fz_30 <- data_fz_30[order(data_fz_30$date),] # order data
# 
# rownames(data_fz_30) = data_fz_30[,1] # change rownames
# 
# data_fz_30 <- data_fz_30[,-1] # delete date column
# 
# data_fz_30 <- as.xts(data_fz_30) # matrix 2 xts
# 
# fz_30<-merge(Cl(data_fz_30), MACD(Cl(data_fz_30), 8, 17, 9, "EMA", FALSE))
# 
# fz_30$macdOsc <- fz_30$macd - fz_30$signal   
# 
# View(tail(fz_30, n=18L))
# 
# # query database 60 minutes interval
# data_fz_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '000016' order by dt desc;")
# 
# data_fz_60 <- data_fz_60[order(data_fz_60$date),] # order data
# 
# rownames(data_fz_60) = data_fz_60[,1] # change rownames
# 
# data_fz_60 <- data_fz_60[,-1] # delete date column
# 
# data_fz_60 <- as.xts(data_fz_60) # matrix 2 xts
# 
# fz_60<-merge(Cl(data_fz_60), MACD(Cl(data_fz_60), 8, 17, 9, "EMA", FALSE))
# 
# fz_60$macdOsc <- fz_60$macd - fz_60$signal   
# 
# View(tail(fz_60, n=12L))
# 
# # 399959
# 
# data_fj_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '399959' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval
# 
# data_fj_5 <- data_fj_5[order(data_fj_5$date),] # order data
# 
# rownames(data_fj_5) = data_fj_5[,1] # change rownames
# 
# data_fj_5 <- data_fj_5[,-1] # delete date column
# 
# data_fj_5 <- as.xts(data_fj_5) # matrix 2 xts
# 
# fj_5<-merge(Cl(data_fj_5), MACD(Cl(data_fj_5), 8, 17, 9, "EMA", FALSE))
# 
# fj_5$macdOsc <- fj_5$macd - fj_5$signal           
# 
# View(tail(fj_5, n=20L))
# 
# # query database 30 minutes interval
# data_fj_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '399959' order by dt desc;")
# 
# data_fj_30 <- data_fj_30[order(data_fj_30$date),] # order data
# 
# rownames(data_fj_30) = data_fj_30[,1] # change rownames
# 
# data_fj_30 <- data_fj_30[,-1] # delete date column
# 
# data_fj_30 <- as.xts(data_fj_30) # matrix 2 xts
# 
# fj_30<-merge(Cl(data_fj_30), MACD(Cl(data_fj_30), 8, 17, 9, "EMA", FALSE))
# 
# fj_30$macdOsc <- fj_30$macd - fj_30$signal   
# 
# View(tail(fj_30, n=18L))
# 
# # query database 60 minutes interval
# data_fj_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '399959' order by dt desc;")
# 
# data_fj_60 <- data_fj_60[order(data_fj_60$date),] # order data
# 
# rownames(data_fj_60) = data_fj_60[,1] # change rownames
# 
# data_fj_60 <- data_fj_60[,-1] # delete date column
# 
# data_fj_60 <- as.xts(data_fj_60) # matrix 2 xts
# 
# fj_60<-merge(Cl(data_fj_60), MACD(Cl(data_fj_60), 8, 17, 9, "EMA", FALSE))
# 
# fj_60$macdOsc <- fj_60$macd - fj_60$signal   
# 
# View(tail(fj_60, n=12L))
# 
# # 399393
# 
# data_ff_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '399393' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval
# 
# data_ff_5 <- data_ff_5[order(data_ff_5$date),] # order data
# 
# rownames(data_ff_5) = data_ff_5[,1] # change rownames
# 
# data_ff_5 <- data_ff_5[,-1] # delete date column
# 
# data_ff_5 <- as.xts(data_ff_5) # matrix 2 xts
# 
# ff_5<-merge(Cl(data_ff_5), MACD(Cl(data_ff_5), 8, 17, 9, "EMA", FALSE))
# 
# ff_5$macdOsc <- ff_5$macd - ff_5$signal           
# 
# View(tail(ff_5, n=20L))
# 
# # query database 30 minutes interval
# data_ff_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '399393' order by dt desc;")
# 
# data_ff_30 <- data_ff_30[order(data_ff_30$date),] # order data
# 
# rownames(data_ff_30) = data_ff_30[,1] # change rownames
# 
# data_ff_30 <- data_ff_30[,-1] # delete date column
# 
# data_ff_30 <- as.xts(data_ff_30) # matrix 2 xts
# 
# ff_30<-merge(Cl(data_ff_30), MACD(Cl(data_ff_30), 8, 17, 9, "EMA", FALSE))
# 
# ff_30$macdOsc <- ff_30$macd - ff_30$signal   
# 
# View(tail(ff_30, n=18L))
# 
# # query database 60 minutes interval
# data_ff_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '399393' order by dt desc;")
# 
# data_ff_60 <- data_ff_60[order(data_ff_60$date),] # order data
# 
# rownames(data_ff_60) = data_ff_60[,1] # change rownames
# 
# data_ff_60 <- data_ff_60[,-1] # delete date column
# 
# data_ff_60 <- as.xts(data_ff_60) # matrix 2 xts
# 
# ff_60<-merge(Cl(data_ff_60), MACD(Cl(data_ff_60), 8, 17, 9, "EMA", FALSE))
# 
# ff_60$macdOsc <- ff_60$macd - ff_60$signal   
# 
# View(tail(ff_60, n=12L))
# 

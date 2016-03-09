require(quantmod)  # https://app.yinxiang.com/shard/s22/nl/4928451/cd48717b-a33a-4801-a646-71f25cd95c3f
require(RMySQL)

sqlQuery <- function (query) {
    
    # creating DB connection object with RMysql package
    DB <- dbConnect(MySQL(), user="gxh", password='locoy', dbname='ying_calc', host='192.168.137.172')
    
    # send Query to btain result set
    rs <- dbSendQuery(DB, query)
    
    # get elements from result sets and convert to dataframe
    result <- fetch(rs, -1)
    
    # close db connection
    dbDisconnect(DB)
    
    # return the dataframe
    return(result)
}

# dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")

# dbSendQuery(dbh,'SET NAMES utf8 ')

# res=dbSendQuery(dbh, "select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying_calc`.`s_rt_hst` where ids = '600030' order by `dt` desc limit 98) as a order by a.`dt`;")

# dbDisconnect(dbh)

data_fz_5 <- sqlQuery("SELECT dt as date, close, volume, amount FROM ying_calc.index_rt_hst where `idi` = '000016' ORDER BY `dt` DESC LIMIT 500;") # query database 5 minutes interval

data_fz_5 <- data_fz_5[order(data_fz_5$date),] # order data

rownames(data_fz_5) = data_fz_5[,1] # change rownames

data_fz_5 <- data_fz_5[,-1] # delete date column

data_fz_5 <- as.xts(data_fz_5) # matrix 2 xts

fz_5<-merge(Cl(data_fz_5), MACD(Cl(data_fz_5), 8, 17, 9, "EMA", FALSE))

fz_5$macdOsc <- fz_5$macd - fz_5$signal           

View(tail(fz_5, n=20L))

# query database 30 minutes interval
data_fz_30 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_30 where `idi` = '000016' order by dt desc;")

data_fz_30 <- data_fz_30[order(data_fz_30$date),] # order data

rownames(data_fz_30) = data_fz_30[,1] # change rownames

data_fz_30 <- data_fz_30[,-1] # delete date column

data_fz_30 <- as.xts(data_fz_30) # matrix 2 xts

fz_30<-merge(Cl(data_fz_30), MACD(Cl(data_fz_30), 8, 17, 9, "EMA", FALSE))

fz_30$macdOsc <- fz_30$macd - fz_30$signal   

View(tail(fz_30, n=18L))

# query database 60 minutes interval
data_fz_60 <- sqlQuery("SELECT dt as date, idi, close  FROM ying_calc.view_i_rt_hst_60 where `idi` = '000016' order by dt desc;")

data_fz_60 <- data_fz_60[order(data_fz_60$date),] # order data

rownames(data_fz_60) = data_fz_60[,1] # change rownames

data_fz_60 <- data_fz_60[,-1] # delete date column

data_fz_60 <- as.xts(data_fz_60) # matrix 2 xts

fz_60<-merge(Cl(data_fz_60), MACD(Cl(data_fz_60), 8, 17, 9, "EMA", FALSE))

fz_60$macdOsc <- fz_60$macd - fz_60$signal   

View(tail(fz_60, n=12L))

data_600030 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying_calc`.`s_rt_hst` where ids = '600030' order by `dt` desc limit 98) as a order by a.`dt`;")

rownames(data_600030) = data_600030[,1]

data_xts_temp <- data_600030[,-1]

data_xts_600030 <- as.xts(data_xts_temp) # https://app.yinxiang.com/shard/s22/nl/4928451/6eb45b4d-bb5e-4e29-a2cc-6f5379b00f2e

hs600030<-merge(Cl(data_xts_600030), MACD(Cl(data_xts_600030), 8, 17, 9, "EMA", FALSE))

hs600030$macdOsc <- hs600030$macd - hs600030$signal           

View(tail(hs600030, n=20L))

# beginning of 600030
data_600030 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying_calc`.`s_rt_hst` where ids = '600030' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_600030) = data_600030[,1]
data_xts_temp <- data_600030[,-1]
data_xts_600030 <- as.xts(data_xts_temp)
hs600030<-merge(Cl(data_xts_600030), MACD(Cl(data_xts_600030), 8, 17, 9, "EMA", FALSE))
hs600030$macdOsc <- hs600030$macd - hs600030$signal        
View(tail(hs600030, n=20L))
# end of 600030

# beginning of 600837
data_600837 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying_calc`.`s_rt_hst` where ids = '600837' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_600837) = data_600837[,1]
data_xts_temp <- data_600837[,-1]
data_xts_600837 <- as.xts(data_xts_temp)
hs600837<-merge(Cl(data_xts_600837), MACD(Cl(data_xts_600837), 8, 17, 9, "EMA", FALSE))
hs600837$macdOsc <- hs600837$macd - hs600837$signal        
View(tail(hs600837, n=20L))
# end of 600837

# beginning of 601688
data_601688 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying_calc`.`s_rt_hst` where ids = '601688' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_601688) = data_601688[,1]
data_xts_temp <- data_601688[,-1]
data_xts_601688 <- as.xts(data_xts_temp)
hs601688<-merge(Cl(data_xts_601688), MACD(Cl(data_xts_601688), 8, 17, 9, "EMA", FALSE))
hs601688$macdOsc <- hs601688$macd - hs601688$signal        
View(tail(hs601688, n=20L))
# end of 601688

# beginning of 600999
data_600999 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying_calc`.`s_rt_hst` where ids = '600999' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_600999) = data_600999[,1]
data_xts_temp <- data_600999[,-1]
data_xts_600999 <- as.xts(data_xts_temp)
hs600999<-merge(Cl(data_xts_600999), MACD(Cl(data_xts_600999), 8, 17, 9, "EMA", FALSE))
hs600999$macdOsc <- hs600999$macd - hs600999$signal        
View(tail(hs600999, n=20L))
# end of 600999

# beginning of 000776
data_000776 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying_calc`.`s_rt_hst` where ids = '000776' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_000776) = data_000776[,1]
data_xts_temp <- data_000776[,-1]
data_xts_000776 <- as.xts(data_xts_temp)
hs000776<-merge(Cl(data_xts_000776), MACD(Cl(data_xts_000776), 8, 17, 9, "EMA", FALSE))
hs000776$macdOsc <- hs000776$macd - hs000776$signal        
View(tail(hs000776, n=20L))
# end of 000776




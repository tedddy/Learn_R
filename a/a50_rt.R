require(quantmod)  # https://app.yinxiang.com/shard/s22/nl/4928451/cd48717b-a33a-4801-a646-71f25cd95c3f
require(RMySQL)
# getSymbols("IBM", source="google")
#ibm <- merge(Cl(IBM), MACD(Cl(IBM), 8, 17, 9, "EMA", FALSE))
#ibm$macdOsc <- ibm$macd - ibm$signal
#tail(ibm)

sqlQuery <- function (query) {
    
    # creating DB connection object with RMysql package
    DB <- dbConnect(MySQL(), user="gxh", password='locoy', dbname='ying', host='192.168.137.172')
    
    # send Query to btain result set
    rs <- dbSendQuery(DB, query)
    
    # get elements from result sets and convert to dataframe
    result <- fetch(rs, -1)
    
    # close db connection
    dbDisconnect(DB)
    
    # return the dataframe
    return(result)
}

# dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying", host="192.168.137.172")

# dbSendQuery(dbh,'SET NAMES utf8 ')

# res=dbSendQuery(dbh, "select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying`.`s_rt_hst` where ids = '601318' order by `dt` desc limit 98) as a order by a.`dt`;")

# dbDisconnect(dbh)

data_601318 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying`.`s_rt_hst` where ids = '601318' order by `dt` desc limit 98) as a order by a.`dt`;")

rownames(data_601318) = data_601318[,1]

data_xts_temp <- data_601318[,-1]

data_xts_601318 <- as.xts(data_xts_temp) # https://app.yinxiang.com/shard/s22/nl/4928451/6eb45b4d-bb5e-4e29-a2cc-6f5379b00f2e

hs601318<-merge(Cl(data_xts_601318), MACD(Cl(data_xts_601318), 8, 17, 9, "EMA", FALSE))

hs601318$macdOsc <- hs601318$macd - hs601318$signal           

View(tail(hs601318, n=20L))

# beginning of 600030
data_600030 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying`.`s_rt_hst` where ids = '600030' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_600030) = data_600030[,1]
data_xts_temp <- data_600030[,-1]
data_xts_600030 <- as.xts(data_xts_temp)
hs600030<-merge(Cl(data_xts_600030), MACD(Cl(data_xts_600030), 8, 17, 9, "EMA", FALSE))
hs600030$macdOsc <- hs600030$macd - hs600030$signal        
View(tail(hs600030, n=20L))
# end of 600030

# beginning of 600036
data_600036 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying`.`s_rt_hst` where ids = '600036' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_600036) = data_600036[,1]
data_xts_temp <- data_600036[,-1]
data_xts_600036 <- as.xts(data_xts_temp)
hs600036<-merge(Cl(data_xts_600036), MACD(Cl(data_xts_600036), 8, 17, 9, "EMA", FALSE))
hs600036$macdOsc <- hs600036$macd - hs600036$signal        
View(tail(hs600036, n=20L))
# end of 600036

# beginning of 600016
data_600016 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying`.`s_rt_hst` where ids = '600016' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_600016) = data_600016[,1]
data_xts_temp <- data_600016[,-1]
data_xts_600016 <- as.xts(data_xts_temp)
hs600016<-merge(Cl(data_xts_600016), MACD(Cl(data_xts_600016), 8, 17, 9, "EMA", FALSE))
hs600016$macdOsc <- hs600016$macd - hs600016$signal        
View(tail(hs600016, n=20L))
# end of 600016

# beginning of 600000
data_600000 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying`.`s_rt_hst` where ids = '600000' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_600000) = data_600000[,1]
data_xts_temp <- data_600000[,-1]
data_xts_600000 <- as.xts(data_xts_temp)
hs600000<-merge(Cl(data_xts_600000), MACD(Cl(data_xts_600000), 8, 17, 9, "EMA", FALSE))
hs600000$macdOsc <- hs600000$macd - hs600000$signal        
View(tail(hs600000), n=20L)
# end of 600000

# beginning of 600016
data_600016 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying`.`s_rt_hst` where ids = '600016' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_600016) = data_600016[,1]
data_xts_temp <- data_600016[,-1]
data_xts_600016 <- as.xts(data_xts_temp)
hs600016<-merge(Cl(data_xts_600016), MACD(Cl(data_xts_600016), 8, 17, 9, "EMA", FALSE))
hs600016$macdOsc <- hs600016$macd - hs600016$signal        
View(tail(hs600016), n=20L)
# end of 600016

# beginning of 000002
data_000002 <- sqlQuery("select a.`dt`, a.`close`, a.`volume`, a.`amount` from (SELECT `dt`, `close`, `volume`, `amount` FROM `ying`.`s_rt_hst` where ids = '000002' order by `dt` desc limit 98) as a order by a.`dt`;")
rownames(data_000002) = data_000002[,1]
data_xts_temp <- data_000002[,-1]
data_xts_000002 <- as.xts(data_xts_temp)
hs000002<-merge(Cl(data_xts_000002), MACD(Cl(data_xts_000002), 8, 17, 9, "EMA", FALSE))
hs000002$macdOsc <- hs000002$macd - hs000002$signal        
View(tail(hs000002), n=20L)
# end of 000002




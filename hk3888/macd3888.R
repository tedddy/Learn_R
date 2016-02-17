require(quantmod)  # https://app.yinxiang.com/shard/s22/nl/4928451/cd48717b-a33a-4801-a646-71f25cd95c3f
require(RMySQL)
# getSymbols("IBM", source="google")
#ibm <- merge(Cl(IBM), MACD(Cl(IBM), 8, 17, 9, "EMA", FALSE))
#ibm$macdOsc <- ibm$macd - ibm$signal
#tail(ibm)

data_imported <- sqlQuery("SELECT `date`, `open`, `high`, `low`, `close`, `volume`, `amount` FROM `ying`.`hk_s_xts` where code = '03888' and datediff(curdate(), `date`) < 88 order by date;")

data_imported[,1]

rownames(data_imported) = data_imported[,1]

data_xts_pre <- data_imported[,-1]
data_xts <- as.xts(data_xts_pre) # https://app.yinxiang.com/shard/s22/nl/4928451/6eb45b4d-bb5e-4e29-a2cc-6f5379b00f2e

Cl(data_xts)

head(data_xts)

data_xts[,1]

MACD(Cl(data_xts), 8, 17, 9, "EMA", FALSE)

hk03888<-merge(Cl(data_xts), MACD(Cl(data_xts), 8, 17, 9, "EMA", FALSE))

hk03888$macdOsc <- hk03888$macd - hk03888$signal           

tail(hk03888)

data_imported =fetch(res)

data_imported[,1]

rownames(data_imported) = data_imported[,1]

data_xts_pre <- data_imported[,-1]
data_xts <- as.xts(data_xts_pre) # https://app.yinxiang.com/shard/s22/nl/4928451/6eb45b4d-bb5e-4e29-a2cc-6f5379b00f2e

Cl(data_xts)

head(data_xts)

data_xts[,1]

MACD(Cl(data_xts), 8, 17, 9, "EMA", FALSE)

hk03888<-merge(Cl(data_xts), MACD(Cl(data_xts), 8, 17, 9, "EMA", FALSE))

hk03888$macdOsc <- hk03888$macd - hk03888$signal           

tail(hk03888)

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


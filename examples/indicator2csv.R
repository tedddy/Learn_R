# https://app.yinxiang.com/shard/s22/nl/4928451/8c9bd010-3883-42bb-875f-4f815b2f400e
library(quantmod) 
getSymbols("AAPL",src="yahoo") 
d <- cbind( AAPL, MACD( AAPL ) ) 
write.csv( data.frame( date=index(d), coredata(d) ), row.names=FALSE, file="tmp.csv" )
write.zoo( data.frame( date=index(d), coredata(d) ), row.names=FALSE, file="tmp1.csv" )


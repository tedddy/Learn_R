require(RMySQL)
dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying", host="192.168.137.172")
dbSendQuery(dbh,'SET NAMES utf8 ')
dbListTables(dbh)
# dbDisconnect(dbh)
dbGetQuery(dbh, "SELECT * FROM ying.hk_w;")
res=dbSendQuery(dbh, "SELECT * FROM ying.hk_w;")
dat=fetch(res)
dat

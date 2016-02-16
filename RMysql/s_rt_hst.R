require(RMySQL)
dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
dbSendQuery(dbh,'SET NAMES utf8 ')
dbListTables(dbh)
# dbDisconnect(dbh)
dbGetQuery(dbh, "SELECT * FROM ying_calc.s_rt_hst where dt = curdate();")
res-s_rt=dbSendQuery(dbh, "SELECT * FROM ying_calc.s_rt_hst where date(dt) = curdate();")

dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
res=dbSendQuery(dbh, "SELECT close,volume,amount FROM ying_calc.index_rt_hst where date(dt) = curdate() and idi = '000300';")
dat=fetch(res)
dat

install.packages("RCurl")

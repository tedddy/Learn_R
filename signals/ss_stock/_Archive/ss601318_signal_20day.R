# 载入需要的Package
library(quantmod)
require(RMySQL)

# 把股票代码赋值给"code"
"601318" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"SS",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hs601318 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")

dbWriteTable(dbh, 'hs601318', data, row.names = FALSE, overwrite = TRUE)

# 提取High列
hk_601318.H <- hk_601318[,2]
# 生成20天最高time series
hk_601318_high <- runMax(hk_601318.H, n = 20, cumulative = FALSE)
# 生成买点
hk_601318_buy <- tail(hk_601318_high, n=1)
# 显示买点
# View(hk_601318_buy)

# 提取Low列
hk_601318.L <- hk_601318[,3]
# 生成20天最低time series
hk_601318_low <- runMin(hk_601318.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_601318_sell <- tail(hk_601318_low, n=1)
# 显示卖点
# View(hk_601318_sell)

hk_601318_signals <- merge(hk_601318_buy,hk_601318_sell)
# 显示卖点和买点
View(hk_601318_signals)

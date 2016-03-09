# 载入需要的Package
library(quantmod)

# 把股票代码赋值给"code"
"600359" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"SS",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
getSymbols(tckr, from = start, to = end)


hk_600359 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_600359.H <- hk_600359[,2]
# 生成20天最高time series
hk_600359_high <- runMax(hk_600359.H, n = 20, cumulative = FALSE)
# 生成买点
hk_600359_buy <- tail(hk_600359_high, n=1)
# 显示买点
# View(hk_600359_buy)

# 提取Low列
hk_600359.L <- hk_600359[,3]
# 生成20天最低time series
hk_600359_low <- runMin(hk_600359.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_600359_sell <- tail(hk_600359_low, n=1)
# 显示卖点
# View(hk_600359_sell)

hk_600359_signals <- merge(hk_600359_buy,hk_600359_sell)
# 显示卖点和买点
View(hk_600359_signals)

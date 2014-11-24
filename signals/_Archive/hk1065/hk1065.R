# 载入需要的Package
library(quantmod)

# 把股票代码赋值给"code"
"1065" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
"2011-09-26" -> start
"2014-11-14" -> end

# 从Yahoo下载数据
hk_1065 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_1065.H <- hk_1065[,2]
# 生成20天最高time series
hk_1065_high <- runMax(hk_1065.H, n = 20, cumulative = FALSE)
# 生成买点
hk_1065_buy <- tail(hk_1065_high, n=1)
# 显示买点
# View(hk_1065_buy)

# 提取Low列
hk_1065.L <- hk_1065[,3]
# 生成20天最低time series
hk_1065_low <- runMin(hk_1065.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_1065_sell <- tail(hk_1065_low, n=1)
# 显示卖点
# View(hk_1065_sell)

hk_1065_signals <- merge(hk_1065_buy,hk_1065_sell)
# 显示卖点和买点
View(hk_1065_signals)

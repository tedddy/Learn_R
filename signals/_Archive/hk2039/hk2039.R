# 载入需要的Package
library(quantmod)

# 把股票代码赋值给"code"
"2039" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
"2011-09-26" -> start
"2014-11-14" -> end

# 从Yahoo下载数据
hk_2039 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_2039.H <- hk_2039[,2]
# 生成20天最高time series
hk_2039_high <- runMax(hk_2039.H, n = 20, cumulative = FALSE)
# 生成买点
hk_2039_buy <- tail(hk_2039_high, n=1)
# 显示买点
# View(hk_2039_buy)

# 提取Low列
hk_2039.L <- hk_2039[,3]
# 生成20天最低time series
hk_2039_low <- runMin(hk_2039.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_2039_sell <- tail(hk_2039_low, n=1)
# 显示卖点
# View(hk_2039_sell)

hk_2039_signals <- merge(hk_2039_buy,hk_2039_sell)
# 显示卖点和买点
View(hk_2039_signals)

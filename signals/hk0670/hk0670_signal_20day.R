# 载入需要的Package
library(quantmod)

# 把股票代码赋值给"code"
"0670" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hk_0670 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_0670.H <- hk_0670[,2]
# 生成20天最高time series
hk_0670_high <- runMax(hk_0670.H, n = 20, cumulative = FALSE)
# 生成买点
hk_0670_buy <- tail(hk_0670_high, n=1)
# 显示买点
# View(hk_0670_buy)

# 提取Low列
hk_0670.L <- hk_0670[,3]
# 生成20天最低time series
hk_0670_low <- runMin(hk_0670.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_0670_sell <- tail(hk_0670_low, n=1)
# 显示卖点
# View(hk_0670_sell)

hk_0670_signals <- merge(hk_0670_buy,hk_0670_sell)
# 显示卖点和买点
View(hk_0670_signals)

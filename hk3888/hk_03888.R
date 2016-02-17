
require(quantmod)
# 把股票代码赋值给"code"
"3888" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-88 -> start
Sys.Date() -> end

# 从Yahoo下载数据
hk_3888 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

hk3888 <- merge(Cl(hk_3888), MACD(Cl(hk_3888), 8, 17, 9, "EMA", FALSE))
hk3888$macdOsc <- hk3888$macd - hk3888$signal
tail(hk3888)

# 提取High列
hk_3888.H <- hk_3888[,2]
# 生成20天最高time series
hk_3888_high <- runMax(hk_3888.H, n = 20, cumulative = FALSE)
# 生成买点
hk_3888_buy <- tail(hk_3888_high, n=1)
# 显示买点
# View(hk_3888_buy)

# 提取Low列
hk_3888.L <- hk_3888[,3]
# 生成20天最低time series
hk_3888_low <- runMin(hk_3888.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_3888_sell <- tail(hk_3888_low, n=1)
# 显示卖点
# View(hk_3888_sell)
hk_3888_signals <- merge(hk_3888_buy,hk_3888_sell)
# 显示卖点和买点
View(hk_3888_signals)

# 载入需要的Package
library(quantmod)

# 把股票代码赋值给"code"
"grpn" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = code
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
us_grpn <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
us_grpn.H <- us_grpn[,2]
# 生成20天最高time series
us_grpn_high <- runMax(us_grpn.H, n = 20, cumulative = FALSE)
# 生成买点
us_grpn_buy <- tail(us_grpn_high, n=1)
# 显示买点
# View(us_grpn_buy)

# 提取Low列
us_grpn.L <- us_grpn[,3]
# 生成20天最低time series
us_grpn_low <- runMin(us_grpn.L, n = 20, cumulative = FALSE)
# 生成卖点
us_grpn_sell <- tail(us_grpn_low, n=1)
# 显示卖点
# View(us_grpn_sell)

us_grpn_signals <- merge(us_grpn_buy,us_grpn_sell)
# 显示卖点和买点
View(us_grpn_signals)

# 把股票代码赋值给"code"
"litb" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = code
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
us_litb <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
us_litb.H <- us_litb[,2]
# 生成20天最高time series
us_litb_high <- runMax(us_litb.H, n = 20, cumulative = FALSE)
# 生成买点
us_litb_buy <- tail(us_litb_high, n=1)
# 显示买点
# View(us_litb_buy)

# 提取Low列
us_litb.L <- us_litb[,3]
# 生成20天最低time series
us_litb_low <- runMin(us_litb.L, n = 20, cumulative = FALSE)
# 生成卖点
us_litb_sell <- tail(us_litb_low, n=1)
# 显示卖点
# View(us_litb_sell)

us_litb_signals <- merge(us_litb_buy,us_litb_sell)
# 显示卖点和买点
View(us_litb_signals)

# 把股票代码赋值给"code"
"renn" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = code
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
us_renn <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
us_renn.H <- us_renn[,2]
# 生成20天最高time series
us_renn_high <- runMax(us_renn.H, n = 20, cumulative = FALSE)
# 生成买点
us_renn_buy <- tail(us_renn_high, n=1)
# 显示买点
# View(us_renn_buy)

# 提取Low列
us_renn.L <- us_renn[,3]
# 生成20天最低time series
us_renn_low <- runMin(us_renn.L, n = 20, cumulative = FALSE)
# 生成卖点
us_renn_sell <- tail(us_renn_low, n=1)
# 显示卖点
# View(us_renn_sell)

us_renn_signals <- merge(us_renn_buy,us_renn_sell)
# 显示卖点和买点
View(us_renn_signals)

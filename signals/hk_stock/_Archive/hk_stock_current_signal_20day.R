# 载入需要的Package
library(quantmod)

# 把股票代码赋值给"code"
"0323" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hk_0323 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_0323.H <- hk_0323[,2]
  # 生成20天最高time series
  hk_0323_high <- runMax(hk_0323.H, n = 20, cumulative = FALSE)
# 生成买点
hk_0323_buy <- tail(hk_0323_high, n=1)
# 显示买点
# View(hk_0323_buy)

# 提取Low列
hk_0323.L <- hk_0323[,3]
# 生成20天最低time series
hk_0323_low <- runMin(hk_0323.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_0323_sell <- tail(hk_0323_low, n=1)
# 显示卖点
# View(hk_0323_sell)

hk_0323_signals <- merge(hk_0323_buy,hk_0323_sell)
# 显示卖点和买点
View(hk_0323_signals)

# how to coerce an xts object to numeric
# sell_price <- hk_0323_signals[, "hk_0323_sell"]
# sell_price
# class(sell_price)
# sell_price_numeric <- as.numeric(hk_0323_signals[1])[1]
# sell_price_numeric
# class(sell_price_numeric)

# 把股票代码赋值给"code"
"0588" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hk_0588 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_0588.H <- hk_0588[,2]
# 生成20天最高time series
hk_0588_high <- runMax(hk_0588.H, n = 20, cumulative = FALSE)
# 生成买点
hk_0588_buy <- tail(hk_0588_high, n=1)
# 显示买点
# View(hk_0588_buy)

# 提取Low列
hk_0588.L <- hk_0588[,3]
# 生成20天最低time series
hk_0588_low <- runMin(hk_0588.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_0588_sell <- tail(hk_0588_low, n=1)
# 显示卖点
# View(hk_0588_sell)

hk_0588_signals <- merge(hk_0588_buy,hk_0588_sell)
# 显示卖点和买点
View(hk_0588_signals)

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


# 把股票代码赋值给"code"
"1065" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

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

# 把股票代码赋值给"code"
"1157" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hk_1157 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_1157.H <- hk_1157[,2]
# 生成20天最高time series
hk_1157_high <- runMax(hk_1157.H, n = 20, cumulative = FALSE)
# 生成买点
hk_1157_buy <- tail(hk_1157_high, n=1)
# 显示买点
# View(hk_1157_buy)

# 提取Low列
hk_1157.L <- hk_1157[,3]
# 生成20天最低time series
hk_1157_low <- runMin(hk_1157.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_1157_sell <- tail(hk_1157_low, n=1)
# 显示卖点
# View(hk_1157_sell)

hk_1157_signals <- merge(hk_1157_buy,hk_1157_sell)
# 显示卖点和买点
View(hk_1157_signals)

# 把股票代码赋值给"code"
"1266" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hk_1266 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_1266.H <- hk_1266[,2]
# 生成20天最高time series
hk_1266_high <- runMax(hk_1266.H, n = 20, cumulative = FALSE)
# 生成买点
hk_1266_buy <- tail(hk_1266_high, n=1)
# 显示买点
# View(hk_1266_buy)

# 提取Low列
hk_1266.L <- hk_1266[,3]
# 生成20天最低time series
hk_1266_low <- runMin(hk_1266.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_1266_sell <- tail(hk_1266_low, n=1)
# 显示卖点
# View(hk_1266_sell)

hk_1266_signals <- merge(hk_1266_buy,hk_1266_sell)
# 显示卖点和买点
View(hk_1266_signals)

# 把股票代码赋值给"code"
"1618" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hk_1618 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_1618.H <- hk_1618[,2]
# 生成20天最高time series
hk_1618_high <- runMax(hk_1618.H, n = 20, cumulative = FALSE)
# 生成买点
hk_1618_buy <- tail(hk_1618_high, n=1)
# 显示买点
# View(hk_1618_buy)

# 提取Low列
hk_1618.L <- hk_1618[,3]
# 生成20天最低time series
hk_1618_low <- runMin(hk_1618.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_1618_sell <- tail(hk_1618_low, n=1)
# 显示卖点
# View(hk_1618_sell)

hk_1618_signals <- merge(hk_1618_buy,hk_1618_sell)
# 显示卖点和买点
View(hk_1618_signals)

# 把股票代码赋值给"code"
"2357" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hk_2357 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_2357.H <- hk_2357[,2]
# 生成20天最高time series
hk_2357_high <- runMax(hk_2357.H, n = 20, cumulative = FALSE)
# 生成买点
hk_2357_buy <- tail(hk_2357_high, n=1)
# 显示买点
# View(hk_2357_buy)

# 提取Low列
hk_2357.L <- hk_2357[,3]
# 生成20天最低time series
hk_2357_low <- runMin(hk_2357.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_2357_sell <- tail(hk_2357_low, n=1)
# 显示卖点
# View(hk_2357_sell)

hk_2357_signals <- merge(hk_2357_buy,hk_2357_sell)
# 显示卖点和买点
View(hk_2357_signals)

# 把股票代码赋值给"code"
"2727" -> code
# 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
tckr = paste(code,"hk",sep=".")
# 设定开始和结束日期
Sys.Date()-28 -> start
Sys.Date()-1 -> end

# 从Yahoo下载数据
hk_2727 <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)

# 提取High列
hk_2727.H <- hk_2727[,2]
# 生成20天最高time series
hk_2727_high <- runMax(hk_2727.H, n = 20, cumulative = FALSE)
# 生成买点
hk_2727_buy <- tail(hk_2727_high, n=1)
# 显示买点
# View(hk_2727_buy)

# 提取Low列
hk_2727.L <- hk_2727[,3]
# 生成20天最低time series
hk_2727_low <- runMin(hk_2727.L, n = 20, cumulative = FALSE)
# 生成卖点
hk_2727_sell <- tail(hk_2727_low, n=1)
# 显示卖点
# View(hk_2727_sell)

hk_2727_signals <- merge(hk_2727_buy,hk_2727_sell)
# 显示卖点和买点
View(hk_2727_signals)

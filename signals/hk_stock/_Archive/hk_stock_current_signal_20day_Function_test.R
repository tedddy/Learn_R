# 载入需要的Package
library(quantmod)

signal_BuySell <- function (code) {
  
  # 生成getSymbol函数从yahoo采集数据需要的代码格式。Note: hk stock cannot directly use the method in the tutorial given by the package author. Refer to signal_hk3818.R
  tckr = paste(code,"hk",sep=".")
  # 设定开始和结束日期
  Sys.Date()-28 -> start
  Sys.Date()-1 -> end
  
  # 从Yahoo下载数据
  hk <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)
  
  # 提取High列
  hk.H <- hk[,2]
  # 生成20天最高time series
  hk_high <- runMax(hk.H, n = 20, cumulative = FALSE)
  # 生成买点
  hk_buy <- tail(hk_high, n=1)
  # 显示买点
  # View(hk_buy)
  
  # 提取Low列
  hk.L <- hk[,3]
  # 生成20天最低time series
  hk_low <- runMin(hk.L, n = 20, cumulative = FALSE)
  # 生成卖点
  hk_sell <- tail(hk_low, n=1)
  # 显示卖点
  # View(hk_sell)
  
  hk_signals <- merge(hk_buy,hk_sell)
  # 显示卖点和买点
  View(hk_signals)
  
}

signal_BuySell("0323")
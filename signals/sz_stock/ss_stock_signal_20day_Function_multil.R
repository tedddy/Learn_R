# 载入需要的Package
library(quantmod)

code_current <- c("600030", "600428", "600600", "601288", 600359, 601318, 601668) ## First code is put in " " to make the vector charactor vector, and the code with 0 at the first postion should be quoted. 

code_watch_RealEstate <- c("600256", 600048, 600383, 600663, 600648, 600748, 600266, 600325, 600657, 600675, 600638)

# signal_BuySell_f("600246") 600246 , "600239" do not work!!!

class(code_current)

signal_BuySell_f <- function (code) {
    
    tckr = paste(code,"SS",sep=".")
    # 设定开始和结束日期
    Sys.Date()-30 -> start
    Sys.Date()-1 -> end
    
    # 从Yahoo下载数据
    ss <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)
    
    # 提取High列
    ss.H <- ss[,2]
    # 生成20天最高time series
    ss_high <- runMax(ss.H, n = 20, cumulative = FALSE)
    # 生成买点
    ss_buy <- tail(ss_high, n=1)
    # 显示买点
    # View(ss_buy)
    
    ss_buy_numeric <- as.numeric(ss_buy[1])
    
    # 提取Low列
    ss.L <- ss[,3]
    # 生成20天最低time series
    ss_low <- runMin(ss.L, n = 20, cumulative = FALSE)
    # 生成卖点
    ss_sell <- tail(ss_low, n=1)
    # 显示卖点
    # View(ss_sell)
    
    ss_sell_numeric <- as.numeric(ss_sell[1])
    
    # ss_signals <- merge(ss_buy,ss_sell)
    # 显示卖点和买点
    # View(ss_signals)
    
    Lst <- data.frame(code = tckr, buy = ss_buy_numeric, sell = ss_sell_numeric)
    
}

for (i in seq_along(code_current)) {
    if (i == 1) {
        signal_current <- signal_BuySell_f(code_current[[i]])
    }  else {
        signal_current <- rbind(signal_BuySell, signal_BuySell_f(code_current[[i]]))
    }
}
View(signal_BuySell)

for (i in seq_along(code_watch_RealEstate)) {
  if (i == 1) {
    signal_RealEstate <- signal_BuySell_f(code_watch_RealEstate[[i]])
  }  else {
    signal_RealEstate <- rbind(signal_RealEstate, signal_BuySell_f(code_watch_RealEstate[[i]]))
  }
}
View(signal_RealEstate)
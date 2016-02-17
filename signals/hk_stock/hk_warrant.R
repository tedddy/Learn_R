# 载入需要的Package
library(quantmod)

signal_BuySell <- function (code) {
    
    tckr = paste(code,"HK",sep=".")
    # 设定开始和结束日期
    Sys.Date()-30 -> start
    Sys.Date()-1 -> end
    
    # 从Yahoo下载数据
    hk <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)
    
    # 提取Close列
    hk.C <- hk[,4]
    # 生成最后一天的价格
    hk_close <- tail(hk.C, n=1)
    
    hk_close_numeric <- as.numeric(hk_close[1])
    
    # 提取High列
    hk.H <- hk[,2]
    # 生成20天最高time series
    hk_high <- runMax(hk.H, n = 10, cumulative = FALSE)
    # 生成买点
    hk_buy <- tail(hk_high, n=1)
    # 显示买点
    # View(hk_buy)
    
    hk_buy_numeric <- as.numeric(hk_buy[1])
    
    # 提取Low列
    hk.L <- hk[,3]
    # 生成20天最低time series
    hk_low <- runMin(hk.L, n = 10, cumulative = FALSE)
    # 生成卖点
    hk_sell <- tail(hk_low, n=1)
    # 显示卖点
    # View(hk_sell)
    
    hk_sell_numeric <- as.numeric(hk_sell[1])
    
    # hk_signals <- merge(hk_buy,hk_sell)
    # 显示卖点和买点
    # View(hk_signals)
    
    Lst <- data.frame(code = tckr, buy = hk_buy_numeric, close = hk_close_numeric, sell = hk_sell_numeric, buy_diff = 100*(hk_buy_numeric-hk_close_numeric)/hk_close_numeric, sell_diff = 100*(hk_sell_numeric-hk_close_numeric)/hk_close_numeric)
    
}
view_results <- function (tickers) {
    for (i in seq_along(tickers)) {
        if (i == 1) {
            signal <- signal_BuySell(tickers[[i]])
        }  else {
            signal <- rbind(signal, signal_BuySell(tickers[[i]]))
        }
    }
    
    # View(signal_current)
    
    signal_ordered_sell <- signal[ order(signal[,6], signal[,5]), ]    
    View(signal_ordered_sell)
    
    signal_ordered_buy <- signal[ order(signal[,5], signal[,6]), ]    
    View(signal_ordered_buy)
}

warrant <- c("15048")
view_results(warrant)


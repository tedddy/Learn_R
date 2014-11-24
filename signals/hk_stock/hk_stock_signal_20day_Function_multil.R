# 载入需要的Package
library(quantmod)

code_current <- c("0323", "0338", "0493", "0588", "0670", 1065, 1157, 1266, 1618, 2357, 2727, 2866, 3818) ## First code is put in " " to make the vector charactor vector, and the code with 0 at the first postion should be quoted. 

code_watch_RealEstate <- c("0119", "0123", "0152", "0270", "0272", "0283", "0291", "0363", "0392", "0410", "0588", "0604", "0813", "0817", "0917", "0960", "1109", "1138", "1668", "1813", "2007", "3333", "3377", "3380")

# , "3383", "3900": these two cannot be fetched.
# Sys.Date()-30 -> start
# Sys.Date()-1 -> end
# hk <- getSymbols("3383.HK", from = start, to = end, auto.assign = FALSE)

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
    hk_high <- runMax(hk.H, n = 20, cumulative = FALSE)
    # 生成买点
    hk_buy <- tail(hk_high, n=1)
    # 显示买点
    # View(hk_buy)
    
    hk_buy_numeric <- as.numeric(hk_buy[1])
    
    # 提取Low列
    hk.L <- hk[,3]
    # 生成20天最低time series
    hk_low <- runMin(hk.L, n = 20, cumulative = FALSE)
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

for (i in seq_along(code_current)) {
    if (i == 1) {
        signal_current <- signal_BuySell(code_current[[i]])
    }  else {
        signal_current <- rbind(signal_current, signal_BuySell(code_current[[i]]))
    }
}
View(signal_current)

for (i in seq_along(code_watch_RealEstate)) {
    if (i == 1) {
        signal_RealEstate <- signal_BuySell(code_watch_RealEstate[[i]])
    }  else {
        signal_RealEstate <- rbind(signal_RealEstate, signal_BuySell(code_watch_RealEstate[[i]]))
    }
}
View(signal_RealEstate)

signal_RealEstate_ordered <- signal_RealEstate[ order(signal_RealEstate[,5], signal_RealEstate[,6]), ]

View(signal_RealEstate_ordered)



# 载入需要的Package
library(quantmod)

code_current <- c("000002", "000039", "000338") ## First code is put in " " to make the vector charactor vector, and the code with 0 at the first postion should be quoted. 

code_watch_RealEstate <- c("000002", "000024", "000402", "000540", "000671", "000979", "000718", "000031", "000897", "002016", "002146", "002244", "000667", "000631")

# , "3383", "3900": these two cannot be fetched.
# Sys.Date()-30 -> start
# Sys.Date()-1 -> end
# ss <- getSymbols("3383.SZ", from = start, to = end, auto.assign = FALSE)

signal_BuySell <- function (code) {
    
    tckr = paste(code,"SZ",sep=".")
    # 设定开始和结束日期
    Sys.Date()-30 -> start
    Sys.Date()-1 -> end
    
    # 从Yahoo下载数据
    ss <- getSymbols(tckr, from = start, to = end, auto.assign = FALSE)
    
    # 提取Close列
    ss.C <- ss[,4]
    # 生成最后一天的价格
    ss_close <- tail(ss.C, n=1)
    
    ss_close_numeric <- as.numeric(ss_close[1])
    
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
    
    Lst <- data.frame(code = tckr, buy = ss_buy_numeric, close = ss_close_numeric, sell = ss_sell_numeric, buy_diff = 100*(ss_buy_numeric-ss_close_numeric)/ss_close_numeric, sell_diff = 100*(ss_sell_numeric-ss_close_numeric)/ss_close_numeric)
    
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
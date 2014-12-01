# 载入需要的Package
library(quantmod)

code_current <- c("600030", "600048", "600428", "600600", "601288", "601318", "601668") ## First code is put in " " to make the vector charactor vector, and the code with 0 at the first postion should be quoted. 

code_watch_RealEstate <- c("600048", "600162", "600185", "600256", "600266", "600383", 600663, 600648, 600748, "600325", 600657, 600675, 600638, "600823")

# , "3383", "3900": these two cannot be fetched.
# Sys.Date()-30 -> start
# Sys.Date()-1 -> end
# ss <- getSymbols("3383.SS", from = start, to = end, auto.assign = FALSE)

signal_BuySell <- function (code) {
    
    tckr = paste(code,"SS",sep=".")
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


code_watch_ShuiLi <- c("600068","600075","600116","600131","600283","600502","601669")
for (i in seq_along(code_watch_ShuiLi)) {
  if (i == 1) {
    signal_ShuiLi <- signal_BuySell(code_watch_ShuiLi[[i]])
  }  else {
    signal_ShuiLi <- rbind(signal_ShuiLi, signal_BuySell(code_watch_ShuiLi[[i]]))
  }
}
View(signal_ShuiLi)

signal_ShuiLi_ordered <- signal_ShuiLi[ order(signal_ShuiLi[,5], signal_ShuiLi[,6]), ]

View(signal_ShuiLi_ordered)


code_watch_YiYao <- c("600062","600079","600085","600129","600161","600196","600216","600222","600252","600267","600276","600285","600297","600329","600332","600351","600352","600353","600354","600355","600356","600357","600358","600359","600360","600361","600362","600363","600364","600365","600366","600367","600368")

for (i in seq_along(code_watch_YiYao)) {
  if (i == 1) {
    signal_YiYao <- signal_BuySell(code_watch_YiYao[[i]])
  }  else {
    signal_YiYao <- rbind(signal_YiYao, signal_BuySell(code_watch_YiYao[[i]]))
  }
}
View(signal_YiYao)

signal_YiYao_ordered <- signal_YiYao[ order(signal_YiYao[,5], signal_YiYao[,6]), ]

View(signal_YiYao_ordered)


watch_GuQi <- c("600208","600638","600755") ## ,"600369"
for (i in seq_along(watch_GuQi)) {
  if (i == 1) {
    signal_GuQi <- signal_BuySell(watch_GuQi[[i]])
  }  else {
    signal_GuQi <- rbind(signal_GuQi, signal_BuySell(watch_GuQi[[i]]))
  }
}
View(signal_GuQi)

signal_GuQi_ordered <- signal_GuQi[ order(signal_GuQi[,5], signal_GuQi[,6]), ]

View(signal_GuQi_ordered)


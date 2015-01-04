require(quantmod)

# 获取数据
ZXZQ <- getSymbols("600030.SS", src = "yahoo", auto.assign=FALSE)

# 画图
chartSeries(ZXZQ,name="ZXZQ CANDLECHART",subset="2014-06::2014-12-19",type="candlesticks", TA="addBBands();addROC();addCCI()")

# 截取中信证券从2014年6月到12月19号的数据
ZXZQ_subset <- ZXZQ["2014-06::2014-12-19"]

# 计算这段时间CCI指数
CCI_data_ZXZQ_subset <- CCI(ZXZQ_subset[,2,3,4])

# 截取CCI > 100的数据
CCI_data_ZXZQ_subset_bigger_100 <- CCI_data_ZXZQ_subset[CCI_data_ZXZQ_subset[,1] > 100]

# 截取CCI < -100的数据
CCI_data_ZXZQ_subset_smaller_n100 <- CCI_data_ZXZQ_subset[-CCI_data_ZXZQ_subset[,1] > 100]

# 观察：如果利用CCI数据来买入卖出，将错过获取丰厚利润的机会。
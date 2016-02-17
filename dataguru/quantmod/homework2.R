
# AAPL

# 问题1 试对ADX指标进行技术分析，指出某段时间里根据ADX及相关指标研读出来的走势预测

require(quantmod)
getSymbols("AAPL", src = "yahoo")
candleChart(AAPL, theme = "white", subset = "2011-01-01::2012-12-31")
addADX()

head(AAPL)

ADX_Data <- ADX(cbind(Hi(AAPL), Lo(AAPL), Cl(AAPL)), n = 14, maType = "EMA", wilder = TRUE)

# 在2012年一月的时候，ADX走强，可以考虑买入股票；在2012年5月的时候，ADX走弱，可以考虑卖出股票。

# 问题2 求出每种股票在上述年份内ADX指标同时低于DI+和DI-的时间段
ADX_Data_subset <- ADX_Data['2011-01-01::2012-12-31']

Answer_2 <- ADX_Data_subset[ADX_Data_subset[,1] > ADX_Data_subset[,4] & ADX_Data_subset[,2] > ADX_Data_subset[,4]]

# MSFT

# 问题1 试对ADX指标进行技术分析，指出某段时间里根据ADX及相关指标研读出来的走势预测

require(quantmod)
getSymbols("MSFT", src = "yahoo")
candleChart(MSFT, theme = "white", subset = "2011-01-01::2012-12-31")
addADX()

ADX_Data <- ADX(cbind(Hi(MSFT), Lo(MSFT), Cl(MSFT)), n = 14, maType = "EMA", wilder = TRUE)


# 问题2 求出每种股票在上述年份内ADX指标同时低于DI+和DI-的时间段
ADX_Data_subset <- ADX_Data['2011-01-01::2012-12-31']

Answer_2 <- ADX_Data_subset[ADX_Data_subset[,1] > ADX_Data_subset[,4] & ADX_Data_subset[,2] > ADX_Data_subset[,4]]

# ORCL

# 问题1 试对ADX指标进行技术分析，指出某段时间里根据ADX及相关指标研读出来的走势预测

require(quantmod)
getSymbols("ORCL", src = "yahoo")
candleChart(ORCL, theme = "white", subset = "2011-01-01::2012-12-31")
addADX()

ADX_Data <- ADX(cbind(Hi(ORCL), Lo(ORCL), Cl(ORCL)), n = 14, maType = "EMA", wilder = TRUE)


# 问题2 求出每种股票在上述年份内ADX指标同时低于DI+和DI-的时间段
ADX_Data_subset <- ADX_Data['2011-01-01::2012-12-31']

Answer_2 <- ADX_Data_subset[ADX_Data_subset[,1] > ADX_Data_subset[,4] & ADX_Data_subset[,2] > ADX_Data_subset[,4]]

# GOOG

# 问题1 试对ADX指标进行技术分析，指出某段时间里根据ADX及相关指标研读出来的走势预测

require(quantmod)
getSymbols("GOOG", src = "yahoo")
candleChart(GOOG, theme = "white", subset = "2011-01-01::2012-12-31")
addADX()

ADX_Data <- ADX(cbind(Hi(GOOG), Lo(GOOG), Cl(GOOG)), n = 14, maType = "EMA", wilder = TRUE)


# 问题2 求出每种股票在上述年份内ADX指标同时低于DI+和DI-的时间段
ADX_Data_subset <- ADX_Data['2011-01-01::2012-12-31']

Answer_2 <- ADX_Data_subset[ADX_Data_subset[,1] > ADX_Data_subset[,4] & ADX_Data_subset[,2] > ADX_Data_subset[,4]]
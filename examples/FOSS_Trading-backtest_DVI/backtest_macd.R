# run the command below if quantmod isn't already installed
# install.packages("quantmod")
# use the quantmod package (loads TTR, xts, and zoo)
require(quantmod)
# pull SPX ttrc from Yahoo (getSymbols returns an xts object)
# getSymbols("^GSPC")
require(RMySQL)
source('~/lr/index/functions/sqlQuery_fun.R')

ids <- '002183'
# query <- paste("SELECT dt as date, high as High, low as Low, close as Close, volume as Volume FROM ying_calc.s_xts_adj where `ids` =",ids," ORDER BY `dt` DESC LIMIT 500;")

# ttrc <- sqlQuery(paste("SELECT dt as date, high as High, low as Low, close as Close, volume as Volume FROM ying_calc.s_xts_adj where `ids` =",ids," ORDER BY `dt` DESC LIMIT 500;"))

# converting ttrc to xts
#   rownames(ttrc) <- as.POSIXct(ttrc[,1])
#   ttrc <- xts(ttrc[,-1], order.by=as.POSIXct(ttrc[,1]))
# save ttrc to a file
# save(ttrc, file= 'ttrc002183.rda', ascii = FALSE)
# load ttrc from a file
load("~/lr/examples/FOSS_Trading-backtest_DVI/ttrc002183.rda")

macd_cl <- merge(Cl(ttrc), MACD(Cl(ttrc), 11, 26, 9, "EMA"))

macd_cl$macdOsc <- macd_cl$macd - macd_cl$signal

macd_vo <- merge(Vo(ttrc), MACD(Vo(ttrc), 11, 26, 9, "EMA"))

macd_vo$macdOsc <- macd_vo$macd - macd_vo$signal

macd <-cbind(macd_cl, diff(macd_cl$Close), diff(macd_cl$macdOsc), macd_vo, diff(macd_vo$Volume), diff(macd_vo$macdOsc)) 

macd <- setNames(macd, c("cl","m_cl","s_cl","osc_cl","cl_d1","osc_cl_d1","vo","macd_vo","signal_vo","osc_vo","vo_d1","osc_vo_d1"))

# calculate DVI indicator
# dvi <- DVI(Cl(GSPC))  # Cl() extracts the close price column

# create signal: (long (short) if DVI is below (above) 0.5)
# lag so yesterday's signal is applied to today's returns
# trading strategy: if macd$osc_cl > 0 and 

sig <- Lag(ifelse(macd$osc_cl > 0, 1, ifelse(macd$osc_cl < -2, 0, 0)))

# calculate signal-based returns
ret <- ROC(Cl(ttrc))*sig
# subset returns to match ttrc in Excel file
ret <- ret['2014-11-01/2016-03-07']

# use the PerformanceAnalytics package
# install.packages("PerformanceAnalytics")
require(PerformanceAnalytics)
# create table showing drawdown statistics
table.Drawdowns(ret, top=10)
# create table of downside risk estimates
table.DownsideRisk(ret)
# chart equity curve, daily performance, and drawdowns
charts.PerformanceSummary(ret)


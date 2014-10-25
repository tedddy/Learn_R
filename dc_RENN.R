library(TTR)
RENN <- getYahooData("RENN",20140101,20141001)
temp_RENN <- RENN[,c("High","Low")]
dc_RENN <- DonchianChannel(temp_RENN)

library(TTR)
library(zoo)
library(xts)
RENN <- getYahooData("RENN",20140101,20141001)
temp_RENN <- RENN[,c("High","Low")]
dc_RENN <- DonchianChannel(temp_RENN)

#? extract_dc_RENN <- dc_RENN[[1]]; dc_RENN

extract_dc_RENN <- dc_RENN[[2]]


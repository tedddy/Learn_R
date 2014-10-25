library(TTR)
data(ttrc)
temp <- ttrc[,c("High","Low")]
dc <- DonchianChannel(ttrc[,c("High","Low")])
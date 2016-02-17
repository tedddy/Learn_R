# 从Yahoo下载数据
CMCM <- getSymbols("CMCM", from = start, auto.assign = FALSE)

CMCM <- merge(Cl(CMCM), MACD(Cl(CMCM), 8, 17, 9, "EMA", FALSE))
CMCM$macdOsc <- CMCM$macd - CMCM$signal
tail(CMCM)

require(quantmod)
getSymbols("IBM", source="google")
ibm <- merge(Cl(IBM), MACD(Cl(IBM), 8, 17, 9, "EMA", FALSE))
ibm$macdOsc <- ibm$macd - ibm$signal
tail(ibm)

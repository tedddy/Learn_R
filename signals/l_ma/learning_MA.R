require(quantmod)
# getSymbols("^SSEC", from = "2010-01-01", src = "yahoo")

fastMA <- SMA(Cl(SSEC["2013-04-20/2013-05-31"]), n = 5)  
slowMA <- SMA(Cl(SSEC["2013-03-01/2013-05-31"]), n = 30)
signal1 <- fastMA >= slowMA
x <- which(signal1["2013-05-01/2013-05-31", ])[1]

chartSeries(SSEC, subset = "2013-05-01/2013-05-31", theme = "white", TA = "addSMA(n=5,col=\"red\");addSMA(n=30,col=\"blue\")")
ss <- SSEC["2013-05-01/2013-05-30"]
addTA(ss[x, "SSEC.Low"] - 10, pch = 17, type = "p", col = "red", on = 1)

# fast MA during "2015-12-20/2016-02-15"
fMA <- SMA(Cl(SSEC["2015-12-20/2016-02-15"]), n = 5)
                                        # slow
sMA <- SMA(Cl(SSEC["2015-11-10/2016-02-15"]), n = 30)

signaltedd <- fMA >= sMA
xtedd <- which(signal1["2016-01-10/2016-02-15", ])[1]
xtedd
x

chartSeries(SSEC, subset = "2016-01-10/2016-02-15", theme = "white", TA = "addSMA(n=5,col=\"red\");addSMA(n=30,col=\"blue\")")
sstedd <- SSEC["2016-01-10/2016-02-15"]
addTA(ss[xtedd, "SSEC.Low"] - 10, pch = 17, type = "p", col = "red", on = 1)

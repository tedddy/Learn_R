# Refer to quantmod-vignette.pdf
# http://www.quantmod.com/documentation/getSymbols.yahoo.html

library("quantmod")
# ?getSymbols

sp500 <- new.env()

getSymbols("^GSPC", env = sp500, src = "yahoo", from = as.Date("1960-01-04"), to = as.Date("2009-01-01"))

#Tedd test default start and end
sp500_test <- new.env()
getSymbols("^GSPC", env = sp500_test, src = "yahoo")
GSPC_test <- sp500_test$GSPC
# test default start and end Tedd

#Tedd test the function to get data in TTR package
# getYahooData("^GSPC", 19990104, 20090101)
# "getYahooData("^GSPC", 19600104, 20090101)" does not work, likely due to 1960 is too early.
# getYahooData("YHOO", 20080104, 20090101)
# ?getYahooData
# rm(sample_matrix)
#Tedd test the function to get data in TTR package Tedd

#Tedd test demo(chartSeries)
#Tedd remove all the objects generated in the demo: rm(sample_matrix); rm(chartSeries.demo)

GSPC <- sp500$GSPC
GSPC1 <- get("GSPC", envir = sp500)
GSPC2 <- with(sp500, GSPC)

rm(GSPC1)
rm(GSPC2)

head(GSPC)

class(GSPC)

dim(GSPC)

# ?dim

head(GSPC$GSPC.Volume)


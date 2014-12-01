# Load Package
library(quantmod)

args(getSymbols)

getSymbols("^SSEC") ## Correct way

SSEC_2 <- getSymbols("000001.ss", auto.assign=FALSE)
SSEC_3 <- getSymbols("000001.ss")

?setSymbolLookup

setSymbolLookup(SANY.HEAVY=list(name="600030.ss",src="yahoo"))
getSymbols("SANY.HEAVY")
SANY.HEAVY

setSymbolLookup(SANY.HEAVY=list(name="600030.ss", from = Sys.Date()-30, to = Sys.Date()-1, src="yahoo"))
getSymbols("SANY.HEAVY")
SANY.HEAVY

is.OHLC(SANY.HEAVY)
has.OHLC(SANY.HEAVY)
has.OHLC(SANY.HEAVY, which=TRUE)

# Fetch data for questions.
GuPiaoJi <- c("AAPL","MSFT","ORCL","GOOG")
getSymbols(GuPiaoJi, from = "2011-01-01", to= Sys.Date())

# Question 1
AAPL_subset <- AAPL['2013-01-01::2013-10-30']
totalVolume <- sum(AAPL_subset[,5])
totalVolume

# Question 2
# ?dailyReturn
dailyReturn_AAPL <- dailyReturn(AAPL, type="arithmetic")
AAPL_and_return <- merge(AAPL, dailyReturn_AAPL)
# AAPL_and_return_biger_than_2 <- AAPL_and_return[AAPL_and_return[,7] > 0.02]
# AAPL_and_return_biger_than_2
AAPL_and_return_biger_than_5 <- AAPL_and_return[AAPL_and_return[,7] > 0.05]
View(AAPL_and_return_biger_than_5)

dailyReturn_MSFT <- dailyReturn(MSFT, type="arithmetic")
MSFT_and_return <- merge(MSFT, dailyReturn_MSFT)
MSFT_and_return_biger_than_5 <- MSFT_and_return[MSFT_and_return[,7] > 0.05]
View(MSFT_and_return_biger_than_5)

dailyReturn_ORCL <- dailyReturn(ORCL, type="arithmetic")
ORCL_and_return <- merge(ORCL, dailyReturn_ORCL)
ORCL_and_return_biger_than_5 <- ORCL_and_return[ORCL_and_return[,7] > 0.05]
View(ORCL_and_return_biger_than_5)

dailyReturn_GOOG <- dailyReturn(GOOG, type="arithmetic")
GOOG_and_return <- merge(GOOG, dailyReturn_GOOG)
GOOG_and_return_biger_than_5 <- GOOG_and_return[GOOG_and_return[,7] > 0.05]
View(GOOG_and_return_biger_than_5)

# install.packages("rJava") # 1-time initialization step
# library(rJava)
# source("MINE.R")
# MINE("example.csv","all.pairs")


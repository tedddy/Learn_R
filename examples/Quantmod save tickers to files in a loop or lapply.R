# https://app.yinxiang.com/shard/s22/nl/4928451/440a960d-64d8-43b2-a757-93a62fb02c8c
require(quantmod)

buildhist <- function(x,start,end) {
    getSymbols(x, from=start, to=end, adjust=TRUE)
    X <- toupper(gsub("\\^","",x))  # what getSymbols.yahoo does
    save(list=X, file= paste(X, "hist.rda", sep="_"), ascii = FALSE)  
}

tckr <- c("^GSPC","YHOO","XLB")

tckr <- c("601318.SS")
lapply(tckr,buildhist,start="1995-01-01",end="2011-11-30")

read.RDS

# http://cos.name/; http://cos.name/cn/topic/17816
library(RCurl)
library(RODBC)
library(bitops)
library(XML)##这些包的安装比较麻烦，尤其是XML
library(stringr)
library(plyr)

myHttpheader<- c(
  "User-Agent"="Mozilla/5.0(Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6)",
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language"="en-us",
  "Connection"="keep-alive",
  "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
)

d=debugGatherer()
temp<- getURL("http://cos.name/",httpheader=myHttpheader,debugfunction=d$update,verbose= TRUE)

cHandle<- getCurlHandle(httpheader = myHttpheader)
d = debugGatherer()
temp <- getURL("http://cos.name/", .opts = list(debugfunction=d$update,verbose = TRUE), curl=cHandle)

cat(d$value()[2])
cat(d$value()[3])


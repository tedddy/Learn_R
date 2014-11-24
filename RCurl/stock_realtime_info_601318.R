#http://hq.sinajs.cn/list=sh601318
library(RCurl)
library(RODBC)
library(bitops)
library(XML)##这些包的安装比较麻烦，尤其是XML
library(stringr)
library(plyr)
###此处专用于解决XML中文乱码问题###
myHttpheader<- c(
  "User-Agent"="Mozilla/5.0(Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6)",
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language"="en-us, zh_CN",
  "Connection"="keep-alive",
  "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
)
###以上这段不需要改
rt_601318 <- getURL("http://hq.sinajs.cn/list=sh601318",httpheader=myHttpheader)

rt_601318

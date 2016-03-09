library(RCurl)
myHttpheader <- c(
    "Accept"="image/webp,*/*;q=0.8",
    "Accept-Encoding"="gzip,deflate,sdch",
    "Accept-Language"="zh-CN,zh;q=0.8",
    "Cache-Control"="no-cache",
    "Connection"="keep-alive",
    "Pragma"="no-cache",
    "Referer"="http://bbs.shangdu.com/s/regform.htm",
    "User-Agent"="Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36"
)
jpg <- getBinaryURL("http://img14.360buyimg.com/n1/g2/M04/07/00/rBEGEFAoV-IIAAAAAACLk5lmyBgAABXmwEq69gAAIur232.jpg",httpheader=myHttpheader)
# writeBin(jpg, con = "C:\\Users\\Xianghua\\Pictures\\RCurl\\123.jpg") #保存图片
writeBin(jpg, con = "/home/tony/lr/examples/picture/jd.jpg") #保存图片
#shell.exec(tf) #显示图片

library(RCurl)
myHttpheader <- c(
    "Accept"="image/webp,*/*;q=0.8",
    "Accept-Encoding"="gzip,deflate,sdch",
    "Accept-Language"="zh-CN,zh;q=0.8",
    "Cache-Control"="no-cache",
    "Connection"="keep-alive",
    "Pragma"="no-cache",
    "Referer"="http://bbs.shangdu.com/s/regform.htm",
    "User-Agent"="Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36"
)
png <- getBinaryURL("http://push.shangdu.com/regcode.php?token=prrX73LtmN_63uEcKh0a2Z1opo1ZgdcBJ",httpheader=myHttpheader)
writeBin(png, con = "/home/tony/lr/examples/picture/123.png") #保存图片
shell.exec(tf) #显示图片
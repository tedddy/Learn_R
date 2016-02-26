 require(readxl)
 require(RMySQL)
 dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
 dbSendQuery(dbh,'SET NAMES utf8 ')
 # dbListTables(dbh)
 
 list_e <-as.data.frame(read_excel("E:\\user_tony\\download\\software\\list_e_2016-02-18.xls", sheet = 1, col_names = TRUE, col_types = TEXT, na = "",skip = 0))
 
 #my.dataframe$new.col <- a.vector
 list_e$dt <- Sys.Date()
 
 View(list_e)
 
 dbWriteTable(dbh, 'hk_w_sg_imported', list_e, row.names = FALSE, overwrite = TRUE)
 
 # the following does not work!
 list_e <-read_excel("http://hk.warrants.com/home/en/sgdata/list_e.xls?ucode=&sname=ALL&wtype=ALL&mtype=0&iv1=&iv2=&ptype=0&s1=&s2=&osp1=&osp2=&egear=0&cr1=&cr2=&d1=&d2=&m1=0&m2=0&industry=&order=dbcode%20desc&cnycode_dummy=", sheet = 1, col_names = TRUE, col_types = NULL, na = "",skip = 0)
 
 View(list_e)
 
 
 
 
 require(readxl)
 require(RMySQL)
 dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
 dbSendQuery(dbh,'SET NAMES utf8 ')
 dbListTables(dbh)
 
 datasets <- system.file("extdata/datasets.xlsx", package = "readxl")
 read_excel(datasets)
 # Specific sheet either by position or by name
 read_excel(datasets, 2)
 read_excel(datasets, "mtcars")
 

 
 list_e <-read_excel("E:\\user_tony\\download\\software\\list_e.xls", sheet = 1, col_names = TRUE, col_types = NULL, na = "",skip = 0)
 
 View(list_e)
 
 dbWriteTable(dbh, 'hk_w_sg', list_e)
 
 # the following does not work!
 list_e <-read_excel("http://hk.warrants.com/home/en/sgdata/list_e.xls?ucode=&sname=ALL&wtype=ALL&mtype=0&iv1=&iv2=&ptype=0&s1=&s2=&osp1=&osp2=&egear=0&cr1=&cr2=&d1=&d2=&m1=0&m2=0&industry=&order=dbcode%20desc&cnycode_dummy=", sheet = 1, col_names = TRUE, col_types = NULL, na = "",skip = 0)
 
 View(list_e)
 
 code <- cbind (list_e[,2], list_e[,16])
 
 View(code)
 
 
 library(stringr)
 
 data(mtcars)
 
 # car name is data.frame's rownames. Let's split into manufacturer and model columns:
 mtcars$mfg = str_split_fixed(rownames(mtcars), ' ', 2)[,1]
 mtcars$mfg[mtcars$mfg=='Merc'] = 'Mercedes'
 mtcars$model = str_split_fixed(rownames(mtcars), ' ', 2)[,2]
 
 # connect to local MySQL database (host='localhost' by default)
 dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying_calc", host="192.168.137.172")
 
 dbWriteTable(dbh, name='hk_w_sg', value=code, field.types = list(V1="character", V2="double(20,10)"), row.names=FALSE)
 
 dbWriteTable(con, name="table_name", value=df, field.types=list(dte="date", val="double(20,10)"), row.names=FALSE)
 
 dbWriteTable(dbh, 'motortrend', mtcars)
 
 dbDisconnect(con)
 
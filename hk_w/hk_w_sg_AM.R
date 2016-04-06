 require(readxl)
 require(RMySQL)
 
dbh <- dbConnect(MySQL(), user="gxh", password="locoy", dbname="ying", host="192.168.137.172")
 # dbSendQuery(dbh,'SET NAMES utf8 ')
 # dbListTables(dbh)
 
 # E:\user_tony\download\hk_w_sg
 list_e <-as.data.frame(read_excel("E:\\user_tony\\download\\hk_w_sg\\list_e_2016-03-181.xls", sheet = 1, col_names = TRUE, na = "",skip = 0))
 
 #my.dataframe$new.col <- a.vector
 # list_e$dt <- Sys.Date()
 list_e$dt <- '2016-03-18'
 
 #View(list_e)
 
 dbWriteTable(dbh, 'hk_w_sg_AM_imported', list_e, row.names = FALSE, overwrite = TRUE)
 dbSendQuery(dbh,'call ying.hk_w_sg_AM_import();')
 
 # dbSendQuery(dbh,'INSERT INTO `ying_calc`.`hk_w_xts_sg` (`code`, `close`, `turnover`, `chgrate`, `buy`, `sell`, `uPrice`, `dt`, `premium`, `gear`, `os`, `oRate`, `iv`, `delta`, `vega`) SELECT     `hk_w_sg_imported`.`Code`,  `hk_w_sg_imported`.`Last(HKD)`, `hk_w_sg_imported`.`Turnover($K)`,     `hk_w_sg_imported`.`Change(%)`,     `hk_w_sg_imported`.`Bid(HKD)`,     `hk_w_sg_imported`.`Ask(HKD)`,     `hk_w_sg_imported`.`Underlying Price`,     `hk_w_sg_imported`.`dt`,     `hk_w_sg_imported`.`Premium(%)`, case when `hk_w_sg_imported`.`Eff.Gearing(x)` = 'N/A' then 0 when `hk_w_sg_imported`.`Eff.Gearing(x)` <> 'N/A' then `hk_w_sg_imported`.`Eff.Gearing(x)` END,     `hk_w_sg_imported`.`Outstanding(M)`,     `hk_w_sg_imported`.`Outstanding(%)`,     `hk_w_sg_imported`.`IV(%)`,     `hk_w_sg_imported`.`Delta(%)`,     `hk_w_sg_imported`.`Vega` FROM `ying_calc`.`hk_w_sg_imported` ON DUPLICATE KEY UPDATE `code` = `hk_w_sg_imported`.`Code`;')

 
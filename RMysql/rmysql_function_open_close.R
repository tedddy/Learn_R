library(RMySQL)

sqlQuery <- function (query) {
    
    # creating DB connection object with RMysql package
    DB <- dbConnect(MySQL(), user="gxh", password='locoy', dbname='ying_calc', host='192.168.137.172')
    
    # send Query to btain result set
    rs <- dbSendQuery(DB, query)
    
    # get elements from result sets and convert to dataframe
    result <- fetch(rs, -1)
    
    # close db connection
    dbDisconnect(DB)
    
    # return the dataframe
    return(result)
}
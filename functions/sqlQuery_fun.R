require(RMySQL)

sqlQuery <- function (query) {
    DB <- dbConnect(MySQL(), user="gxh", password='locoy', dbname='ying', host='192.168.137.172')
    rs <- dbSendQuery(DB, query)
    # get elements from result sets and convert to dataframe
    result <- fetch(rs, -1)
    # close db connection
    dbDisconnect(DB)
    # return the dataframe
    return(result)
}
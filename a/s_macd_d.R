require(quantmod)
require(RMySQL)

source('~/lr/functions/sqlQuery_fun.R')

source('~/lr/functions/s_macd_daily_fun.R')

# run daily begin
s_info <- sqlQuery("SELECT `ids` FROM ying.s_info;")
s_info$ids

for (ids in s_info$ids) {
    # fun_s_macd_daily(ids,limit = '9999')
    fun_s_macd_daily(ids)
}
# run daily end

require(quantmod)
require(RMySQL)

source('~/lr/functions/sqlQuery_fun.R')

source('~/lr/functions/s_macd_daily_fun.R')


# fun_s_macd_daily('399934',limit = '9999')

# run daily begin
s_info <- sqlQuery("SELECT `ids` FROM ying_calc.s_info;")
s_info$ids

for (ids in s_info$ids) {
    fun_s_macd_daily(ids,limit = '9999')
}
# run daily end

require(quantmod)
require(RMySQL)

source('~/lr/functions/sqlQuery_fun.R')

source('~/lr/functions/i_macd_daily_fun.R')


# fun_i_macd_daily('399934',limit = '9999')

# run daily begin
i_FJ_info <- sqlQuery("SELECT `idi`, `name_i` FROM ying.i_info WHERE `fFJ`='1' or `fW`='1';")
i_FJ_info$idi

for (idi in i_FJ_info$idi) {
    # fun_i_macd_daily(idi,limit = '9999')
    fun_i_macd_daily(idi)
}
# run daily end

# fun_i_macd_daily('399006')

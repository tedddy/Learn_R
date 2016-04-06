require(quantmod)
require(RMySQL)

source('~/lr/functions/sqlQuery_fun.R')

source('~/lr/functions/i_macd_daily_fun.R')


# fun_i_macd_daily('399934',limit = '9999')

# run daily begin
i_FJ_info <- sqlQuery("SELECT `idi`, `name_i` FROM ying_calc.i_info WHERE `fFJ`='1';")
i_FJ_info$idi

for (idi in i_FJ_info$idi) {
    fun_i_macd_daily(idi,limit = '9999')
}
# run daily end

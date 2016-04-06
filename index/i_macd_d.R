require(quantmod)
require(RMySQL)

<<<<<<< HEAD
source('~/lr/functions/sqlQuery_fun.R')

source('~/lr/functions/i_macd_daily_fun.R')
=======
source('~/lr/index/functions/sqlQuery_fun.R')

source('~/lr/index/functions/i_macd_daily_fun.R')
>>>>>>> 0f6f883da0901e80f28aaeb70a24a36f5a01172b


# fun_i_macd_daily('399934',limit = '9999')

# run daily begin
i_FJ_info <- sqlQuery("SELECT `idi`, `name_i` FROM ying.i_info WHERE `fFJ`='1' or `fW`='1';")
i_FJ_info$idi

for (idi in i_FJ_info$idi) {
    # fun_i_macd_daily(idi,limit = '9999')
    fun_i_macd_daily(idi)
}
# run daily end
<<<<<<< HEAD
=======



>>>>>>> 0f6f883da0901e80f28aaeb70a24a36f5a01172b

# fun_i_macd_daily('399006')

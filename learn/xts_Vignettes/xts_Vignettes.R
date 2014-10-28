require(xts)

data(sample_matrix)

class(sample_matrix)

str(sample_matrix)

# !!! 'Date' instead of 'date'
matrix_xts <- as.xts(sample_matrix,dateformat='Date')

str(matrix_xts)

df_xts <- as.xts(as.data.frame(sample_matrix), important='very implortant information')

str(df_xts)

View(df_xts)

# Creating new data: the xts constructor

xts(1:10,Sys.Date()+1:10)

View(xts(1:10,Sys.Date()+1:10))

matrix_exact <- matrix_xts['2007-03']

View(matrix_exact)

matrix_exact_before20070107 <- matrix_xts['/2007-01-07']

View(matrix_exact_before20070107)

first(matrix_xts,'1 week')

first(last(matrix_xts,'1 week'),'3 days')

indexClass(matrix_xts)

axTicksByTime(matrix_xts, ticks.on='months')

plot(matrix_xts[,1],major.ticks = 'months',minor.ticks = FALSE,main=NULL,col=3)

# Calculate periodicity
periodicity(matrix_xts)

endpoints(matrix_xts,on='months')

endpoints(matrix_xts,on='weeks')

to.period(matrix_xts, 'months')

periodicity(to.period(matrix_xts,'months'))

to.monthly(matrix_xts)

period.apply(matrix_xts[,4],INDEX=endpoints(matrix_xts),FUN=max)

endpoints(matrix_xts)

apply.monthly(matrix_xts[,4],FUN=max)

apply.weekly(matrix_xts[,4],FUN=max)

matrix_xts

apply.monthly(matrix_xts[,4],FUN=min)

period.max(matrix_xts[,4], endpoints(matrix_xts))

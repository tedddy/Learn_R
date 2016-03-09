library(xts)
data(sample_matrix)
head(sample_matrix)

sample.xts <- as.xts(sample_matrix, descr='my new xts object')
class(sample.xts)

str(sample.xts)

head(sample_matrix)

attr(sample.xts, 'descr')

head(sample.xts['2007'])

head(sample.xts['2007-03/'])

head(sample.xts['2007-03-06/2007'])

sample.xts['2007-01-03']

data(sample_matrix)
plot(sample_matrix)
plot(as.xts(sample_matrix))
plot(as.xts(sample_matrix), type = 'candles')

xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))
head(xts.ts)
as.POSIXct("1970-01-01")
apply.monthly(xts.ts, function(x) var(x))
apply.monthly(xts.ts, function(x) mean(x))
apply.monthly(xts.ts, mean)
apply.monthly(xts.ts, var)

data("sample_matrix")
to.period(sample_matrix)
class(to.period(sample_matrix))

samplexts <- as.xts(sample_matrix) 
to.period(samplexts)
class(to.period(samplexts))

temp <- period.max(c(1,1,4,2,2,6,7,8,-1,20),c(0,3,5,8,10))
temp <- period.max(c(1,1,4,2,2,6,7,8,-1,20),c(0,10))
View(temp)

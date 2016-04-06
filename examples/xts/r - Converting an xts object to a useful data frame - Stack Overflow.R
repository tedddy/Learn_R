library(xts)

dat <- read.zoo(text='timestamp,value 
                "2013-06-02 00:00:00",70 
                "2013-06-02 00:02:00",70 
                "2013-06-02 00:07:00",60 
                "2013-06-02 00:15:00",70 
                "2013-06-02 00:12:00",60 
                "2013-06-02 00:30:00",70 
                "2013-06-02 00:45:00",70 
                "2013-06-02 01:00:00",70'
                ,tz ='' , format = "%Y-%m-%d %H:%M:%S",header=TRUE, sep=',')

View(dat)

class(dat)

d2 <- as.xts(dat)

ends <- endpoints(d2, on = "minutes", k = 15) 

d3 <- period.apply(d2, ends, mean)

data(sample_matrix)

endpoints(sample_matrix)
endpoints(sample_matrix, 'weeks')


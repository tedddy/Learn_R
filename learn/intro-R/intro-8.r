# R as a set of statistical tables

?beta()
d_beta()
?norm()
pnorm(0)
?pnorm()
2*pt(-2.43,df=13)

qf(0.01,2,7,lower.tail=FALSE)

# Examining the distribution of a set of data

attach(faithful)

summary(eruptions)

faithful_temp <- faithful

temp_faithful<- faithful

fivenum(eruptions)

stem(eruptions)

?stem()

hist(eruptions)

hist(eruptions, seq(1.6, 5.2, 0.2), prob=TRUE)

lines(density(eruptions, bw=0.1))

rug(eruptions)

lines(density(eruptions, bw="SJ"))

rug(eruptions)


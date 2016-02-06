
# Chapter 3 Lab: Linear Regression

library(MASS)
library(ISLR)

# Simple Linear Regression
View(Boston)
fix(Boston)
?fix
names(Boston)
attach(Boston)
lm.fit = lm(medv~lstat)
lm.fit
summary(lm.fit)
names(lm.fit)
lm.fit$coefficients
coef(lm.fit)
confint(lm.fit)
predict(lm.fit,data.frame(lstat=c(5,10,15)))
predict(lm.fit,data.frame(lstat=c(5,10,15)),interval="confidence")
predict(lm.fit,data.frame(lstat=c(5,10,15)),interval="prediction") #? interval="prediction"
plot(lstat,medv)
abline(lm.fit)
abline(lm.fit,lwd=3)
abline(lm.fit,lwd=3,col="red")
plot(lstat,medv,pch=20)
?plot
plot(lstat,medv,pch="+")
plot(1:20,1:20,pch=1:20)
par(mfrow=c(2,2))
plot(lm.fit)
predict(lm.fit)
predict_lm.fit<-predict(lm.fit)
residuals_lm.fit<-residuals(lm.fit)
View(residuals_lm.fit)
plot(predict_lm.fit,residuals_lm.fit)

plot(predict_lm.fit,rstudent(lm.fit))
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))

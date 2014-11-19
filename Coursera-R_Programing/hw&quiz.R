hw1_data <- read.csv("hw1_data.csv") # quote is required.
hw1_data[1,]
hw1_data[152:153,]
hw1_data[,1]
is.na(hw1_data[,1])
sum(is.na(hw1_data[,1]))
mean(hw1_data[,1])
hw1_data[,1][is.na(hw1_data[,1])] <- 0
good <- hw1_data[,1][!is.na(hw1_data[,1])]
mean(good)
# quiz question 18
u <- hw1_data[,1] > 31 & is.na(hw1_data[,1])==FALSE & hw1_data[,4] > 90 & is.na(hw1_data[,4])==FALSE
u
q18 <- hw1_data[u,]
mean(q18[,2])

# quiz question 19
q19 <- hw1_data[,5] == 
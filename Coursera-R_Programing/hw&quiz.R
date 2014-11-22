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
# q19 <- hw1_data["Month" == 6] # does not work.
u <- hw1_data[,5] == 6
q19_data <- hw1_data[u,]
q19_answer <- mean(q19_data[,4])

# quiz question 19
u <- hw1_data[,5] == 5 & is.na(hw1_data[,1]) == FALSE
q20_data <- hw1_data[u,]
q20_answer <- max(q20_data[,1])

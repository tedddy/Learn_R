# Download and unzip data 
    # dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
    # download.file(dataset_url, "diet_data.zip")
    # unzip("diet_data.zip", exdir = "diet_data")

list.files("diet_data")

andy <- read.csv("diet_data/andy.csv")

head(andy)

length(andy$Day)

dim(andy)

str(andy)

# ?str: Compactly Display the Structure of an Arbitrary R Object

summary(andy)

names(andy)

andy[1, "Weight"]

andy[30, "Weight"]


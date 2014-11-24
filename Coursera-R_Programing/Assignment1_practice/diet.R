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

andy[which(andy$Day == 30), "Weight"]

andy[which(andy$Day < 3), "Weight"]
# ?which example: which(andy$Day == 30); which(LETTERS == "R)

andy[which(andy[,"Day"] == 30), "Weight"]

subset(andy$Weight, andy$Day == 30)

andy_start  <- andy[1, "Weight"]
andy_end <- andy[30, "Weight"]

andy_loss <- andy_start - andy_end

andy_loss

# important

files <- list.files("diet_data")

# head(read.csv(files[3])) # not work

files_full <- list.files("diet_data", full.names=TRUE)

head(read.csv(files_full[3]))

andy_david <- rbind(andy, read.csv(files_full[2]))

head(andy_david)

tail(andy_david)

day_25 <- andy_david[which(andy_david$Day == 25), ]

dat <- data.frame()
for (i in 1:5) {
    dat <- rbind(dat, read.csv(files_full[i]))
}
str(dat)

median(dat$Weight)

median(dat$Weight, na.rm=TRUE)

dat_30 <- dat[which(dat$Day == 30), ]

dat[, "Day"]

dat[1, "Day"]

median(dat_30$Weight)

weightmedian <- function(directory, day) {
    filelist <- list.files(directory, full.name = TRUE)
    dat <- data.frame()
    for (i in 1:5) {
        dat <- rbind(dat, read.csv(files_full[i]))
    }
    dat_subset <- dat[which(dat[, "Day"] == day), ]
    median(dat_subset[, "Weight"], na.rm=TRUE)
}

weightmedian("diet_data", 25)

# Input objects: files_full & tmp (empty list)

summary(files_full)
tmp <- vector(mode = "list", length = length(files_full))

summary(tmp)

for (i in seq_along(files_full)) {
    tmp[[i]] <- read.csv(files_full[i])
}
str(tmp)

tmp_lapply <- lapply(files_full, read.csv)

output <- do.call(rbind, tmp)

str(output)

output_lapply <- do.call(rbind, tmp)


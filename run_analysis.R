##Download and unzip data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
setwd("~\data\UCI HAR Dataset")

##Read necessary files
activitylabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
test <- read.table("test/X_test.txt")
testact <- read.table("test/y_test.txt")
testsubj <- read.table("test/subject_test.txt")
train <- read.table("train/X_train.txt")
trainact <- read.table("train/y_train.txt")
trainsubj <- read.table("train/subject_train.txt")

##Combine subjects files
subjects <- rbind(testsubj, trainsubj)
names(subjects) <- "subject"

##Combine activity files
activities <- rbind(testact, trainact)
names(activities) <-"activity"

##Combine test and train data
data <- rbind(test, train)
names(data) <- features[,2]

##Extract measurements on mean and standard deviation from "data"
extract <- grep("mean\\(\\)|std\\(\\)", features$V2, value=TRUE)
datameansd <- data[,extract]

##Combine subject ID, activity code and data
fulldata <- cbind(subjects, activities, datameansd)

##Name activities in "fulldata"
names(activitylabels) <- c("activity", "activityname")
fulldata$activity <- activitylabels$activityname[fulldata$activity]

##Make variable names more descriptive
names(fulldata) <- gsub("^t", "time", names(fulldata))
names(fulldata) <- gsub("^f", "freq", names(fulldata))
names(fulldata) <- gsub("Acc", "Accelerometer", names(fulldata))
names(fulldata) <- gsub("Gyro", "Gyroscope", names(fulldata))
names(fulldata) <- gsub("Mag", "Magnitude", names(fulldata))
names(fulldata) <- gsub("BodyBody", "Body", names(fulldata))
names(fulldata) <- gsub("\\(\\)", "", names(fulldata))
names(fulldata) <- gsub("-", "", names(fulldata))
names(fulldata) <- gsub("mean", "Mean", names(fulldata))
names(fulldata) <- gsub("std", "Std", names(fulldata))

##Create final tidy data set that averages each variable
##for each activity and each subject
library(dplyr)
tidydata <- fulldata %>% 
                group_by(subject, activity) %>%
                summarize_each(funs(mean))
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)

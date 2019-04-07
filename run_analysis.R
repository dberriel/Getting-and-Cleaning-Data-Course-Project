#03-Apr-2019
#Diego Berriel
#Getting and Cleaning Data Course Project

#Loading package needed
library(dplyr)

#Praparing and dowloading data and data sets creation

zipfile <- "./data/UCI HAR Dataset.zip"
##File exists?
if (!file.exists("data")){
    dir.create("data")
}  
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, zipfile, method="curl")

##Unzip files into specific folder
if (!file.exists("./data/UCI HAR Dataset")) { 
    unzip(zipfile,exdir = "./data") 
}

##Data sets
###FEATURES AND ACTIVITIES
features <- data.table::fread("./data/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- data.table::fread("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
###TEST
subject_test <- data.table::fread("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- data.table::fread("./data/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- data.table::fread("./data/UCI HAR Dataset/test/y_test.txt", col.names = "code")
###TRAIN
subject_train <- data.table::fread("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- data.table::fread("./data/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- data.table::fread("./data/UCI HAR Dataset/train/y_train.txt", col.names = "code")


##1- Merges the training and the test sets to create one data set.
xdata <- rbind(x_train, x_test)
ydata <- rbind(y_train, y_test)
subjectdata <- rbind(subject_train, subject_test)
mergeddata <- cbind(subjectdata, ydata, xdata)

##2- Extracts only the measurements on the mean and standard deviation for each measurement
auxtidydata <- mergeddata %>% select(subject, code, contains("mean"), contains("std"))
###Memory cleanup
rm(mergeddata)
rm(xdata)
rm(ydata)
rm(subjectdata)
rm(subject_test)
rm(x_test)
rm(y_test)
rm(subject_train)
rm(x_train)
rm(y_train)

##3- Uses descriptive activity names to name the activities in the data set.
auxtidydata$code <- activities[auxtidydata$code, 2]

##4- Desciptive name for activity column
names(auxtidydata)[2] = "activity"
names(auxtidydata)<-gsub("mean", "Mean", names(tidydata), ignore.case = TRUE)
names(auxtidydata)<-gsub("std", "STD", names(tidydata), ignore.case = TRUE)
names(auxtidydata)<-gsub("angle", "Angle", names(auxtidydata))
names(auxtidydata)<-gsub("gravity", "Gravity", names(auxtidydata))
names(auxtidydata)<-gsub("Acc", "Accelerometer", names(auxtidydata))
names(auxtidydata)<-gsub("Gyro", "Gyroscope", names(auxtidydata))
names(auxtidydata)<-gsub("BodyBody", "Body", names(auxtidydata))
names(auxtidydata)<-gsub("Mag", "Magnitude", names(auxtidydata))
names(auxtidydata)<-gsub("^t", "Time", names(auxtidydata))
names(auxtidydata)<-gsub("^f", "Frequency", names(auxtidydata))
names(auxtidydata)<-gsub("Freq", "Frequency", names(tidydata), ignore.case = TRUE)
names(auxtidydata)<-gsub("tBody", "TimeBody", names(auxtidydata))

##5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- auxtidydata %>%
    group_by(subject, activity) %>%
    summarise_all(list(mean))
write.table(tidydata, "tidydata.txt", row.name=FALSE, quote = FALSE)

##Data Visualization
View(tidydata)

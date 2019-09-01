setwd("C:/Users/trint/Desktop/UCI HAR Dataset")

features = read.table("features.txt", col.colnames = c("n","functions"))
activities = read.table("activity_labels.txt", col.colnames = c("code", "activity"))

subject_test = read.table("test/subject_test.txt", col.colnames = "subject")
x_test = read.table("test/X_test.txt", col.colnames = features$functions)
y_test = read.table("test/y_test.txt", col.colnames = "code")

subject_train = read.table("train/subject_train.txt", col.colnames = "subject")
x_train=- read.table("train/X_train.txt", col.colnames = features$functions)
y_train = read.table("train/y_train.txt", col.colnames = "code")

# create one dataset for tr and te, named as data
data = cbind(subject_train,x_train,y_train)
data2 = cbind(subject_test,x_test,y_test)
data = rbind(data,data2)
rm(data2)

#Extracts only the measurements on the mean and standard deviation for each measurement.
str(data)
library(dplyr)
data2 = data %>% select (subject,code,contains("mean"),contains("std"))

#Uses descriptive activity colnames to name the activities in the data set
data2 = merge(data2,activities,by = "code")
data2 = data2[order(data2$subject),]

#Appropriately labels the data set with descriptive variable colnames.
colnames(data2) = gsub("^t", "Time", colnames(data2))
colnames(data2) = gsub("^f", "Frequency", colnames(data2))
colnames(data2) = gsub("Acc", "Accelerometer", colnames(data2))
colnames(data2) = gsub("Gyro", "Gyroscope", colnames(data2))
colnames(data2) = gsub("BodyBody", "Body", colnames(data2))
colnames(data2) = gsub("Mag", "Magnitude", colnames(data2))
colnames(data2) = gsub("tBody", "TimeBody", colnames(data2))
colnames(data2) = gsub("-mean()", "Mean", colnames(data2), ignore.case = TRUE)
colnames(data2) = gsub("-std()", "STD", colnames(data2), ignore.case = TRUE)
colnames(data2) = gsub("-freq()", "Frequency", colnames(data2), ignore.case = TRUE)
colnames(data2) = gsub("angle", "Angle", colnames(data2))
colnames(data2) = gsub("gravity", "Gravity", colnames(data2))
colnames(data2)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata = data2 %>% group_by(activity, subject) %>% summarise_all(funs(mean))
str(tidydata)
write.table(tidydata, "tidydata.txt", row.name=FALSE)

#output
tidydata

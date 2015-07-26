## 1. Merge the training and the test sets to create one data set.
# read metadata and column names
activityLabels <- read.table("activity_labels.txt", col.names = c("activity_id","activity_label"))
setCols <- read.table("features.txt")
setColVector <- as.vector(setCols$V2)
rm(setCols)

# read data for test set
testSet <- read.table("./test/X_test.txt", quote="\"", col.names=setColVector)
testSubject <- read.table("./test/subject_test.txt", col.names = c("subject_id"))
testActivity <- read.table("./test/y_test.txt", col.names = c("activity_id"))

# convert activity codes to labels
testActivity$activity_id <- as.factor(testActivity$activity_id)
levels(testActivity$activity_id) <- activityLabels$activity_label

# merge test set
testData <- cbind(testSubject, testActivity, testSet)
colnames(testData)[2] <- "activity"

# free up some RAM
rm(testSet, testSubject, testActivity)

# read data for training set
trainingSet <- read.table("./train/X_train.txt", quote="\"", col.names=setColVector)
trainingSubject <- read.table("./train/subject_train.txt", col.names = c("subject_id"))
trainingActivity <- read.table("./train/y_train.txt", col.names = c("activity_id"))

# convert activity codes to labels
trainingActivity$activity_id <- as.factor(trainingActivity$activity_id)
levels(trainingActivity$activity_id) <- activityLabels$activity_label

# merge training set
trainingData <- cbind(trainingSubject, trainingActivity, trainingSet)
colnames(trainingData)[2] <- "activity"

# free up some RAM
rm(trainingSet, trainingSubject, trainingActivity)

# merge test and training data sets
allData <- rbind(testData, trainingData)

# free up some RAM
rm(testData, trainingData)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)
meanstdData <- select(allData, subject_id, activity, contains("mean"), contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set
# Already took care of this step while loading the data

## 4. Appropriately labels the data set with descriptive variable names. 
# Already took care of this step while loading the data

## From the data set in step 4, create a second, independent tidy data set with the 
## average of each variable for each activity and each subject.
library(reshape2)
meltedData <- melt(meanstdData, id.vars = c("subject_id","activity"))

# This is the wide tidy format
widetidyData <- dcast(meltedData, subject_id + activity ~ variable, mean)

# This is the tall tidy format
talltidyData <- melt(widetidyData, id.vars = c("subject_id","activity"))

# Output text files with tidy data
write.table(talltidyData, "talltidyData.txt", row.names = FALSE)
write.table(widetidyData, "widetidyData.txt", row.names = FALSE)

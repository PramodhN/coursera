# Read the features list
featuresList <- read.table("UCI HAR Dataset/features.txt")
featuresList[,2] <- gsub('-mean', 'Mean', featuresList[,2])
featuresList[,2] <- gsub('-std', 'Std', featuresList[,2])
featuresList[,2] <- gsub('[-()]', '', featuresList[,2])

extractedColumns <- grep(".*Mean.*|.*Std.*", featuresList[,2])
featuresList <- featuresList[extractedColumns,]

# Read the training data
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Combine training data to a single variable
train <- cbind(trainX, trainY, trainSub)

# Read the test data
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Combine test data to a single variable
test <- cbind(testX, testY, testSub)

# 1. Merge the training and the test sets to create one data set
mergedTrainTest <- rbind(train, test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
mergedTrainTest <- mergedTrainTest[,c(extractedColumns, 562, 563)]

# 3. Use descriptive activity names to name the activities in the data set
colnames(mergedTrainTest) <- c(featuresList[,2], "Activity", "Subject")

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

# 4. Appropriately label the data set with descriptive variable names
mergedTrainTest$Activity <- activityLabels[mergedTrainTest$Activity]

library(plyr)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidyDataset <- ddply(mergedTrainTest, .(Subject, Activity), function(x) colMeans(x[,1:(ncol(mergedTrainTest)-2)]))

# Writing tidy dataset into a file
write.table(tidyDataset, "tidyDataset.txt", sep="|", row.name=FALSE)
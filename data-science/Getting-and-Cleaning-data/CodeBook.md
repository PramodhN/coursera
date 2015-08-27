# Project Description

The data in the folder *UCI HAR Dataset* is provided for the course project. 
The objective is to create one R script called run_analysis.R that does the following. 

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Code description

Variables
---------
- featuresList - Contains list of features present in the file 'features.txt' in the given data set
- extractedColumns - Contains list of features that have 'mean' or 'std' in their name
- trainX - The table obtained from the file *UCI HAR Dataset/train/X_train.txt*
- trainY - The table obtained from the file *UCI HAR Dataset/train/Y_train.txt*
- trainSub - The table obtained from the file *UCI HAR Dataset/train/subject_train.txt*
- train - A column wise combination of *trainX, trainY and trainSub*
- testX - The table obtained from the file *UCI HAR Dataset/test/X_test.txt*
- testY - The table obtained from the file *UCI HAR Dataset/test/Y_test.txt*
- testSub - The table obtained from the file *UCI HAR Dataset/test/subject_test.txt*
- test - A column wise combination of *testX, testY and testSub*
- mergedTrainTest - Row wise combination of test and training data sets
- activityLabels - Reads the list of descriptions for activities
- tidyDataset - The cleaned data set created from the given training and test data

Implementation
--------------
- The first task for merging the training and test data sets is performed in the below line. The train and test variables contain the combined content of X, Y and subject files from training and testing data.
```
mergedTrainTest <- rbind(train, test)
```
- The second task of extracting mean and standard deviation measurements is performed in below line. Here, the variable *extractedColumns* is created using the features list extracted before. The columns 562 and 563 correspond to the Y and subject files.
```
mergedTrainTest <- mergedTrainTest[,c(extractedColumns, 562, 563)]
```
- The third task of giving a descriptive name for columns is done in below line. Here, the thing to be noted is that the variable *featuresList* already has updated names for the ones with 'mean' and 'std' in them.
```
colnames(mergedTrainTest) <- c(featuresList[,2], "Activity", "Subject")
```
- The fourth task of labeling the activities with their description is done in below line. Here, the variable *activityLabels* contains list of descriptions.
```
mergedTrainTest$Activity <- activityLabels[mergedTrainTest$Activity]
```
- The final task of grouping by subject and activity and then finding mean is done in below line. The ddply function is used from 'plyr' package.
```
tidyDataset <- ddply(mergedTrainTest, .(Subject, Activity), function(x) colMeans(x[,1:(ncol(mergedTrainTest)-2)]))
```

Specifications
--------------
- The package *plyr* should be installed in R

# Reference

I used a small portion of this code - https://github.com/eriky/coursera-getting-and-cleaning-data/blob/master/run_analysis.R 
I have used the idea behind extracting the columns from the list using the above code.

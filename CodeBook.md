## Data Set Description

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . 
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The attached R script (run_analysis.R) performs the following to clean up the data:

###1. Reads the following files into sub-datasets:

Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)

subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)

ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)

###2. Uses descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive activity names. 

The class labels linked with their activity names are loaded from the activity_labels.txt file:
*walking
*walkingupstairs
*walkingdownstairs
*sitting
*standing
*laying


activ <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
ytest$V1 <- factor(ytest$V1,levels=activ$V1,labels=activ$V2)
ytrain$V1 <- factor(ytrain$V1,levels=activ$V1,labels=activ$V2)

Each data frame of the data set is labeled - using the features.txt - with the information about the variables used on the feature vector. The Activity and Subject columns are also named properly before merging them to the test and train dataset.

features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(Xtest)<-features$V2
colnames(Xtrain)<-features$V2
colnames(ytest)<-c("Activity")
colnames(ytrain)<-c("Activity")
colnames(subtest)<-c("Subject")
colnames(subtrain)<-c("Subject")

###3. Merges the training and test sets to create one data set

The Activity and Subject columns are appended to the test and train data frames, and then are both merged in the CombinedData data frame.

###4. Extracts only the measurements on the mean and standard deviation for each measurement using mean() and sd().  

###5. Creates a second, independent tidy_data set with the average of each variable for each activity and each subject and saves it to tidy.dataset.txt file.

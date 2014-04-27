# source of the data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# script called run_analysis.R that does the following: 

# 0. 
# Reads files: test sets, training sets
library(data.table)


Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)

subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)

ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)


#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive activity names. 
activ <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
ytest$V1 <- factor(ytest$V1,levels=activ$V1,labels=activ$V2)
ytrain$V1 <- factor(ytrain$V1,levels=activ$V1,labels=activ$V2)

features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(Xtest)<-features$V2
colnames(Xtrain)<-features$V2
colnames(ytest)<-c("Activity")
colnames(ytrain)<-c("Activity")
colnames(subtest)<-c("Subject")
colnames(subtrain)<-c("Subject")



# 1. Merges the training and the test sets to create one data set.
test<-cbind(Xtest,ytest)
test<-cbind(test,subtest)
train<-cbind(Xtrain,ytrain)
train<-cbind(train,subtrain)
CombinedData<-rbind(test,train)


#Extracts only the measurements on the mean and standard deviation for each measurement. 

Data_mean<-sapply(CombinedData,mean,na.rm=TRUE)
Data_sd<-sapply(CombinedData,sd,na.rm=TRUE)


#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

DT <- data.table(CombinedData)
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy,file="tidy_dataset.csv",sep=",",row.names = FALSE)
# Save data for project submission
write.table(tidy, file="./tidy_dataset.txt", sep="\t", row.names=FALSE)

##course project
##Step 1: download files from web

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="rundata.zip", mode="wb")
unzip("rundata.zip", exdir=".")

##task 1: Merges the training and the test sets to create one data set.
##Step 2: read training files into R
subjectTrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
xTrain<-read.table("UCI HAR Dataset/train/X_Train.txt")
yTrain<-read.table("UCI HAR Dataset/train/y_Train.txt")
feature<-read.table("UCI HAR Dataset/features.txt")
features<-feature$V2
activity<-read.table("UCI HAR Dataset/activity_labels.txt")
activityL<-activity$V2


dim(subjectTrain)
dim(xTrain)
dim(yTrain)

names(subjectTrain)<-c("Subject")
names(yTrain)<-c("Activity")

names(xTrain)<-features

train<-cbind(subjectTrain, yTrain) ##add subject column to actviity column
train_set<-cbind(train, xTrain) ##add subject and actvity to training data set

##read test files into R
subjectTest<-read.table("UCI HAR Dataset/test/subject_test.txt")
xTest<-read.table("UCI HAR Dataset/test/X_test.txt")
yTest<-read.table("UCI HAR Dataset/test/y_test.txt")

dim(subjectTest)
dim(xTest)
dim(yTest)

names(subjectTest)<-c("Subject")
names(yTest)<-c("Activity")

names(xTest)<-features

test<-cbind(subjectTest, yTest) ##add subject to activity column
test_set<-cbind(test, xTest) ##add the above two columns to the test data set

##Step 3: combine train_set with test_setby row and sort based on subject
completeData<-rbind(train_set, test_set)
library(plyr)
complete<-arrange(completeData, Subject)
##check if sorting is successful
head(complete[,1:4])
tail(complete[,1:4])

##finished task 1

##task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
##Step 4: use grepl function to pick columns whose names contain mean or std and subset those columns using which condition
hint="Subject|Activity|mean|std"
h<-grepl(hint, names(complete))
complete_Data<-complete[,which(h==TRUE)]

##check data
names(complete_Data)

##I found that the column names containg meanFrequency are also included so need remove those 
hint2="meanFreq"
h2<-grepl(hint2,names(complete_Data))
final<-complete_Data[,which(h2==FALSE)]
names(final)

##finished task2

##task 3: Uses descriptive activity names to name the activities in the data set
##Step 5: replace 1 to 6 in Activity column with descriptive names using gsub
final$Activity<-as.character(final$Activity)

final$Activity<-gsub("1","WALKING", final$Activity, fixed=TRUE)
final$Activity<-gsub("2","WALKING_UPSTAIRS", final$Activity, fixed=TRUE)
final$Activity<-gsub("3","WALKING_DOWNSTAIRS", final$Activity, fixed=TRUE)
final$Activity<-gsub("4","SITTING", final$Activity, fixed=TRUE)
final$Activity<-gsub("5","STANDING", final$Activity, fixed=TRUE)
final$Activity<-gsub("6","LAYING", final$Activity, fixed=TRUE)

##finished task 3

##task 4: Appropriately labels the data set with descriptive variable names.
##Step 6: remove "()" from the old variable names to make them more readible
old<-names(final)
names(final)<-gsub("()","",old,fixed=TRUE)

##finished task 4

##task 5: From the data set in step 4, creates a second, independent tidy 
##data set with the average of each variable for each activity and each subject.
install.packages("dplyr")
library(dplyr)
temp<-group_by(final, Subject, Activity)
head(temp)
result<-summarise_each(temp, funs(mean))
head(result)
tail(result)

##finished task 5

##write the final dataset to a txt file for submit
write.table(result,"result.txt",row.names=FALSE)

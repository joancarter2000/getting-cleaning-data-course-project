# getting-cleaning-data-course-project
Getting cleaning data week 3 course project

This document describes how I got and cleaned the data about Human Activity Recognition Using Smartphones Dataset
Version 1.0. The information about how the data were collected and important documentations about this dataset can
be found in the README.txt associated with the original data.

THe following link is where I downloaded the orginal dataset:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In this repository, there are three files:
1. README.md: a file with description of the project and how I cleaned the original data based on the instructions
2. run_analysis.R: the complete R code I used to clean the data
3. CodeBook.md: a file with description of the variables of the final cleaned dataset

The followings are the steps I took to finish the project

Step1: download related files from the above link, unzip

task 1: Merges the training and the test sets to create one data set.
to finish this task, i read and clean training set and test sets seperately and then combine them into one dataset:

Step2:  read training files and test files into R 
training files I used including: 

UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_Train.txt
UCI HAR Dataset/train/y_Train.txt
UCI HAR Dataset/features.txt
UCI HAR Dataset/activity_labels.txt

test files I used including:

UCI HAR Dataset/test/subject_train.txt
UCI HAR Dataset/test/X_Train.txt
UCI HAR Dataset/test/y_Train.txt

Step 3: combine train_set with test_set by row and sort based on subject

task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
To finish this task,
Step 4: use grepl function to pick columns whose names contain mean or std and subset those columns using which 
condition

after step 4, I found that the column names containg meanFrequency are also included so need remove those using grepl again

task 3: Uses descriptive activity names to name the activities in the data set
Step 5: replace 1 to 6 in Activity column with descriptive names using gsub

task 4: Appropriately labels the data set with descriptive variable names.
Step 6: remove "()" from the old variable names to make them more readible using gsub

task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each
 activity and each subject

use group_by funciton in dplyr package to group the data based on subject and activity
then summarise_each function in the same package to calculate the mean for each measurement in each group.

The resulted new clean dataset was exported using write.table function for submission.




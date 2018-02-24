Instructions for run_analysis.R script for Coursera 'Getting and Cleaning Data' Course Project
==============================================================================================
## Purpose
Analyses 'Human Activity Recognition Using Smartphones Data Set' from UCI Machine Learning Repository

## Input Data
**Website**: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

**Data**: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

## Requirements
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Process
1. Download compressed file and extract files into directory 'UCI HAR Dataset' in current working directory
2. Load activity labels ie. WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
3. Load feature list ie. column labels
4. Load testing and training data using feature names for column names
5. Select only 'mean' & 'standard deviation' columns (with 'mean' or 'std' in the feature name)
6. Associate subjects and activities with the observations
7. Combine the testing and training datasets
8. Add the corresponding activity labels
9. Calculate the average for each variable for each subject/activity combination

### Process Notes
1. (Step 4 & 5) Column operations must be done on both testing and training sets before column feature vector alignment is disrupted by binding of subject and activity columns.
2. (Step 9) The 'wide' data from step 8 is converted into 'long' data by 'unpivoting' the data (in traditional data processing terms) purely so that it can be easily grouped by dcast(). The final result is in 'wide' form because 'long' form combines data from different domains (ie. most specific data subtype or class) in the same column, potentially causing confusion and misinterpretation.

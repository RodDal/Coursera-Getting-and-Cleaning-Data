# Coursera 'Getting and Cleaning Data' Course Project
# ===================================================
# Analyses 'Human Activity Recognition Using Smartphones Data Set' from UCI Machine Learning Repository
#    Website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#    Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Downloads input data files, combines the test & training sets, merges subject (person) & activity type
# data and calculates the mean of only the mean and standard deviation variables.

# Set up working directory within current directory
origDir <- getwd()
subDir <- "UCI HAR Dataset"
if (length(grep(paste0(subDir, "$"), origDir)) == 1) {	# Already in subDir from last run
   setwd("..")
}

# Download & extract zip file
if (!file.exists("HAR.zip")) {
   download.file("d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
              , destfile = "HAR.zip")
   unzip("HAR.zip")
}
setwd(subDir)

# Load Activities
# ===========================
act <- read.fwf("activity_labels.txt", c(1, -1, 18), header=FALSE, col.names=c("id", "activity"), stringsAsFactors=FALSE)

# Load Features
# ===========================
feat <- read.table("features.txt", header=FALSE, col.names=c("id", "feature"), stringsAsFactors=FALSE)
# Determine mean and std columns
mean_std_cols <- grep("(mean|std)", feat$feature)

# Test & Training Data
# ===========================
tst <- read.table("test/X_test.txt", header = FALSE)
trn <- read.table("train/X_train.txt", header = FALSE)
# Rename mean & std columns (V<n>) names those from features.txt (before new 'subject' & 'activity' columns cause misalignment)
colnames(tst)[mean_std_cols] <- feat$feature[mean_std_cols]
colnames(trn)[mean_std_cols] <- feat$feature[mean_std_cols]

# Select only mean & std columns
tst_ms <- tst[, mean_std_cols]
trn_ms <- trn[, mean_std_cols]

# Associate activity with measurements (before subject so that subject will be first column)
tst_act <- read.table("test/y_test.txt", header=FALSE, col.names=c("activityId"), stringsAsFactors=FALSE)
act_tst <- cbind(tst_act, tst_ms)

trn_act <- read.table("train/y_train.txt", header=FALSE, col.names=c("activityId"), stringsAsFactors=FALSE)
act_trn <- cbind(trn_act, trn_ms)

# Associate subject with measurements
tst_sub <- read.table("test/subject_test.txt", header=FALSE, col.names=c("subjectId"), stringsAsFactors=FALSE)
sub_act_tst <- cbind(tst_sub, act_tst)

trn_sub <- read.table("train/subject_train.txt", header=FALSE, col.names=c("subjectId"), stringsAsFactors=FALSE)
sub_act_trn <- cbind(trn_sub, act_trn)


# Combine the testing and training datasets 
comb <- rbind(sub_act_tst, sub_act_trn)


# Join with activity labels
actv <- merge(comb, act, by.x="activityId", by.y="id", all=TRUE)

# Unpivot to make 'skinny'
actMelt <- melt(actv, id=c("subjectId", "activity"))
actMlt <- actMelt[actMelt$variable!="activityId", ]	# Remove extra rows from activityId column


# Calculate the average for each variable for each subject/activity combination
actMean <- dcast(actMlt, subjectId + activity ~ variable, mean)

print("Results in data frame: actMean")

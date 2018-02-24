Code book for Coursera Getting and Cleaning Data course project
===============================================================

## Data frame: actMean (means of activity mean and standard deviation columns by subject and activity type)

### Features:

**subjectId**: Identifies the volunteer performing the activity

**activity**: Activity performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

**<79 measurements>**. 
    of the form "t[Body|Gravity][Acc|Gyro]{Jerk}{Mag}-[mean|std]\(){-[X|Y|Z]}". 
    
      Where:
* [] = Alternatives delimited by '|'
* {} = Optional
* t = time domain signals (vs. frequency domain signals)
* Body|Gravity = Actual acceleration is separated into gravity and body contributions
* Acc|Gyro = Measure from accelerometer or gyroscope
* Jerk = Rapid acceleration (derived)
* Mag = <not specified>
* X|Y|Z = Direction of movement in two horizontal planes and one vertical plane

Refer to downloaded data: UCI HAR Dataset/features_info.txt. 

Also see: [UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

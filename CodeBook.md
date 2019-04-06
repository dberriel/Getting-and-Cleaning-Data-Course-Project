# Code book for Coursera Getting and Cleaning Data course project

This code book explain and represent the tidydata datata set on this space. On the README.md file you will find more details about the data set, why this is created, purpose and objective; and additional information related to the source data and experiment.
## Data Set (tidydata)
The tidaydata is created using the run_analysis.r using R version 3.5.2 (2018-12-20) on Windows 10 and dplyr package version 0.8.0.1.
On this .r script you will find the below steps in order to get the complete tidydata analysis created.
### Praparing and dowloading data and data sets creation
Dataset downloaded and extracted under the folder called UCI HAR Dataset
### Auxiliary data set creation considering the right variables
- features from features.txt
The features selected on this database come from the Smartphones accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
- activities from activity_labels.txt 
  List of activities performed and measured
  - WALKING: subject was walking
  - WALKING_UPSTAIRS: subject was walking upstairs
  - WALKING_DOWNSTAIRS: subject was walking downstairs
  - SITTING: subject was sitting
  - STANDING: subject was standing
  - LAYING: subject was laying
- Test & Train data
  - subject_test from test/subject_test.txt
  contains test data of test subjects being observed
  - x_test from test/X_test.txt 
  contains features test data
  - y_test from test/y_test.txt 
  contains test data of activities
  - subject_train from test/subject_train.txt 
  contains train data subjects being observed
  - x_train from test/X_train.txt
  contains features train data
  - y_train from test/y_train.txt
  contains train data of activities
### Merges the training and the test sets to create one data set
The auxiliaries data sets are merged in order to get only one Merged data set: 
mergeddata is created by merging subjectdata, ydata (merge test and train data by rbind) and xdata (merge test and train data by rbind) using cbind() function.
### Extracts only the measurements on the mean and standard deviation for each measurement
tidydata is created by selecting only columns: subject, code and the measures that represent the mean and standard deviation (std).

### Uses descriptive activity names to name the activities in the data set.
Each activity code is replaced by the descriptive value from activities data set.

### Appropriately labels the data set with descriptive variable names
- The code column in tidydata is renamed as activity
- All Acc in column's name replaced by Accelerometer
- All Gyro in column's name replaced by Gyroscope
- All BodyBody in column's name replaced by Body
- All Mag in column's name replaced by Magnitude
- All start with character f in column's name replaced by Frequency
- All start with character t in column's name replaced by Time
- All Freq in column's name replaced by Frequency
- All mean in column's name replaced by Mean
- All std in column's name replaced by STD
- All angle in column's name replaced by Angle
- All gravity in column's name replaced by Gravity
- All tBody in column's name replaced by TimeBody

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidydata is created by sumarizing the means of each variable grouped by subject and activity.
Finally the tidiydata is written into tidydata.txt file.

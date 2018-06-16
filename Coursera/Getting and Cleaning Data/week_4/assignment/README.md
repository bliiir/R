| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :--- | :--- |
| Lecture       |[Peer-graded Assignment: Getting and Cleaning Data Course Project](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project) |
| Week          | [ 4 ](https://www.coursera.org/learn/data-cleaning/home/week/4) |
| Lecturer      | Peer-graded |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

---

## Required material
| Title | Type | Description |
| :--- | :--- | :--- |
| [Link](https://github.com/bliiir/R/tree/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment) | URL | Github repo with scripts performing the analysis |
| [codebook.md](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/codebook.md) | File | A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data |
| [README.md](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/README.md) | File | Explains how all of the scripts work and how they are connected |
| [run_analysis.R](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/run_analysis.R) | File | The R script |

---

# Assignment

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here [is] the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called ```run_analysis.R``` that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

---

# What the ```run_analysis.R``` script does
*(Table of contents)*

1. Get the data from the web
2. Load the data into R
3. Label the data
4. Merge the data
5. Subset the data
6. Average the data
7. Write the tidy data to file

---

# Solution walkthrough
## Part 1 - Get the data from the web
```r
# Clear the workspace
rm(list=ls())

# Load the data.table and plyr package
library(data.table)
library(plyr)

# Set the URL
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Create a temporary tempfile object to store the zipfile in
temp <- tempfile()

# Download the zip file
download.file(url, temp)

# Unzip the file in the working directory
unzip(temp)

# Remove temporary file
unlink(temp)
```

## Part 2 - Load the data
I used ```list.files(getwd(), recursive=F)``` to look what is in the working directory in order to set appropriate paths. I got the following output:
```
../UCI HAR Dataset/
    activity_labels.txt
    features_info.txt
    features.txt
    README.txt
    test/
        Inertial Signals/
            body_acc_x_test.txt
            body_acc_y_test.txt
            body_acc_z_test.txt
            body_gyro_x_test.txt
            body_gyro_y_test.txt
            body_gyro_z_test.txt
            total_acc_x_test.txt
            total_acc_y_test.txt
            total_acc_z_test.txt
        subject_test.txt
        X_test.txt
        y_test.txt
    train/
        Inertial Signals/
            body_acc_x_train.txt
            body_acc_y_train.txt
            body_acc_z_train.txt
            body_gyro_x_train.txt
            body_gyro_y_train.txt
            body_gyro_z_train.txt
            total_acc_x_train.txt
            total_acc_y_train.txt
            total_acc_z_train.txt
        subject_train.txt
        X_train.txt
        y_train.txt

```
From the assignment text, it sounds like the task is to concentrate on the following files:
```
../UCI HAR Dataset/
    test/
        subject_test.txt
        X_test.txt
        y_test.txt
    train/
        subject_train.txt
        X_train.txt
        y_train.txt
```
Continuing after reviewing the downloaded dataset

```r
# Set paths for script portability
path_data <- paste(getwd(), "/", "UCI HAR Dataset/", sep ="")
path_test <- paste(path_data, "test/", sep ="")
path_train <- paste(path_data, "train/", sep ="")

# Load the subject data
subjects_test <- fread(paste(path_test, "/subject_test.txt", sep=""))
subjects_train <- fread(paste(path_train, "/subject_train.txt", sep=""))

# Load the sensor data
sensors_test <- fread(paste(path_test, "/X_test.txt", sep="")) # 2947 x 561
sensors_train <- fread(paste(path_train, "/X_train.txt", sep=""))

# Load labels
labels_test <- fread(paste(path_test, "/Y_test.txt", sep=""))
labels_train <- fread(paste(path_train, "/Y_train.txt", sep=""))
labels_features <- fread(paste(path_data, "features.txt", sep=""))
labels_activity <- fread(paste(path_data, "activity_labels.txt", sep=""))
```
## Part 3 - label the data
```r
# Rename the variables appropriately
names(subjects_test) <- "subject"
names(subjects_train) <- "subject"
names(sensors_test) <- labels_features[[2]]
names(sensors_train) <- labels_features[[2]]
names(labels_test) <- "labels"
names(labels_train) <- "labels"
names(labels_features) <- c("variable", "feature")
names(labels_activity) <- c("labels", "activity")
```
## Part 4 - merge the data
```r
# cbind the two tables to create one big table
test <- cbind(subjects_test, labels_test)
train <- cbind(subjects_train, labels_train)

# Add a "set" column to both tables with either "test" or "train" corresponding to the tables. (I should probably have made this a factor variable)
test$set <- "test"
train$set <- "train"

# merge dataset with the activity label. To make sure we maintain correspondence with the sensor data, I set sort to FALSE.
test <- merge(test, labels_activity, by="labels", sort=F)
train <- merge(train, labels_activity, by="labels", sort=F)

# make activity labels lower case
test$activity <- tolower(test$activity)
train$activity <- tolower(train$activity)

# Remove the "labels" columns now that we've merged the verbose version of the label into the table under the name "activity"
test[ , labels:=NULL]
train[ , labels:=NULL]

# cbind the tables with the sensor data
test <- cbind(test, sensors_test)
train <- cbind(train, sensors_train)

# Now lets use rbind() to add the "train" dataset to the "test" dataset.
full <- rbind(test, train)
```
That solves
1. Merges the training and the test sets to create one data set.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.

I will now subset the full dataset to limit it to only the mean and standard deviations. I could have done this earlier, but I like having a full tidy dataset to go back to.

## Part 5 - Subset the data
```r
# Select feature variables with "std", "mean"
# - and also the non-feature variables "subject", "set", and "activity"
cols <- grep("std|mean|subject|set|activity", names(full))
```
At this point it turned out that the variable names in the feature set were preventing me from doing some regex operations. Apparently, R does not recognize a difference between for example "fBodyAcc-bandsEnergy()-25,48" and "fBodyAcc-bandsEnergy()-1,8", which throws the following error when using the select function:
>"Error: `data` must be uniquely named but has duplicate elements"

so I need to fix that and tidy the variable names by replacing parenthesis, dashes, commas and periods with underscores

```r
## Tidy up the names to enable subsetting
# ensure all names are unique
names(full) <- make.unique(names(full))
# Replace the characters "(", ".", ")", and "-"
names(full) <- gsub("\\(|\\.|,|\\)|-", "_", names(full))  with "_"
# Replace resulting tripple and double underscores with a single underscore
names(full) <- gsub("(___)|(__)", "_", names(full))
# Remove any underscores at the end of variable names
names(full) <- gsub("_$", "", names(full))
```
With that out of the way we can get back to the subsetting I started with the grep command further up
```r
# Subset the variables I used regex to select above
small <- select(full, cols)
```
Great - now we have a smaller dataset with only the subject, set, activity and standard deviation and mean feature variables.

Now for the last bit - average each feature for each subject and activity:

## Part 6 - average the data
```r
# Create a tidy dataset
tidy <- ddply(small, c("subject","activity"), numcolwise(mean))
```
That takes care of the last part of the assignment:
5. "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

Lets prove this by having the script with the table to a file called "tidy.txt"

## Part 7 - Write the tidy data to a file
```r
# Finally write the table to a file to document the script works
write.table(tidy, file="tidy.txt")
```

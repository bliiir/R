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

# Rename the variables appropriately
names(subjects_test) <- "subject"
names(subjects_train) <- "subject"
names(sensors_test) <- labels_features[[2]]
names(sensors_train) <- labels_features[[2]]
names(labels_test) <- "labels"
names(labels_train) <- "labels"
names(labels_features) <- c("variable", "feature")
names(labels_activity) <- c("labels", "activity")

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

# Select feature variables with "std", "mean"
# - and also the non-feature variables "subject", "set", and "activity"
cols <- grep("std|mean|subject|set|activity", names(full))

## Tidy up the names to enable subsetting
# ensure all names are unique
names(full) <- make.unique(names(full))

# Replace the characters "(", ".", ")", and "-"
names(full) <- gsub("\\(|\\.|,|\\)|-", "_", names(full))

# Replace resulting tripple and double underscores with a single underscore
names(full) <- gsub("(___)|(__)", "_", names(full))

# Remove any underscores at the end of variable names
names(full) <- gsub("_$", "", names(full))

# Subset the variables I used regex to select above
small <- select(full, cols)

# Create a tidy dataset
# First take the mean of the feature columns
tidy <- ddply(small, c("subject","activity", "set"), numcolwise(mean))
# Then split the data by activity so I get 6 subtables with the means for each subject
tidy <- split(tidy, tidy$activity)

# Finally write the table to a file to document the script works
write.table(tidy, file="tidy.txt")
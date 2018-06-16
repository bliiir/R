| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :--- | :--- |
| Lecture       |[Peer-graded Assignment: Getting and Cleaning Data Course Project](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project) |
| Week          | [ 4 ](https://www.coursera.org/learn/data-cleaning/home/week/4) |
| Lecturer      | Peer-graded |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

---

# Codebook

The data in the [tidy.txt](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/tidy.txt) dataset is based on the [UCI HAR Dataset](https://github.com/bliiir/R/tree/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/UCI%20HAR%20Dataset) provided in the same repository as this [codebook.md](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/codebook.md)

Except from the [README.md](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/UCI%20HAR%20Dataset/README.txt) file in the original dataset:


> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

See the full text in the original [README.md](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/UCI%20HAR%20Dataset/README.txt) file.

This data in tidy.txt is the result of a merger of the train and test data and subsequent reduction as descirbed below.

---

## Files in this derived dataset

The resources included in this, derived dataset are as follows:

| Title | Type | Description |
| :--- | :--- | :--- |
| [Link](https://github.com/bliiir/R/tree/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment) | URL | Github repo with scripts performing the analysis |
| [codebook.md](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/codebook.md) | File | A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data |
| [README.md](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/README.md) | File | Explains how all of the scripts work and how they are connected |
| [run_analysis.R](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/run_analysis.R) | File | The R script |
| [tidy.txt](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/tidy.txt) | File | The dataset resulting from running the "run_analysis.R" file |

---

## Files used to produce the tidy.txt 20Dataset

The data in the "tidy.txt" dataset is a merger of the following files:

##### Subject data
* ../UCI HAR Dataset/test/subject_test.txt
* ../UCI HAR Dataset/train/subject_train.txt

##### Sensor data
* ../UCI HAR Dataset/test/X_test.txt
* ../UCI HAR Dataset/train/X_train.txt

##### Labels
* ../UCI HAR Dataset/features.txt
* ../UCI HAR Dataset/activity_labels.txt
* ../UCI HAR Dataset/test/Y_test.txt
* ../UCI HAR Dataset/train/Y_train.txt

---

## Resulting dataset

The original dataset has been reduced to the mean of the mean and standard deviation features/variables per subject per activity in the [tidy.txt](https://github.com/bliiir/R/blob/master/Coursera/Getting%20and%20Cleaning%20Data/week_4/assignment/tidy.txt) dataset.

The two first variables are:

* subject: The id of the person wearing the sensor
* activity: The activity also denoted in the subtable header

The rest of the variables are the means of each of the standard deviations and mean variables from the original dataset.

The full set of variables are as follows:

## All variables
```
1                        subject
2                       activity
3                tBodyAcc_mean_X
4                tBodyAcc_mean_Y
5                tBodyAcc_mean_Z
6                 tBodyAcc_std_X
7                 tBodyAcc_std_Y
8                 tBodyAcc_std_Z
9             tGravityAcc_mean_X
10            tGravityAcc_mean_Y
11            tGravityAcc_mean_Z
12             tGravityAcc_std_X
13             tGravityAcc_std_Y
14             tGravityAcc_std_Z
15           tBodyAccJerk_mean_X
16           tBodyAccJerk_mean_Y
17           tBodyAccJerk_mean_Z
18            tBodyAccJerk_std_X
19            tBodyAccJerk_std_Y
20            tBodyAccJerk_std_Z
21              tBodyGyro_mean_X
22              tBodyGyro_mean_Y
23              tBodyGyro_mean_Z
24               tBodyGyro_std_X
25               tBodyGyro_std_Y
26               tBodyGyro_std_Z
27          tBodyGyroJerk_mean_X
28          tBodyGyroJerk_mean_Y
29          tBodyGyroJerk_mean_Z
30           tBodyGyroJerk_std_X
31           tBodyGyroJerk_std_Y
32           tBodyGyroJerk_std_Z
33              tBodyAccMag_mean
34               tBodyAccMag_std
35           tGravityAccMag_mean
36            tGravityAccMag_std
37          tBodyAccJerkMag_mean
38           tBodyAccJerkMag_std
39             tBodyGyroMag_mean
40              tBodyGyroMag_std
41         tBodyGyroJerkMag_mean
42          tBodyGyroJerkMag_std
43               fBodyAcc_mean_X
44               fBodyAcc_mean_Y
45               fBodyAcc_mean_Z
46                fBodyAcc_std_X
47                fBodyAcc_std_Y
48                fBodyAcc_std_Z
49           fBodyAcc_meanFreq_X
50           fBodyAcc_meanFreq_Y
51           fBodyAcc_meanFreq_Z
52           fBodyAccJerk_mean_X
53           fBodyAccJerk_mean_Y
54           fBodyAccJerk_mean_Z
55            fBodyAccJerk_std_X
56            fBodyAccJerk_std_Y
57            fBodyAccJerk_std_Z
58       fBodyAccJerk_meanFreq_X
59       fBodyAccJerk_meanFreq_Y
60       fBodyAccJerk_meanFreq_Z
61              fBodyGyro_mean_X
62              fBodyGyro_mean_Y
63              fBodyGyro_mean_Z
64               fBodyGyro_std_X
65               fBodyGyro_std_Y
66               fBodyGyro_std_Z
67          fBodyGyro_meanFreq_X
68          fBodyGyro_meanFreq_Y
69          fBodyGyro_meanFreq_Z
70              fBodyAccMag_mean
71               fBodyAccMag_std
72          fBodyAccMag_meanFreq
73      fBodyBodyAccJerkMag_mean
74       fBodyBodyAccJerkMag_std
75  fBodyBodyAccJerkMag_meanFreq
76         fBodyBodyGyroMag_mean
77          fBodyBodyGyroMag_std
78     fBodyBodyGyroMag_meanFreq
79     fBodyBodyGyroJerkMag_mean
80      fBodyBodyGyroJerkMag_std
81 fBodyBodyGyroJerkMag_meanFreq
```

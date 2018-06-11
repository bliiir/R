# Codebook
For the dataset in the file "tidy.txt" resulting from running the "run_analysis.R" file

There are six sub data-tables, one for each activity:
* laying
* sitting
* standing
* walking
* walking_downstairs
* walking_upstairs

Each of these tables have the following three first columns:
* subject: The id of the person wearing the sensor
* activity: The activity also denoted in the subtable header
* set: Which data set the data came from (test or train)

The rest of the variables correspond to the mean of the variables described in "features_info.txt" of the original data package.

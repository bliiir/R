

| Course | [R programming](https://www.coursera.org/learn/r-programming/home/welcome) | 
| :--- | :--- |
| Part | [Week 4, Simulation and Profiling](https://www.coursera.org/learn/r-programming/home/week/4) |
| Assignment | [Programming assignment 3](https://www.coursera.org/learn/r-programming/supplement/w1c7p/programming-assignment-3-instructions-hospital-quality) | 
| Institution | [Johns Hopkins University](https://www.jhu.edu/) | 
| Educators | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) | 
| Distribution | [Coursera](https://www.coursera.org) | 

# Hospital Quality

## Introduction

### Description

Download the file ProgAssignment3-data.zip file containing the data for Programming Assignment 3 from
the Coursera web site. Unzip the file in a directory that will serve as your working directory. When you
start up R make sure to change your working directory to the directory where you unzipped the data.

The data for this assignment come from the Hospital Compare web site (http://hospitalcompare.hhs.gov)
run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and
information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset essentially
covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining
whether hospitals should be fined for not providing high quality care to patients (see http://goo.gl/jAXFX
for some background on this particular topic).

The Hospital Compare web site contains a lot of data and we will only look at a small subset for this
assignment. The zip file for this assignment contains three files

- outcome-of-care-measures.csv: Contains information about 30-day mortality and readmission rates
for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.
- hospital-data.csv: Contains information about each hospital.
- Hospital_Revised_Flatfiles.pdf: Descriptions of the variables in each file (i.e the code book).

A description of the variables in each of the files is in the included PDF file named Hospital_Revised_Flatfiles.pdf.
This document contains information about many other files that are not included with this programming
assignment. You will want to focus on the variables for Number 19 (“Outcome of Care Measures.csv”) and
Number 11 (“Hospital Data.csv”). You may find it useful to print out this document (at least the pages for
Tables 19 and 11) to have next to you while you work on this assignment. In particular, the numbers of
the variables for each table indicate column indices in each table (i.e. “Hospital Name” is column 2 in the
outcome-of-care-measures.csv file).

## 1. Plot the 30-day mortality rates for heart attack

### Description

Read the outcome data into R via the read.csv function and look at the first few rows.

``` r
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
```

There are many columns in this dataset. You can see how many by typing ncol(outcome) (you can see
the number of rows with the nrow function). In addition, you can see the names of each column by typing
names(outcome) (the names are also in the PDF document.
To make a simple histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset),
run

``` r
outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])
```

Because we originally read the data in as character (by specifying colClasses = "character" we need to
coerce the column to be numeric. You may get a warning about NAs being introduced but that is okay.


### Submission

![Submission](https://github.com/bliiir/r-programming/blob/master/Week%204-%20Simulation%20and%20Profiling/Rplot.png)

------

## 2. Finding the best hospital in a state

### Description

Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do not have data on a particular
outcome should be excluded from the set of hospitals when deciding the rankings.

Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals “b”, “c”,
and “f” are tied for best, then hospital “b” should be returned).

The function should use the following template.

``` r
best <- function(state, outcome) {
        ## Read outcome data
        ## Check that state and outcome are valid
        ## Return hospital name in that state with lowest 30-day death
        ## rate
}
```

The function should check the validity of its arguments. If an invalid state value is passed to best, the
function should throw an error via the stop function with the exact message “invalid state”. If an invalid
outcome value is passed to best, the function should throw an error via the stop function with the exact
message “invalid outcome”.
Here is some sample output from the function.

``` r
source("best.R")
best("TX", "heart attack")
[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
```
``` r
> best("TX", "heart failure")
[1] "FORT DUNCAN MEDICAL CENTER"
```
``` r
> best("MD", "heart attack")
[1] "JOHNS HOPKINS HOSPITAL, THE"
```

``` r 
> best("MD", "pneumonia")
[1] "GREATER BALTIMORE MEDICAL CENTER"
```
``` r
> best("BB", "heart attack")
Error in best("BB", "heart attack") : invalid state
```
``` r
> best("NY", "hert attack")
Error in best("NY", "hert attack") : invalid outcome
```

Save your code for this function to a file named best.R

### Submission
#### Code

``` r
# Course:               R programming,
# Part:                 Week 4, Simulation and Profiling
# Assignment:           Programming assignment 3
# Institution:          Johns Hopkins University, 
# Educators:            Jeff Leek - PhD,  Roger D. Peng - PhD,  Brian Caffo - PhD

######################################################
# 2 Finding the best hospital in a state
######################################################


best <- function(state, outcome){
        
        # Read the file
        data_all <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        # limit the data frame to the relevant variables
        data_crop <- data_all[,c(2, 7, 11, 17, 23)]
        
        # Check that state and outcome are valid
        valid_states    <- unique(data_crop[, 2])
        valid_outcomes  <- c("heart attack", "heart failure", "pneumonia")
        if (!is.element(state, valid_states)) {stop("invalid state")}
        if (!is.element(outcome, valid_outcomes)) {stop("invalid outcome")}
        
        # Give the columns better names
        names(data_crop) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        # Discard the columns with irrelevant outcomes
        data_sub <- data_crop[, c("hospital", "state", outcome)]
        
        # limit the list to the desired state and outcome
        data_sub <- data_sub[data_sub[,3] != "Not Available" & data_sub[,2] == state,]
        
        # Convert outcome ranking column to numeric
        data_sub[,3] <- as.numeric(data_sub[,3])
        
        # Order data set
        ordered <- data_sub[order(data_sub[,3], data_sub[,1], decreasing = F), ]
        
        # Return best ranking hospital
        ordered[1,1]
}
```
#### Tests

```r
> source("best.R")
```
```r
> best("TX", "heart attack")
[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
```
```r
> best("TX", "heart failure")
[1] "FORT DUNCAN MEDICAL CENTER"
```
```r
> best("MD", "heart attack")
[1] "JOHNS HOPKINS HOSPITAL, THE"
```
```r
> best("MD", "pneumonia")
[1] "GREATER BALTIMORE MEDICAL CENTER"
```
```r
> best("BB", "heart attack")
Error in best("BB", "heart attack") : invalid state
```
```r
> best("NY", "hert attack")
Error in best("NY", "hert attack") : invalid outcome
```

------

## 3 Ranking hospitals by outcome in a state

### Description

Write a function called rankhospital that takes three arguments: the 2-character abbreviated name of a
state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
of the hospital that has the ranking specified by the num argument. For example, the call rankhospital("MD", "heart failure", 5) would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate for heart failure. The num argument can take values “best”, “worst”, or an integer indicating the ranking
(smaller numbers are better). If the number given by num is larger than the number of hospitals in that
state, then the function should return NA. Hospitals that do not have data on a particular outcome should
be excluded from the set of hospitals when deciding the rankings.

Handling ties. It may occur that multiple hospitals have the same 30-day mortality rate for a given cause
of death. In those cases ties should be broken by using the hospital name. For example, in Texas (“TX”),
the hospitals with lowest 30-day mortality rate for heart failure are shown here.
``` r
> head(texas)
Hospital.Name Rate Rank
3935 FORT DUNCAN MEDICAL CENTER 8.1 1
4085 TOMBALL REGIONAL MEDICAL CENTER 8.5 2
4103 CYPRESS FAIRBANKS MEDICAL CENTER 8.7 3
3954 DETAR HOSPITAL NAVARRO 8.7 4
4010 METHODIST HOSPITAL,THE 8.8 5
3962 MISSION REGIONAL MEDICAL CENTER 8.8 6
```

Note that Cypress Fairbanks Medical Center and Detar Hospital Navarro both have the same 30-day rate
(8.7). However, because Cypress comes before Detar alphabetically, Cypress is ranked number 3 in this
scheme and Detar is ranked number 4. One can use the order function to sort multiple vectors in this
manner (i.e. where one vector is used to break ties in another vector).

The function should use the following template.

``` r
rankhospital <- function(state, outcome, num = "best") {
                ## Read outcome data
                ## Check that state and outcome are valid
                ## Return hospital name in that state with the given rank
                ## 30-day death rate
}
```
The function should check the validity of its arguments. If an invalid state value is passed to rankhospital,
the function should throw an error via the stop function with the exact message “invalid state”. If an invalid
outcome value is passed to rankhospital, the function should throw an error via the stop function with
the exact message “invalid outcome”.

Here is some sample output from the function.

``` r
> source("rankhospital.R")
> rankhospital("TX", "heart failure", 4)
[1] "DETAR HOSPITAL NAVARRO"
```
```r
> rankhospital("MD", "heart attack", "worst")
[1] "HARFORD MEMORIAL HOSPITAL"
```
```r
> rankhospital("MN", "heart attack", 5000)
[1] NA
```

Save your code for this function to a file named rankhospital.R.

### Submission
#### Code
``` r
# Course:               R programming,
# Part:                 Week 4, Simulation and Profiling
# Assignment:           Programming assignment 3
# Institution:          Johns Hopkins University, 
# Educators:            Jeff Leek - PhD,  Roger D. Peng - PhD,  Brian Caffo - PhD

######################################################
# 3 Ranking hospitals by outcome in a state
######################################################

rankhospital <- function(state, outcome, num = "best"){
        
        # Read the file
        data_all <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        # limit the data frame to the relevant variables
        data_crop <- data_all[,c(2, 7, 11, 17, 23)]
        
        # Check that state and outcome are valid
        valid_states    <- unique(data_crop[, 2])
        valid_outcomes  <- c("heart attack", "heart failure", "pneumonia")
        if (!is.element(state, valid_states)) {stop("invalid state")}
        if (!is.element(outcome, valid_outcomes)) {stop("invalid outcome")}
        
        # Give the columns better names
        names(data_crop) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        # Discard the columns with irrelevant outcomes
        data_sub <- data_crop[, c("hospital", "state", outcome)]
        
        # limit the list to the desired state and outcome
        data_sub <- data_sub[data_sub[,3] != "Not Available" & data_sub[,2] == state,]
        
        # Convert outcome ranking column to numeric
        data_sub[,3] <- as.numeric(data_sub[,3])
        
        # Order data set
        if (num == "best") {
                ordered <- data_sub[order(data_sub[,3], data_sub[,1], decreasing = F), ]
                return(ordered[1,1])
        }
        else if (num == "worst"){
                ordered <- data_sub[order(data_sub[,3], rev(data_sub[,1]), decreasing = T), ]
                return(ordered[1,1])
        }
        else {
                ordered <- data_sub[order(data_sub[,3], data_sub[,1], decreasing = F), ]
                return(ordered[num,1])
        }
}
```
#### Tests
```r
> source("rankhospital.R")
```
```r
> rankhospital("TX", "heart failure", 4)
[1] "DETAR HOSPITAL NAVARRO"
```
```r
> rankhospital("MD", "heart attack", "worst")
[1] "HARFORD MEMORIAL HOSPITAL"
```
```r
> rankhospital("MN", "heart attack", 5000)
[1] NA
```

---

## 4 Ranking hospitals in all states

Write a function called rankall that takes two arguments: an outcome name (outcome) and a hospital ranking
(num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
containing the hospital in each state that has the ranking specified in num. For example the function call
rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
are the best in their respective states for 30-day heart attack death rates. The function should return a value
for every state (some may be NA). The first column in the data frame is named hospital, which contains
the hospital name, and the second column is named state, which contains the 2-character abbreviation for
the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
hospitals when deciding the rankings.

Handling ties. The rankall function should handle ties in the 30-day mortality rates in the same way
that the rankhospital function handles ties.

The function should use the following template.

``` r
rankall <- function(outcome, num = "best") {
                ## Read outcome data
                ## Check that state and outcome are valid
                ## For each state, find the hospital of the given rank
                ## Return a data frame with the hospital names and the
                ## (abbreviated) state name
}
```

NOTE: For the purpose of this part of the assignment (and for efficiency), your function should NOT call
the rankhospital function from the previous section.

The function should check the validity of its arguments. If an invalid outcome value is passed to rankall,
the function should throw an error via the stop function with the exact message “invalid outcome”. The num
variable can take values “best”, “worst”, or an integer indicating the ranking (smaller numbers are better).
If the number given by num is larger than the number of hospitals in that state, then the function should
return NA.

Here is some sample output from the function.

``` r
> source("rankall.R")
> head(rankall("heart attack", 20), 10)
hospital state
AK <NA> AK
AL D W MCMILLAN MEMORIAL HOSPITAL AL
AR ARKANSAS METHODIST MEDICAL CENTER AR
AZ JOHN C LINCOLN DEER VALLEY HOSPITAL AZ
CA SHERMAN OAKS HOSPITAL CA
CO SKY RIDGE MEDICAL CENTER CO
CT MIDSTATE MEDICAL CENTER CT
DC <NA> DC
DE <NA> DE
FL SOUTH FLORIDA BAPTIST HOSPITAL FL
```
```r
> tail(rankall("pneumonia", "worst"), 3)
hospital state
WI MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC WI
WV PLATEAU MEDICAL CENTER WV
WY NORTH BIG HORN HOSPITAL DISTRICT WY
```
```r
> tail(rankall("heart failure"), 10)
hospital state
TN WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL TN
TX FORT DUNCAN MEDICAL CENTER TX
UT VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER UT
VA SENTARA POTOMAC HOSPITAL VA
VI GOV JUAN F LUIS HOSPITAL & MEDICAL CTR VI
VT SPRINGFIELD HOSPITAL VT
WA HARBORVIEW MEDICAL CENTER WA
WI AURORA ST LUKES MEDICAL CENTER WI
WV FAIRMONT GENERAL HOSPITAL WV
WY CHEYENNE VA MEDICAL CENTER WY
```

Save your code for this function to a file named rankall.R.

### Submission
```r
# Course:               R programming,
# Part:                 Week 4, Simulation and Profiling
# Assignment:           Programming assignment 3
# Institution:          Johns Hopkins University, 
# Educators:            Jeff Leek - PhD,  Roger D. Peng - PhD,  Brian Caffo - PhD

# This code is an attempt to generalize as much of the the functionality of the prior three sub-assignments into 
# service functions enabling me to use the exact same structur for the best, rankhospital and rankall functions 
# The general service functions are at the top and the specific best, rankhospital and rankall functions are last

######################################################
# Services
######################################################

# Read file and subset dataframe
outcomes <- function(){
        
        # Read the file
        my_data <<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        # limit the data frame to the relevant variables
        my_data <<- my_data[,c(2, 7, 11, 17, 23)]
        
        # Convert outcome ranking columns to numeric to avoid 2 coming after 10 when sorting
        my_data[,3:5] <<- sapply(my_data[,3:5], as.numeric)
        
        # Give the columns better names
        names(my_data) <<- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        my_data
}

# Check compliance
compliance <- function(my_outcome, my_state = "all"){
        
        # Create tables with valid states and outcomes
        valid_states <- unique(my_data[, 2])
        valid_outcomes <- names(my_data[3:5])
        
        # Check if my_state is a an element of valid_states and stop with an error message if it isn't
        if (my_state != "all") {
                if (!is.element(my_state, valid_states)) {stop("invalid state")}
        }
        
        # Check if my_outcome is an element of valid_outcomes and stop with an error message if it isn't
        if (!is.element(my_outcome, valid_outcomes)) {
                stop("invalid outcome")
        }
}

# Subset my_states so it only contains my_state states and my_outcome outcomes
my_subset <- function(my_outcome = "all", my_state = "all"){
        if (my_state != "all"){my_data <<- my_data[my_data[ , 2] == my_state , ]}
        if (my_outcome != "all"){my_data <<- my_data[,c("hospital", "state", my_outcome)]}
        return(my_data)
}

# Sort the data
my_sort <- function(direction = "d"){
        if (direction == "d"){my_data <<- my_data[order(my_data[,3], my_data[,1], decreasing = F), ]}
        else if (direction == "a"){my_data <<- my_data[order(my_data[,3], rev(my_data[,1]), decreasing = T), ]}
}

# The workhorse - puts it all together and replaces, best, worst etc
my_num <- function(num = "best", direction = "d"){
        
        if(num == "worst"){direction <- "a"}
        
        # Sort the data
        my_sort(direction)
        
        # Split into a list of data frames by state
        my_data <<- split(my_data, my_data$state)
        
        # Find the length of the list
        len <- length(my_data)
        
        # Set row selection and sort direction
        if(num == "worst" || num == "best"){my_row <- 1}
        else if (is.numeric(num)){my_row <- num}
        
        # Create a data frame with rank num from each data frame in the list. 
        # I wanted to do this without a loop, but couldn't figure it out before the deadline
        res <- data.frame(row.names = 1)
        for (i in 1:len){
                new_row <- my_data[[i]][my_row,c(1,2)]
                res <- rbind(res, new_row)
        }
        
        res
}

# Initialise by reading the file and checking input validity
init <- function(my_outcome, my_state = "all"){
        
        # Get the data subset and make it available outside this function
        suppressWarnings(outcomes())
        
        # Check if the outcome input is an accepted value
        compliance(my_outcome = my_outcome, my_state = my_state)
}

######################################################
# 2 Finding the best hospital in a state
######################################################

# Get the best hospital in the given state for the given outcome
best <- function(state, outcome, num = "best"){
        init(my_outcome = outcome, my_state = state)
        my_subset(my_outcome = outcome, my_state = state)
        my_num(num)[,1]
}

######################################################
# 3 Ranking hospitals by outcome in a state
######################################################

# Get a hospital with a specific rank in a given state for a given outcome
rankhospital <- function(state, outcome, num = "best"){
        init(my_outcome = outcome, my_state = state)
        my_subset(my_outcome = outcome, my_state = state)
        my_num(num)[,1]
}

######################################################
# 4 Ranking hospitals in all states
######################################################

# Get the hospitals with a specific rank for each state - identical to the other non-service functions because state is set to "all" as default
rankall <- function(outcome, num = "best"){
        init(my_outcome = outcome)
        my_subset(my_outcome = outcome)
        my_num(num)
}

```

#### Tests
```r
> source("rankall.r")
```
```r
> best("TX", "heart attack")
[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
```
```r

> best("TX", "heart failure")
[1] "FORT DUNCAN MEDICAL CENTER"
```
```r

> best("MD", "heart attack")
[1] "JOHNS HOPKINS HOSPITAL, THE"
```
```r

> best("MD", "pneumonia")
[1] "GREATER BALTIMORE MEDICAL CENTER"
```
```r

> best("BB", "heart attack")
 Error in compliance(my_outcome = my_outcome, my_state = my_state) : 
  invalid state 
```
```r
> best("NY", "hert attack")
 Error in compliance(my_outcome = my_outcome, my_state = my_state) : 
  invalid outcome 
```
```r
> rankhospital("TX", "heart failure", 4)
[1] "DETAR HOSPITAL NAVARRO"
```
```r
> rankhospital("MD", "heart attack", "worst")
[1] "HARFORD MEMORIAL HOSPITAL"
```
```r
> rankhospital("MN", "heart attack", 5000)
[1] NA
```
```r
> head(rankall("heart attack", 20), 10)
                               hospital state
NA                                 <NA>  <NA>
59       D W MCMILLAN MEMORIAL HOSPITAL    AL
211   ARKANSAS METHODIST MEDICAL CENTER    AR
154 JOHN C LINCOLN DEER VALLEY HOSPITAL    AZ
564               SHERMAN OAKS HOSPITAL    CA
651            SKY RIDGE MEDICAL CENTER    CO
696             MIDSTATE MEDICAL CENTER    CT
NA1                                <NA>  <NA>
NA2                                <NA>  <NA>
808      SOUTH FLORIDA BAPTIST HOSPITAL    FL
```
```r
> tail(rankall("pneumonia", "worst"), 3)
                                       hospital state
4588 MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC    WI
4505                     PLATEAU MEDICAL CENTER    WV
4654           NORTH BIG HORN HOSPITAL DISTRICT    WY
```
```r
> tail(rankall("heart failure"), 10)
                                                              hospital state
3797                         WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL    TN
3935                                        FORT DUNCAN MEDICAL CENTER    TX
4237 VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER    UT
4341                                          SENTARA POTOMAC HOSPITAL    VA
4278                            GOV JUAN F LUIS HOSPITAL & MEDICAL CTR    VI
4275                                              SPRINGFIELD HOSPITAL    VT
4399                                         HARBORVIEW MEDICAL CENTER    WA
4561                                    AURORA ST LUKES MEDICAL CENTER    WI
4473                                         FAIRMONT GENERAL HOSPITAL    WV
4644                                        CHEYENNE VA MEDICAL CENTER    WY
```

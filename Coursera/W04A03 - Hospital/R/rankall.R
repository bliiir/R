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

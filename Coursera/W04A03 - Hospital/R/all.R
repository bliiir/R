# Course:               R programming,
# Part:                 Week 4, Simulation and Profiling
# Assignment:           Programming assignment 3
# Institution:          Johns Hopkins University, 
# Educators:            Jeff Leek - PhD,  Roger D. Peng - PhD,  Brian Caffo - PhD

######################################################
# 4 Ranking hospitals in all states
######################################################

prep <- function(state, outcome){
        
        # Read the file
        data_all <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        # Check that state and outcome are valid
        # ...
        
        # limit the data frame to the relevant variables
        data_crop <- data_all[,c(2, 7, 11, 17, 23)]
        
        # Give the columns better names
        names(data_crop) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        # Discard the columns with irrelevant outcomes
        data_sub <- data_crop[, c("hospital", "state", outcome)]
        
        # limit the list to the desired state and outcome
        data_sub <- data_sub[data_sub[,3] != "Not Available" & data_sub[,2] == state,]
        
        # Convert outcome ranking column to numeric
        data_sub[,3] <- as.numeric(data_sub[,3])
        
        # Return prepped data frame
        data_sub
}

# Find the best hospital for a given condition (outcome) in a given state (state)
best <- function(state, outcome) {
        
        # Prep data set
        selected <- prep(state, outcome)
        
        # Order data set
        ordered <- selected[order(selected[,3], selected[,1], decreasing = F), ]
        
        # Return best ranking hospital
        ordered[1,1]
}


worst <- function(state, outcome) {
        
        # Prep data set
        selected <- prep(state, outcome)
        
        # Order data set
        ordered <- selected[order(selected[,3], rev(selected[,1]), decreasing = T), ]
        
        # Return worst ranking hospital
        ordered[1,1]
}

# Rank hospital for a given condition (outcome) in a given state (state)
ranked <- function(state, outcome, num) {
        
        # Prep data set
        selected <- prep(state, outcome)
        
        # Order data set
        ordered <- selected[order(selected[,3], selected[,1], decreasing = F), ]
        
        # Return the ranked ranking data frame
        ordered[num, 1]
}

rankall <- function(){
        
}
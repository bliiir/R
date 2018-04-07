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

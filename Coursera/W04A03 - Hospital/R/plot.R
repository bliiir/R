# Course:               R programming,
# Part:                 Week 4, Simulation and Profiling
# Assignment:           Programming assignment 3
# Institution:          Johns Hopkins University, 
# Educators:            Jeff Leek - PhD,  Roger D. Peng - PhD,  Brian Caffo - PhD

######################################################
# 1 Plot the 30-day mortality rates for heart attack 
######################################################

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])
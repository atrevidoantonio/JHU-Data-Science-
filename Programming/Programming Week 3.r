## Part 1

setwd("~/Data/JHU/r_programming/")

#read in data
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

source(best)
best("TX", "heart attack")

source(rankhospital)
rankhospital("TX", "heart failure", 4)

source(rankall)
head(rankall("heart attack", 20), 10)

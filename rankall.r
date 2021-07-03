##Part 4: rankall.R:
rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that outcome is valid
  validOutcomes = c("heart attack", "heart failure", "pneumonia")
  if (!outcome %in% validOutcomes) {
    stop("invalid outcome")
  }
  ## Check that num is valid
  if (!(num=="best" || num=="worst" || num%%1==0))
    stop("invalid rank")
  ## Replace "Not Available" string with NA to avoid coercion warnings
  outcomeData[outcomeData == "Not Available"] <- NA
  ## Get column number for each valid outcome
  if (outcome %in% validOutcomes[1]) {
    colIndex <- which(colnames(outcomeData) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
  } else if (outcome %in% validOutcomes[2]) {
    colIndex <- which(colnames(outcomeData) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
  } else if (outcome %in% validOutcomes[3]) {
    colIndex <- which(colnames(outcomeData) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  }
  ## Make the valid outcome column numeric so the ordering will work correctly
  outcomeData[,c(colIndex)] <- sapply(outcomeData[,c(colIndex)], as.numeric)
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  states <- unique(outcomeData$State)
  states <- sort(states)
  stateRanks <- data.frame(hospital=NA, state=NA)
  for (i in 1:length(states)) {
    ## Get outcomes for this state only
    stateData <- subset(outcomeData, outcomeData$State==states[i])
    ## Sort stateData by chosen outcome and then Hospital Name, remove NA values
    stateData <- stateData[order(stateData[, colIndex], stateData[, "Hospital.Name"], na.last=NA), ]
    if (num=="best")
      stateNum <- 1
    else if (num=="worst")
      stateNum <- nrow(stateData)
    else
      stateNum <- num    
    if (stateNum > nrow(stateData))
      hospitalName <- NA
    else
      hospitalName <- stateData[stateNum, "Hospital.Name"]
    stateRanks[i, ] <- c(hospitalName, states[i])
  }
  stateRanks
}
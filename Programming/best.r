##Part 2: best.R:
best <- function(state, outcome) {
  ## Read outcome data
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  chosen_state <- state
  validOutcomes = c("heart attack", "heart failure", "pneumonia")
  if (!chosen_state %in% unique(outcomeData[["State"]])) {
    stop("invalid state")
  }
  if (!outcome %in% validOutcomes) {
    stop("invalid outcome")
  }
  ## subset data for selected state
  stateData <- subset(outcomeData, outcomeData$State == state)
  ## Replace "Not Available" string with NA 
  stateData[stateData == "Not Available"] <- NA
  ## Get column number for each valid outcome
  if (outcome %in% validOutcomes[1]) {
    colIndex <- which(colnames(stateData) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
  } else if (outcome %in% validOutcomes[2]) {
    colIndex <- which(colnames(stateData) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
  } else if (outcome %in% validOutcomes[3]) {
    colIndex <- which(colnames(stateData) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  }
  ## Make the valid outcome column numeric
  stateData[,c(colIndex)] <- sapply(stateData[,c(colIndex)], as.numeric)
  ## Sort stateData by chosen outcome and then Hospital Name, remove NA values
  stateData <- stateData[order(stateData[, colIndex], stateData[, "Hospital.Name"], na.last = NA), ]
  ## Return hospital name in that state with lowest 30-day death rate
  stateData[1, "Hospital.Name"]
}
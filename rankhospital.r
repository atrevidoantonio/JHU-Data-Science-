## Part 3, rankhospital
rankhospital <- function(state, outcome, num = "best") {
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
  ## Check that num is valid
  if (!(num == "best" || num == "worst" || num %% 1 == 0)){
    stop("invalid rank")
  }
  ## Now that we have a valid state get outcomes for this state only
  stateData <- subset(outcomeData, outcomeData$State == state)
  ## Replace "Not Available" string with NA to avoid coercion warnings
  stateData[stateData == "Not Available"] <- NA
  ## Get column number for each valid outcome
  if (outcome %in% validOutcomes[1]) {
    colIndex <- which(colnames(stateData) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")
  } 
  else if (outcome %in% validOutcomes[2]) {
    colIndex <- which(colnames(stateData) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")
  } 
  else if (outcome %in% validOutcomes[3]){
    colIndex <- which(colnames(stateData) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  }
  ## Make the valid outcome column numeric so the ordering will work correctly
  stateData[,c(colIndex)] <- sapply(stateData[,c(colIndex)], as.numeric)
  ## Sort stateData by chosen outcome and then Hospital Name, remove NA values
  stateData <- stateData[order(stateData[, colIndex], stateData[, "Hospital.Name"], na.last=NA), ]
  ## Return hospital name in that state with the given rank
  if (num=="best")
    num <- 1
  else if (num=="worst")
    num <- nrow(stateData)
  if (num > nrow(stateData))
    NA
  else
    stateData[num, "Hospital.Name"]
}
best <- function(state, outcome)
{
  hosp_data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hosp_state_data <- hosp_data[hosp_data[, 7] == state, ] 
  
  if (!state %in% hosp_state_data$State) 
  {
    stop("invalid state")
  }
  if(outcome == "heart attack")
  {
    hosp_state_data[, 11]<-as.numeric(hosp_state_data[, 11])
    min_pos <- which((hosp_state_data[, 11]) == (min(hosp_state_data[, 11], na.rm=TRUE)))
  }
  else if(outcome == "heart failure")
  {
    hosp_state_data[, 17]<-as.numeric(hosp_state_data[, 17])
    min_pos <- which((hosp_state_data[, 17]) == (min(hosp_state_data[, 17], na.rm=TRUE)))
  }
  else if(outcome == "pneumonia")
  {
    hosp_state_data[, 23]<-as.numeric(hosp_state_data[, 23])
    min_pos <- which((hosp_state_data[, 23]) == (min(hosp_state_data[, 23], na.rm=TRUE)))
  }
  else
  {
    stop("invalid outcome")
  }
  hosp_state_data[min_pos,2]
}
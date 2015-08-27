rankhospital <- function(state, outcome, num = "best") 
{
  hosp_data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  hosp_state_data <- hosp_data[hosp_data[, 7] == state, ] 
  
  if (!state %in% hosp_state_data$State) 
  {
    stop("invalid state")
  }  
  if(num == "best")
  {
    best(state, outcome)
  }
  else if(outcome == "heart attack")
  {
    rank_hosp_state_data(hosp_state_data, 11, num) 
  }
  else if(outcome == "heart failure")
  {
    
    rank_hosp_state_data(hosp_state_data, 17, num) 
  }
  else if(outcome == "pneumonia")
  {
    rank_hosp_state_data(hosp_state_data, 23, num) 
  }
  else
  {
    stop("invalid outcome")
  }
}

rank_hosp_state_data <- function(hosp_state_data, col_num, num) {
  hosp_state_data[, col_num]<-as.numeric(hosp_state_data[, col_num])
  if (num == "worst") {
    rank <- hosp_state_data[, 2][order(hosp_state_data[, col_num], hosp_state_data[, 2])[dim(hosp_state_data[!is.na(hosp_state_data[,11]), ])[1]]]
  }
  else{
    rank <- hosp_state_data[, 2][order(hosp_state_data[, col_num], hosp_state_data[, 2])[num]]
  }
  rank
}
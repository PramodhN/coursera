rankall <- function(outcome, num = "best") {
  
  hosp_data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  state_list <- sort(unique(hosp_data$State))

  output <- data.frame(hospital=character(),state=character())
  for(i in 1:length(state_list))
  {
    hosp_state_data <- hosp_data[hosp_data[, 7] == state_list[i], ]
    if (!state_list[i] %in% hosp_data$State) 
    {
      stop("invalid state")
    }  
    if(outcome == "heart attack")
    {
      rank <- rank_all_hosp_state_data(hosp_state_data, 11, num)
    }
    else if(outcome == "heart failure")
    {    
      rank <- rank_all_hosp_state_data(hosp_state_data, 17, num) 
    }
    else if(outcome == "pneumonia")
    {
      rank <- rank_all_hosp_state_data(hosp_state_data, 23, num) 
    }
    else
    {
      stop("invalid outcome")
    }
    
    x1<-output
    x2<-data.frame(hospital=rank,state=state_list[i])
    output<-rbind(x1,x2)
  }
  output
}

rank_all_hosp_state_data <- function(hosp_state_data, col_num, num) {
  hosp_state_data[, col_num]<-as.numeric(hosp_state_data[, col_num])
  if (num == "best") {
    rank <- hosp_state_data[, 2][order(hosp_state_data[, col_num], hosp_state_data[, 2])[1]]
  }
  else if (num == "worst") {
    rank <- hosp_state_data[, 2][order(hosp_state_data[, col_num], hosp_state_data[, 2])[dim(hosp_state_data[!is.na(hosp_state_data[,11]), ])[1]]]
  }
  else{
    rank <- hosp_state_data[, 2][order(hosp_state_data[, col_num], hosp_state_data[, 2])[num]]
  }
  return(rank)
}
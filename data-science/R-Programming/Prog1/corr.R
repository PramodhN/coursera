corr <- function(directory, threshold = 0) {
  corret<-numeric(0)
  data<-complete(directory)
  z<-data[1][data[2]>threshold]
  for(id in z)
  {
    filename<-prepfilename(id,directory)
    
    data<-read.csv(filename,header=TRUE)
    
    corret<-c(corret,cor(data[2],data[3],use="pairwise.complete.obs"))
  }
  corret
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
}
pollutantmean <- function(directory, pollutant, id = 1:332) {
  data<-data.frame()
  for(i in id)
  {
    filename<-prepfilename(i,directory)
    data1<-data
    data2<-read.csv(filename,header=TRUE)
    data<-rbind(data1,data2)
  }
  mean(data[, pollutant], na.rm = TRUE)
}
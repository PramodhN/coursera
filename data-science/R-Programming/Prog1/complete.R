complete <- function(directory, id = 1:332) {
  id1<-id
  x<-data.frame()
  for(id in id1)
  {
    filename<-prepfilename(id,directory)
    data<-read.csv(filename,header=TRUE)
    z<-!is.na(data[2]) & !is.na(data[3])
    nobs<-length(z[z==TRUE])
    x1<-x
    x2<-data.frame(id,nobs)
    x<-rbind(x1,x2)
  }
  x
}
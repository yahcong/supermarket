library(data.table)
setwd("D:/Rwork/CCF/supermarket")

train_test=function(data_sub,train_start,test_start,test_end){
  train_start=as.Date(train_start)
  test_start=as.Date(test_start)
  test_end=as.Date(test_end)
  train_data= data_sub[data_sub$sale_date>=train_start&data_sub$sale_date<test_start,]
  test_data = data_sub[data_sub$sale_date>=test_start,]
  #time
  length_train=difftime(test_start, train_start, units="days")
  train_time = seq.Date(from = as.Date(train_start,format = "%Y-%m-%d"),by = "day",length.out = length_train)
  train_time = as.data.frame(train_time)
  names(train_time)=c("sale_date")
  length_test=difftime(test_end, test_start, units="days")+1
  test_time = seq.Date(from = as.Date(test_start,format = "%Y-%m-%d"),by = "day",length.out = length_test)
  test_time=as.character(as.Date(test_time),format = "%Y%m%d")
  output <- list(train_data,test_data,train_time,test_time)
  return(output)
}

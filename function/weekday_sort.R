library(data.table)
library(xgboost)
library(lubridate)
library(magrittr)
library(mice)
library(data.table)
library(dplyr)
library(sampling)
library(ggplot2)
library(zoo)
library(forecast)
library(caret)
library(ipred)
require(RLightGBM)
#library(timeDate)
model_gbm_weekday = function(idnum,dt,train_time,test_time){
  #idnum= 1001
  #dt=train_data
  j=0
  dt = dt[dt$id==idnum,]
  dt = merge(train_time,dt,by = "sale_date",all = T)
  #dt$count[is.na(dt$count)] = ifelse(is.na(dt$id[is.na(dt$count)]),0,median(dt$count,na.rm = T))
  dt$count[is.na(dt$count)] = 0
  dt$id=idnum
  train_set=NULL
  k=14
  for(i in (k+1):nrow(dt)){
    temp=NULL
    temp$weekday=format(dt$sale_date[i],"%w")
    #temp$bianhao=j
    #j=j+1
    temp[c(paste0("x",1:k),"y")]=dt$count[(i-k):i]
    temp=as.data.frame(temp)
    train_set <- rbind(train_set,temp)
  }
  
  train_set$weekday=as.numeric(train_set$weekday)
  fitControl <- trainControl( method = "repeatedcv", number = 3, repeats = 3)
  set.seed(300)
  fit6 <- train(y ~ ., data = train_set, method = "gbm", trControl = fitControl,verbose = FALSE)  
  
  
  result_predict=NULL
  test_set=NULL
  
  test_set[c(paste0("x",1:k))] <- train_set[nrow(train_set),c(2:(k+1))]
  test_set=as.data.frame(test_set)
  # 
  # test_start=as.Date(c("2015-09-01"))
  # test_end=as.Date(c("2015-10-29"))
  test_start=as.Date(c("2015-07-01"))
  test_end=as.Date(c("2015-08-31"))
  length_test=difftime(test_end, test_start, units="days")+1
  test_time = seq.Date(from = as.Date(test_start,format = "%Y-%m-%d"),by = "day",length.out = length_test)
  test_time = as.data.frame(test_time)
  names(test_time)=c("sale_date")
  
  for(i in c(1:length(test_time$sale_date))){
    #print(i)
    #i=1
    test_set$weekday=format(test_time$sale_date[i],"%w")
    #test_set$weekday=as.numeric(test_set$weekday)
    test_set=test_set[,c(15,1,2,3,4,5,6,7,8,9,10,11,12,13,14)]
    test_set$weekday=as.numeric(test_set$weekday)
    test_set$y <- round(predict(fit6, test_set))
    result_predict=rbind(result_predict,test_set)
    
    test_set<- test_set[1,c(3:(k+2))]
    names(test_set) <- c(paste0("x",1:k))
    
  }
  
  pred_resu=NULL
  pred_resu$sale_date = test_time
  pred_resu$id = idnum
  pred_resu$x = round(result_predict$y)
  pred_resu=as.data.frame(pred_resu)
  pred_resu$sale_date=as.character(as.Date(pred_resu$sale_date),format = "%Y%m%d")
  pred_resu$x = as.numeric(pred_resu$x)
  
  return(pred_resu)
}


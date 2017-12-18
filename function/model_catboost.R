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
model_catboost = function(idnum,dt,train_time,test_time){
  #idnum=10
  #dt=train_data
  dt = dt[dt$id==idnum,]
  dt = merge(train_time,dt,by = "sale_date",all = T)
  #dt$count[is.na(dt$count)] = ifelse(is.na(dt$id[is.na(dt$count)]),0,median(dt$count,na.rm = T))
  dt$count[is.na(dt$count)] = 0
  train_set=NULL
  k=14
  for(i in (k+1):nrow(dt)){
    train_set <- rbind(train_set,dt$count[(i-k):i])
  }
  train_set <- as.data.frame(train_set)
  names(train_set) <- c(paste0("x",1:k),"y")
  
  fitControl <- trainControl( method = "repeatedcv", number = 4, repeats = 4)
  fit6 <- train(y ~ ., data = train_set, method = "gbm", trControl = fitControl,verbose = FALSE)  
  result_predict=NULL
  test_set =test_set <- train_set[nrow(train_set),c(2:(k+1))]
  names(test_set) <- c(paste0("x",1:k))
 

  for(i in test_time){
    test_set$y <- round(predict(fit6, data.matrix(test_set)))
    result_predict=rbind(result_predict,test_set)
    test_set <- test_set[1,c(2:(k+1))]
    names(test_set) <- c(paste0("x",1:k))
    
  }
  pred_resu=NULL
  pred_resu$sale_date = test_time
  pred_resu$id = idnum
  pred_resu$x = round(result_predict$y)
  
  pred_resu=as.data.frame(pred_resu)
  
  pred_resu$x = as.numeric(pred_resu$x)
  return(pred_resu)
}
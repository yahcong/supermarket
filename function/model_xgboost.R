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
model_xgboost= function(idnum,dt,date,pred_time){
  #idnum=1001
  #dt=train_data
  #date=train_time
  dt = dt[dt$id==idnum,]
  dt = merge(date,dt,by = "sale_date",all = T)
  dt$count[is.na(dt$count)] = ifelse(is.na(dt$id[is.na(dt$count)]),0,median(dt$count,na.rm = T))
  train_set=NULL
  k=14
  for(i in (k+1):nrow(dt)){
    train_set <- rbind(train_set,dt$count[(i-k):i])
  }
  train_set <- as.data.frame(train_set)
  names(train_set) <- c(paste0("x",1:k),"y")

  fit6 <- xgboost(data = data.matrix(train_set[,c(1:14)]),
                  label = train_set$y,
                  eta = 0.1,
                  max_depth = 10,
                  nround=500,
                  subsample = 1,
                  #colsample_bytree = 1
                  min_child_weight=5,
                  #gamma=10,
                  seed = 1

  )

  result_predict=NULL
  test_set =test_set <- train_set[nrow(train_set),c(2:(k+1))]
  names(test_set) <- c(paste0("x",1:k))
  for(i in pred_time){
    test_set$y <- round(predict(fit6, data.matrix(test_set)))
    result_predict=rbind(result_predict,test_set)
    test_set <- test_set[1,c(2:(k+1))]
    names(test_set) <- c(paste0("x",1:k))
    
  }
  pred_resu=NULL
  pred_resu$sale_date = pred_time
  pred_resu$id = idnum
  pred_resu$x = round(result_predict$y)
  
  pred_resu=as.data.frame(pred_resu)
  
  pred_resu$x = as.numeric(pred_resu$x)
  return(pred_resu)
}
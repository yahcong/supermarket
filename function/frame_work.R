library(data.table)
library(dplyr)
library(xgboost)
library(sampling)
library(ggplot2)
library(zoo)
library(forecast)
library(forecastxgb)
library(caret)
library(lubridate)
library(magrittr)
library(mice)
library(ipred)
setwd("D:/Rwork/CCF/supermarket")
#merge_test_predict
source("./function/merge_test_predict.R")
#model_bagging
source("./function/model_bagging.R")

#model_arima
source("./function/model_arima.R")
#model_rpart
source("./function/model_rpart.R")
#model_rf
#source("./function/model_rf.R")
#model_lm
source("./function/model_lm.R")
#model_gbm
source("./function/model_gbm.R")
#model_gbm_weekday
source("./function/weekday.R")
#model_randomForest
source("./function/model_randomForest.R")
#model_catboost
source("./function/model_catboost.R")
#model_xgboost
source("./function/model_xgboost.R")
#model_h2o
source("./function/model_h2o.R")
#model_HoltWinters
source("./function/model_HoltWinters.R")
#train_test
source("./function/train_test.R")

model_function=function(model,train_start,test_start,test_end){
  #读取数据---------------------------------------------------------------
  #data = fread("data/train.csv",stringsAsFactors=FALSE,encoding = "unknown")
  submission = fread("data/example.csv",stringsAsFactors=FALSE,encoding = "unknown")
  data_sub=fread("./test/data_sub.dat",stringsAsFactors=FALSE,encoding = "unknown")
  data_sub$sale_date = as.Date(data_sub$sale_date)
  
  #train and test
  train_start=as.Date(train_start)
  test_start=as.Date(test_start)
  test_end=as.Date(test_end)
  output= train_test(data_sub,train_start,test_start,test_end)
  train_data=output[[1]]
  test_data=output[[2]]
  train_time=output[[3]]
  test_time=output[[4]]

  
  predict_data = NULL
  for(id in unique(submission$bianma)){
    print(id)
    #id=10
    if(model=="model_bagging")
      sub = model_bagging(id,train_data,train_time,test_time)
    else if(model=="model_arima")
      sub = model_arima(id,train_data,train_time,test_time)
    else if(model=="model_rpart")
      sub = model_rpart(id,train_data,train_time,test_time)
    else if(model=="rf")
      sub = model_rf(id,train_data,train_time,test_time)
    else if(model=="model_lm")
      sub = model_lm(id,train_data,train_time,test_time)
    else if(model=="model_gbm")
      sub = model_gbm(id,train_data,train_time,test_time)
    else if(model=="model_gbm_weekday")
      sub = model_gbm_weekday(id,train_data,train_time,test_time)
    else if(model=="model_catboost")
      sub = model_catboost(id,train_data,train_time,test_time)
    else if(model=="model_randomForest")
      sub = model_randomForest(id,train_data,train_time,test_time)
    else if(model=="model_xgboost")
      sub = model_xgboost(id,train_data,train_time,test_time)
    else if(model=="model_h2o")
      sub = model_h2o(id,train_data,train_time,test_time)
    else if(model=="model_HoltWinters")
      sub = model_HoltWinters(id,train_data,train_time,test_time)
    predict_data = rbind(predict_data,sub)
  }
  backup=predict_data
  result=merge_test_predict(test_data,test_time,predict_data)
  return(result)
}


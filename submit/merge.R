rm(list=ls())
library(data.table)
setwd("D:/Rwork/CCF/supermarket")
#score
source("./function/score_depand_rmse.R")

bagging_result=fread("output/model_bagging.dat",stringsAsFactors=FALSE,encoding = "unknown")
arima_result=fread("output/model_arima.dat",stringsAsFactors=FALSE,encoding = "unknown")
gbm_weekday_result=fread("output/model_gbm_weekday.dat",stringsAsFactors=FALSE,encoding = "unknown")
rpart_result=fread("output/model_rpart.dat",stringsAsFactors=FALSE,encoding = "unknown")
#lm_result=fread("output/model_lm.dat",stringsAsFactors=FALSE,encoding = "unknown")
lm_result=fread("model_lm.dat",stringsAsFactors=FALSE,encoding = "unknown")

randomForest_result=fread("output/model_randomForest.dat",stringsAsFactors=FALSE,encoding = "unknown")
xgboost_result=fread("output/model_xgboost.dat",stringsAsFactors=FALSE,encoding = "unknown")
HoltWinters_result=fread("output/model_HoltWinters.dat",stringsAsFactors=FALSE,encoding = "unknown")
gbm_result=fread("output/model_gbm.dat",stringsAsFactors=FALSE,encoding = "unknown")

submission = fread("data/example.csv",stringsAsFactors=FALSE,encoding = "unknown")

select_score=fread("data/select_score.dat",stringsAsFactors=FALSE,encoding = "unknown")

result=NULL
for(idnum in unique(submission$bianma)){
  model=select_score$model[select_score$id==idnum]
  if(model=="model_bagging")
    sub = bagging_result[bagging_result$bianma==idnum,]
  else if(model=="model_arima")
    sub = arima_result[arima_result$bianma==idnum,]
  else if(model=="model_rpart")
    sub = rpart_result[rpart_result$bianma==idnum,]
  else if(model=="model_lm")
    sub = lm_result[lm_result$bianma==idnum,]
  else if(model=="model_gbm")
    sub = gbm_result[gbm_result$bianma==idnum,]
  else if(model=="model_gbm_weekday")
    sub = gbm_weekday_result[gbm_weekday_result$bianma==idnum,]
  else if(model=="model_randomForest")
    sub =randomForest_result[randomForest_result$bianma==idnum,]
  else if(model=="model_xgboost")
    sub = xgboost_result[xgboost_result$bianma==idnum,]
  else if(model=="model_HoltWinters")
    sub = HoltWinters_result[HoltWinters_result$bianma==idnum,]
  result=rbind(result,sub)
}
#3321,2013
for(idnum in unique(submission$bianma)){
  print(idnum)
  print(dim(result[result$bianma==idnum,]))
}

str(result)
write.csv(result,"output/merge_9.csv",row.names = F)

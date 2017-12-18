rm(list=ls())
library(data.table)
setwd("D:/Rwork/CCF/supermarket")
#score
source("./function/score_depand_rmse.R")

bagging_result=fread("data/model_bagging.dat",stringsAsFactors=FALSE,encoding = "unknown")
arima_result=fread("data/model_arima.dat",stringsAsFactors=FALSE,encoding = "unknown")
# gbm_weekday_result=fread("data/model_gbm_weekday.dat",stringsAsFactors=FALSE,encoding = "unknown")
# rpart_result=fread("data/model_rpart.dat",stringsAsFactors=FALSE,encoding = "unknown")
# lm_result=fread("data/model_lm.dat",stringsAsFactors=FALSE,encoding = "unknown")
# randomForest_result=fread("data/model_randomForest.dat",stringsAsFactors=FALSE,encoding = "unknown")
# xgboost_result=fread("data/model_xgboost.dat",stringsAsFactors=FALSE,encoding = "unknown")
# HoltWinters_result=fread("data/model_HoltWinters.dat",stringsAsFactors=FALSE,encoding = "unknown")
# gbm_result=fread("data/model_gbm.dat",stringsAsFactors=FALSE,encoding = "unknown")

gbm_weekday_result=fread("model_gbm_weekday.dat",stringsAsFactors=FALSE,encoding = "unknown")
rpart_result=fread("model_rpart.dat",stringsAsFactors=FALSE,encoding = "unknown")
lm_result=fread("model_lm.dat",stringsAsFactors=FALSE,encoding = "unknown")
randomForest_result=fread("model_randomForest.dat",stringsAsFactors=FALSE,encoding = "unknown")
xgboost_result=fread("model_xgboost.dat",stringsAsFactors=FALSE,encoding = "unknown")
HoltWinters_result=fread("model_HoltWinters.dat",stringsAsFactors=FALSE,encoding = "unknown")
gbm_result=fread("model_gbm.dat",stringsAsFactors=FALSE,encoding = "unknown")

submission = fread("data/example.csv",stringsAsFactors=FALSE,encoding = "unknown")

score_table=NULL
model=c("model_bagging","model_arima","model_gbm_weekday",
        "model_rpart","model_lm","model_randomForest",
        "model_xgboost","model_HoltWinters","model_gbm")
#,"model_h2o"
for(idnum in unique(submission$bianma)){
  #idnum=1001
  print(idnum)
  sub_score=NULL
  #model[1]
  dt=bagging_result[bagging_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[1]
  sub_score=as.data.frame(sub_score)
  score_table=rbind(score_table,sub_score)
  #model[2]
  dt=arima_result[arima_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[2]
  score_table=rbind(score_table,sub_score)
  #model[3]
  dt=gbm_weekday_result[gbm_weekday_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[3]
  score_table=rbind(score_table,sub_score)
  #model[4]
  dt=rpart_result[rpart_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[4]
  score_table=rbind(score_table,sub_score)
  #model[5]
  dt=lm_result[lm_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[5]
  score_table=rbind(score_table,sub_score)
  #model[6]
  dt=randomForest_result[randomForest_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[6]
  score_table=rbind(score_table,sub_score)
  #model[7]
  dt=xgboost_result[xgboost_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[7]
  score_table=rbind(score_table,sub_score)
  #model[8]
  dt=HoltWinters_result[HoltWinters_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[8]
  score_table=rbind(score_table,sub_score)
  #model[9]
  dt=gbm_result[gbm_result$id==idnum,]
  sub_score$score=score(dt$x,dt$predict)
  sub_score$id=idnum
  sub_score$model=model[9]
  score_table=rbind(score_table,sub_score)
}

backup=score_table
score_full=as.data.frame(score_table)

select_score=NULL
for(idnum in unique(score_table$id)){
  #idnum=1001
  dt=score_table[score_table$id==idnum,]
  sub=dt[dt$score==max(dt$score),]
  select_score=rbind(select_score,sub)
}

write.csv(select_score,"data/select_score.dat",row.names = F)

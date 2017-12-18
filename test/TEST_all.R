rm(list=ls())
setwd("D:/Rwork/CCF/supermarket")
#score
source("./function/score_depand_rmse.R")
#model_function
source("./function/frame_work.R")

train_start=as.Date(c("2015-05-10"))
test_start=as.Date(c("2015-07-01"))
test_end=as.Date(c("2015-08-31"))

model=c("model_bagging")
result_model_bagging=model_function(model,train_start,test_start,test_end)
score(result_model_bagging$x,result_model_bagging$predict)
write.csv(result_model_bagging,"data/model_bagging.dat",row.names = F)

model=c("model_arima")
result_model_arima=model_function(model,train_start,test_start,test_end)
score(result_model_arima$x,result_model_arima$predict)
write.csv(result_model_arima,"data/model_arima.dat",row.names = F)

train_start=as.Date(c("2015-01-01"))
test_start=as.Date(c("2015-07-01"))
test_end=as.Date(c("2015-08-31"))

model=c("model_gbm_weekday")#1520
result_model_gbm_weekday=model_function(model,train_start,test_start,test_end)
score(result_model_gbm_weekday$x,result_model_gbm_weekday$predict)
write.csv(result_model_gbm_weekday,"data/model_gbm_weekday.dat",row.names = F)

# model=c("model_catboost")
# result_model_catboost=model_function(model,train_start,test_start,test_end)
# score(result_model_catboost$x,result_model_catboost$predict)
# write.csv(result_model_catboost,"model_catboost.dat",row.names = F)

# model=c("model_lightgbm")
# result_model_lightgbm=model_function(model,train_start,test_start,test_end)
# score(result_model_lightgbm$x,result_model_lightgbm$predict)
# write.csv(result_model_lightgbm,"model_lightgbm.dat",row.names = F)


model=c("model_rpart")# 0.1983908#1520
result_model_rpart=model_function(model,train_start,test_start,test_end)
score(result_model_rpart$x,result_model_rpart$predict)
write.csv(result_model_rpart,"data/model_rpart.dat",row.names = F)

model=c("model_lm")# 0.156613
result_model_lm=model_function(model,train_start,test_start,test_end)
score(result_model_lm$x,result_model_lm$predict)
write.csv(result_model_lm,"data/model_lm.dat",row.names = F)

model=c("model_randomForest")
#0.1957679 
result_model_randomForest=model_function(model,train_start,test_start,test_end)
score(result_model_randomForest$x,result_model_randomForest$predict)
write.csv(result_model_randomForest,"data/model_randomForest.dat",row.names = F)

model=c("model_xgboost")#0.10
# 0.1468991 eta = 0.1,max_depth = 10,nround=500,min_child_weight=5
#           eta = 0.03,max_depth = 10,nround=1000,min_child_weight=3,
result_model_xgboost=model_function(model,train_start,test_start,test_end)
score(result_model_xgboost$x,result_model_xgboost$predict)
write.csv(result_model_xgboost,"data/model_xgboost.dat",row.names = F)

model=c("model_HoltWinters")# 0.1257633
result_model_HoltWinters=model_function(model,train_start,test_start,test_end)
score(result_model_HoltWinters$x,result_model_HoltWinters$predict)
write.csv(result_model_HoltWinters,"data/model_HoltWinters.dat",row.names = F)

# model=c("model_h2o")
# result_model_h2o=model_function(model,train_start,test_start,test_end)
# score(result_model_h2o$x,result_model_h2o$predict)
# write.csv(result_model_h2o,"data/model_h2o.dat",row.names = F)

model=c("model_gbm")# 0.1914919
result_model_gbm=model_function(model,train_start,test_start,test_end)
score(result_model_gbm$x,result_model_gbm$predict) 
write.csv(result_model_gbm,"data/model_gbm.dat",row.names = F)

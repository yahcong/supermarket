rm(list=ls())
setwd("D:/Rwork/CCF/supermarket")
#score
source("./function/score_depand_rmse.R")
#submit_frame
source("./function/submit_frame.R")
train_start=as.Date(c("2015-01-01"))
test_start=as.Date(c("2015-09-01"))
test_end=as.Date(c("2015-10-29"))

#model:model_bagging,model_arima

model=c("model_bagging")
result_model_bagging=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_bagging,"output/model_bagging.dat",row.names = F)

model=c("model_arima")
result_model_arima=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_arima,"output/model_arima.dat",row.names = F)

model=c("model_gbm_weekday")#1520#rerun
result_model_gbm_weekday=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_gbm_weekday,"output/model_gbm_weekday.dat",row.names = F)

# model=c("model_catboost")
# result_model_catboost=model_function(model,train_start,test_start,test_end)
# score(result_model_catboost$x,result_model_catboost$predict)
# write.csv(result_model_catboost,"model_catboost.dat",row.names = F)

# model=c("model_lightgbm")
# result_model_lightgbm=model_function(model,train_start,test_start,test_end)
# score(result_model_lightgbm$x,result_model_lightgbm$predict)
# write.csv(result_model_lightgbm,"model_lightgbm.dat",row.names = F)


model=c("model_rpart")# 0.1983908#1520
result_model_rpart=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_rpart,"output/model_rpart.dat",row.names = F)

model=c("model_lm")# 0.156613
result_model_lm=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_lm,"output/model_lm.dat",row.names = F)

model=c("model_randomForest")
#0.1957679 
result_model_randomForest=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_randomForest,"output/model_randomForest.dat",row.names = F)

model=c("model_xgboost")#0.10
# 0.1468991 eta = 0.1,max_depth = 10,nround=500,min_child_weight=5
#           eta = 0.03,max_depth = 10,nround=1000,min_child_weight=3,
result_model_xgboost=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_xgboost,"output/model_xgboost.dat",row.names = F)

model=c("model_HoltWinters")# 0.1257633
result_model_HoltWinters=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_HoltWinters,"output/model_HoltWinters.dat",row.names = F)

model=c("model_gbm")# 0.1914919
result_model_gbm=submit_frame(model,train_start,test_start,test_end)
write.csv(result_model_gbm,"output/model_gbm.dat",row.names = F)

rm(list=ls())
setwd("D:/Rwork/CCF/supermarket")

#score
source("./function/score_depand_rmse.R")
#model_function
source("./test/frame_work.R")

#model:model_bagging,model_lm,model_arima
model=c("model_arima")
train_start=as.Date(c("2015-05-10"))
test_start=as.Date(c("2015-07-01"))
test_end=as.Date(c("2015-08-31"))

result=model_function(model,train_start,test_start,test_end)
score(result$x,result$predict)
write.csv(result,"data/test_arima.dat",row.names = F)

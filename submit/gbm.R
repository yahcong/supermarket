rm(list=ls())
setwd("D:/Rwork/CCF/supermarket")

#score
source("./function/score_depand_rmse.R")
#submit_frame
source("./function/submit_frame.R")

#model:model_bagging,model_arima
model=c("model_gbm")
train_start=as.Date(c("2015-06-10"))
test_start=as.Date(c("2015-09-01"))
test_end=as.Date(c("2015-10-29"))
result=submit_frame(model,train_start,test_start,test_end)
str(result)

write.csv(result,"output/gbm.csv",row.names = F)
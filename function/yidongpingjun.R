
library(data.table)
#train_test
source("./function/train_test.R")
data = fread("data/train.csv",stringsAsFactors=FALSE,encoding = "unknown")
data_sub <- data[,c(2,4,8,18)]
names(data_sub) = c("big_id","m_id","sale_date","week")

data_sub = data_sub[,sale_date := as.Date(as.character(sale_date),format = "%Y%m%d")]
#train and test

train_start=as.Date(c("2015-01-10"))
test_start=as.Date(c("2015-04-01"))
test_end=as.Date(c("2015-05-31"))

output= train_test(data_sub,train_start,test_start,test_end)
train_data=output[[1]]
test_data=output[[2]]
train_time=output[[3]]
test_time=output[[4]]



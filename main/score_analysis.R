rm(list=ls())
library(data.table)
setwd("D:/Rwork/CCF/supermarket")

#lm_result=fread("data/test_lm.dat",stringsAsFactors=FALSE,encoding = "unknown")
arima_ressult=fread("data/test_arima.dat",stringsAsFactors=FALSE,encoding = "unknown")
bagging_ressult=fread("data/test_bagging.dat",stringsAsFactors=FALSE,encoding = "unknown")
arima_ressult=fread("data/test_arima2.dat",stringsAsFactors=FALSE,encoding = "unknown")
bagging_ressult=fread("data/test_bagging2.dat",stringsAsFactors=FALSE,encoding = "unknown")

#score
source("./function/score_depand_rmse.R")

score(arima_ressult$x,arima_ressult$predict)
score(bagging_ressult$x,bagging_ressult$predict)
date=c("20150815")
date=c("20150820")
date=c("20150715")
date=c("20150801")

score(arima_ressult$x[arima_ressult$sale_date>=date],arima_ressult$predict[arima_ressult$sale_date>=date])
score(bagging_ressult$x[bagging_ressult$sale_date>=date],bagging_ressult$predict[bagging_ressult$sale_date>=date])


score(arima_ressult$x[arima_ressult$sale_date<date],arima_ressult$predict[arima_ressult$sale_date<date])
score(bagging_ressult$x[bagging_ressult$sale_date<date],bagging_ressult$predict[bagging_ressult$sale_date<date])

#bagging的分数始终比arima的高
#并且arima的前期比后期的分数高，gagging则后期比前期分数高

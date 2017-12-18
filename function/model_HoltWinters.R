library(zoo)
library(forecast)
library(data.table)
library(dplyr)
library(sampling)
library(ggplot2)
library(zoo)
library(forecastxgb)
library(mice)
#library(data.table)

model_HoltWinters = function(idnum,dt,date,pred_time){
  # idnum=1001
  # dt=train_data
  # date=train_time
  # pred_time=test_time
  dt = dt[dt$id==idnum,]
  dt = merge(date,dt,by = "sale_date",all = T)
  dt$count[is.na(dt$count)] = ifelse(is.na(mean(dt$count,na.rm = T)),0,median(dt$count,na.rm = T))
  dt$id=NULL
  
  rainseries<-ts(dt$count,start=c(0623))
  #fit <-HoltWinters(rainseries,beta=FALSE,gamma=FALSE)
 
  fit <-HoltWinters(rainseries, seasonal = "mult",beta=FALSE,gamma=FALSE)
  #x = forecast(fit,h=62)
  x = forecast(fit,h=59)
  predict = round(as.data.frame(x))
  predict$sale_date = pred_time
  predict$id = idnum
  predict$`Point Forecast` = as.numeric(predict$`Point Forecast`)
  predict = predict[,c(7,6,1)]
  names(predict) <- c("id","sale_date","x")
  return(predict)
}

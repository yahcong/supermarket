library(zoo)
library(forecast)
#library(data.table)

model_arima = function(idnum,dt,date,pred_time){
  dt = dt[dt$id==idnum,]
  dt = merge(dt,date,by = "sale_date",all = T)
  dt$count[is.na(dt$count)] = ifelse(is.na(mean(dt$count,na.rm = T)),0,median(dt$count,na.rm = T))
  dt$id=NULL
  dt_series = zoo(x = dt$count,order.by = dt$sale_date)
  train = ts(dt_series,frequency=7,start=c(1,1))
  fit=auto.arima(train)
  #x = forecast(fit,h=62)$mean
  x = forecast(fit,h=59)$mean
  predict = round(as.data.frame(x))
  predict$sale_date = pred_time
  predict$id = idnum
  predict$x = as.numeric(predict$x)
  return(predict)
}

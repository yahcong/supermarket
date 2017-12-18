merge_test_predict = function(test_data,pred_time,predict_data){
  test_data$sale_date = as.character(as.Date(test_data$sale_date),format = "%Y%m%d")
  pred_time = as.data.frame(pred_time)
  names(pred_time)=c("sale_date")
  dtl=NULL
  for(idnum in unique(predict_data$id)){
    dts=NULL
    dts = test_data[test_data$id==idnum,]
    dts = merge(pred_time,dts,by = "sale_date",all.x = T)
    dts$count[is.na(dts$count)] = ifelse(is.na(dts$id[is.na(dts$count)]),0,median(dts$count,na.rm = T))
    dts$id=idnum
    dtl=rbind(dtl,dts)
  }
  predict_data = predict_data[,c("id","sale_date","x")]
  predict_data$predict=dtl$count
  return(predict_data)
}

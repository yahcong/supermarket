library(caret)

score = function(pred,test){ 
  res=RMSE(pred,test)
  res=1/(1+res)
  return(res)
}

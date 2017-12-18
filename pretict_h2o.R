library(h2o)
h2o.init()
setwd("D:/Rwork/CCF/supermarket")

train <- h2o.importFile("data/example.csv")  
test  <- h2o.importFile("./test/data_sub.dat")

# To see a brief summary of the data, run the following command  
summary(train)  
summary(test)  
airlines.glm <- h2o.glm(training_frame=train,y=y,family = "binomial", alpha = 0.5)

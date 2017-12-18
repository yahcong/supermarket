#rm(list=ls())

library(data.table)
library(mice)
library(dplyr)

#读取数据---------------------------------------------------------------
data = fread("data/train.csv",stringsAsFactors=FALSE,encoding = "unknown")


submission = fread("data/example.csv",stringsAsFactors=FALSE,encoding = "unknown")
data_sub <- data[,c(1,2,4,6,8,14,15,16,17)]
names(data_sub) = c("custid","big_id","m_id","small_id","sale_date","XSSL","XSJE","XSDJ","SFCX")
data_sub = data_sub[data_sub$XSSL>0,]
#data_sub=data_sub[data_sub$SFCX=="否",]
dim(data_sub)
data_sub = data_sub[,sale_date := as.Date(as.character(sale_date),format = "%Y%m%d")]
#data_sub = data_sub[data_sub$sale_date>="2015-05-10",]
dim(data_sub)

# custid_count = data_sub[data_sub$sale_date<"2015-04-01",] %>%
#   select(custid) %>%
#   group_by(custid) %>%
#   summarize(count = n())
# 
# select_custid = custid_count$custid[custid_count$count>=2]
# data_sub = data_sub[which(data_sub$custid %in% select_custid),]

#check NA
md.pattern(data_sub)
data_sub = data_sub[,c(2,3,5)]
#data_sub = unique(data_sub)
group1 = data_sub %>%
  select(big_id,sale_date) %>%
  group_by(big_id,sale_date) %>%
  summarize(count = n())
group2 = data_sub%>%
  select(m_id,sale_date)%>%
  group_by(m_id,sale_date)%>%
  summarize(count = n())
names(group1) = c("id","sale_date","count");names(group2) = c("id","sale_date","count")
data_sub_count = rbind(as.data.frame(group1),as.data.frame(group2))
write.table(data_sub_count,"./test/data_sub.dat",row.names = F)

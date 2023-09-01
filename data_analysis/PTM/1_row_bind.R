library(tidyr)
library(tidyverse)
library(magrittr)
library(readr)
library(stringr)
one_one <- read.delim("D:/code/R/data_deal/tidyr/1-1.result.txt")
#c <- one_one %>% chop(cols = -MasGer.ProGein.Accessions)
a <- data.frame(one_one$ModifiedSequence,one_one$MasGer.ProGein.Accessions,one_one$toxin.abbr,one_one$Master.Protein.Accessions)

data_output <- a %>% group_by(one_one.MasGer.ProGein.Accessions) %>% summarise(
  ModifiedSequence = paste(one_one.ModifiedSequence, collapse = ","),
  toxin.abbr = paste(one_one.toxin.abbr, collapse = ","),
  Master.Protein.Accessions =paste(one_one.Master.Protein.Accessions, collapse = ","),
  #ModifyType = str_extract_all(one_one.ModifiedSequence,"\\[.+?\\]",simplify = T)
  )
#########  提取指定列
q <- str_extract_all(data_output$ModifiedSequence,"\\[.+?\\]",simplify = T) # simplify =T 返回矩阵格式
r <- as.data.frame(q)
r[r == ""]<-NA  #### 将空值转化为NA值
e <- unite(r,col = "ModifyType",everything(),sep = ",",na.rm = T)  ##合并所有非NA列


######### 将返回结果的列表转化为数据框
##### 通过dim函数指定转换后的行列
dim(q) <- c(35480,1)   
w <- as.data.frame(q)
colnames(w) <- c("ModifyType") 
#######  得到后的数据框会将所有变量放在一列
result_data <- data.frame(data_output,)



write.table(data_output,"result.txt",row.names = F,sep = "\t")

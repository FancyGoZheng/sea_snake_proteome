library(dplyr)
library(tidyr)
library(readxl)
library(reshape2)
rmsd <- read_xlsx("Hh_toxin_gene_RMSD_output.xlsx")

#rmsd <- read.csv("Hh_toxin_gene_RMSD_output.csv")

rmsd <- rmsd[,1:4]
colnames(rmsd)[1] <- "family"
colnames(rmsd)[4] <- "value"






# 按照蛋白家族分组，生成每个家族下的所有蛋白ID
proteins <- rmsd %>%
  group_by(family) %>%
  summarize(protein = unique(c(protein_1, protein_2))) %>%
  ungroup()

# 生成所有蛋白ID与自身互作的数据
attach(rmsd)
new_data <- proteins %>%
  mutate(family, protein, protein2 = protein,value = 0) 

####  列名相同

colnames(new_data) <- colnames(rmsd)




# 将新数据添加到原始数据中
result <- bind_rows(rmsd, new_data)
#  result 为添加自身互作数据，但并未含有对称

# 将每个毒素拆分成单个的文件
df_list <- split(result, result$family)

lapply(names(df_list), function(x) {
  
  matrix_data <- reshape2::dcast(df_list[[x]][,2:4],protein_1~protein_2,value.var = "value",fun.aggregate = mean)
  ## dcast 将长数据转化为宽数据，如果数据中行列对应的数据有多个则聚合函数默认为长度，所以在这里用取平均数比较合适
  test <- matrix_data[,2:ncol(matrix_data)]
  test[is.na(test) ] <- 0
  test <- test+t(test)
  test1 <-  cbind(matrix_data[,1],test)
  colnames(test1)[1] <- ""
  write.table(test1,file = paste0(x, ".txt"),sep = "\t",row.names = F,quote = F)
  
})



























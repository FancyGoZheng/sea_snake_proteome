library(tidyr)
library(tidyverse)
library(magrittr)
library(readr)
library(stringr)
library(stringi)
library(reshape2)

output<- read.table("output.txt",header = T)
####将位点pos和type合并
output[is.na(output)] <- "" # 将NA值赋值为空值方便后面位点和修饰类型合并
########## 将修饰位点和修饰类型结合作为一个观测
q <- unite(output,
           "pos_type_1",pos1:type1 ,sep = "-",na.rm = T,remove = T)
q <- unite(q,
           "pos_type_2",pos2:type2 ,sep = "-",na.rm = T,remove = T)
q <- unite(q,
           "pos_type_3",pos3:type3 ,sep = "-",na.rm = T,remove = T)
q <- unite(q,
           "pos_type_4",pos4:type4 ,sep = "-",na.rm = T,remove = T)
q <- unite(q,
           "pos_type_5",pos5:type5 ,sep = "-",na.rm = T,remove = T)

### 对数据进行去重

data_output <- q %>%group_by(Master.Protein.Accessions) %>%
  summarise(toxins = paste(toxin.abbr.x,
                 collapse = ","))  
            
            
modifies  = paste(
  unique(
    c(q$pos_type_1,q$pos_type_2,q$pos_type_3,q$pos_type_4,q$pos_type_5)),collapse = ",")   
    
    
 

single_result <- data.frame()


#j <- "Hh01T000167.1"
for (j in names(table(q$Master.Protein.Accessions))) 
{
  
  type_toxin <- filter(q,Master.Protein.Accessions == j) %>% 
select(
    contains('pos_type') 
    )  ###拿到修饰位点和类型然后准备去重

  ## 进行去重c函数合并多列，unique函数去重，paste连接成一个向量
w<-   paste(unique(
  c(type_toxin$pos_type_1,
    type_toxin$pos_type_2,
    type_toxin$pos_type_3,
    type_toxin$pos_type_4,
    type_toxin$pos_type_5)
    ),
        collapse = ",")



hebing_output<- data.frame("proteins"=j,"modifies"= w) ## 将蛋白ID和修饰信息合并
single_result <- rbind(single_result,hebing_output)  ## 循环中依次按行添加
}  
write.xlsx(single_result ,"OUTPUT-单个毒素分子的修饰坐标.xlsx")



### 匹配毒素名称,方便后续统计
### 将data_output的第二列进行去重转化为单个毒素的名称
for (i in 1:nrow(data_output))
{
  data_output[i,2]<- unique(unlist(
    strsplit(
      as.character(data_output[i,2]),split = ","
    )
  )
  )
}
names(data_output) = c("proteins","toxins")
toxin_single <- merge(single_result,data_output, by = "proteins")#### 这个数据框中存储单个蛋白编号，毒素名，和修饰信息
toxin_single <- data.frame(toxin_single$toxins ,
                           toxin_single$proteins,
                           toxin_single$modifies)
###将数据框进行列重排

n_all_mod<- stri_count(toxin_single[,3], regex = "\\[")
n_Car_mod <- stri_count(toxin_single[,3], regex = "Carbamidomethyl ")
n_Oxi_mod <- stri_count(toxin_single[,3], regex = "Oxidation")
n_Ace_mod <- stri_count(toxin_single[,3], regex = "Acetyl ")
####合并带有修饰计数的信息
modi_info <- data.frame(toxin_single,n_Car_mod,n_Oxi_mod,n_Ace_mod,n_all_mod)

#####以毒素家族为单位进行统计
final_output <- modi_info %>% group_by(toxin_single.toxins) %>%
  summarise(
    
    
    n_tox_num = length(toxin_single.proteins),
    n_Car_mod = sum(n_Car_mod),
    n_Oxi_mod = sum(n_Oxi_mod),
    n_Ace_mod = sum(n_Ace_mod),
    n_all_mod = sum(n_all_mod),
    proteins = paste(toxin_single.proteins,collapse = ","),
  )

write.table(final_output,"各毒素家族修饰种类统计.txt",row.names = F ,sep = "\t")


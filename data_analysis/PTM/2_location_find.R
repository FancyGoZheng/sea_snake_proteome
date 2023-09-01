####### 加载包#####
library(tidyr)
library(tidyverse)
library(magrittr)
library(readr)
library(stringr)
library(stringi)
library(reshape2)

# 读入文件 --------------------------------------------------------------------


toxin0 <- read.delim("toxin_result.txt")   
### 蛋白质组中只有毒素的信息，以转录本编号为一行 


#colnames(toxin0)

#toxin0  =  mutate(toxin0, pep_segment = ModifiedSequence)


one_one <- read.delim("1-1.result.txt")  
### 将转录本ID对应的长数据文件读入，以肽段为一行
toxin_1_1 <- filter(one_one,toxin.abbr != '#N/A')   
## 筛选出所有的毒素蛋白


q<- toxin_1_1 %>% left_join(toxin0,toxin_1_1,by = "Master.Protein.Accessions",match = "Seq")
####  为每个毒素肽段匹配上序列

w <- select(q,  toxin.abbr.x, Master.Protein.Accessions, ModifiedSequence.x, Annotated.Sequence,Seq) 

#######  提取所有需要用的序列用于后续分析


########### 获取肽段在蛋白质里的位置     ##########
locate <- data.frame()
for (i in 1:nrow(w)) 
{
  a <- str_locate(w$Seq[i],w$Annotated.Sequence[i])
  locate <- rbind(locate,a)

}
########## 将修饰标记给替换为空字符 ##########

r <- stringi::stri_replace_all(w$ModifiedSequence.x,
                               regex = "\\[.+?\\]",
                               "#")


w1 <- mutate(w,replace_modify = r)

w <- w1

########### 获取标记位点在肽段里的位置   ##########
modi_locate <- data.frame()
for (i in 1:nrow(w)) 
{
  a <- str_locate_all(w$replace_modify[i],"#")
  a <- as.data.frame(a[[1]])
  
  
  if (is.na(a$start[1])) 
  {
    a[1,] <- c(NA,NA)
  }
  else
  {
    a <- summarise(a,start =paste(start, collapse = ","))
  }
  modi_locate <- rbind(modi_locate,a$start)
}

New_modi_locate <- separate(modi_locate,col = NA_integer_. , into = c("P1","P2","P3","P4","P5") ,sep = ",")

######将字符型数据框转化为数值型数据框   ##### 
New_modi_locate1 <- as.data.frame(lapply(New_modi_locate,as.numeric))



####### 获取正确的修饰位点 ##### 
New_modi_locate2 <- mutate(New_modi_locate1, right1 = (P1) - 2, right2 = (P2) - 3,right3 = (P3) - 4,right4 = (P4) - 5,right5 = (P5) - 6,)


#####   获取修饰位点在蛋白序列中的坐标       ##### 

locate <-  mutate(locate,
                     pos1 =  locate$start + New_modi_locate2$P1 -3,
                     
                     pos2 =  locate$start + New_modi_locate2$P2 -4,
                     
                     pos3 =  locate$start + New_modi_locate2$P3 -5,
                  
                     pos4 =  locate$start + New_modi_locate2$P4 -6,
                  
                     pos5 =  locate$start + New_modi_locate2$P5 -7,
                  
                     )
################### 找到对应的修饰类型和个数  ##########
 

modify_type <- str_extract_all(w$ModifiedSequence.x,"\\[.+?\\]",simplify = T) 
modify_count <- stri_count(w$ModifiedSequence.x,regex = "\\[.+?\\]")

##### 合并所有信息列####################


output <- mutate(w,
                     start =locate$start,
                     end = locate$end ,
                     pos1 = locate$pos1 ,
                 type1 = modify_type[,1],
                     pos2 = locate$pos2 ,
                 type2 = modify_type[,2],
                     pos3 = locate$pos3 ,
                 type3 = modify_type[,3],
                     pos4 = locate$pos4 ,
                 type4 = modify_type[,4],
                     pos5 = locate$pos5 ,
                 type5 = modify_type[,5],
                     
                     counts = modify_count,
                     )

write.table(output,row.names = F,sep = "\t",file = "R_output-modi_pos.txt")




#write.table(New_modi_locate,"onlyCol_1_right.txt",row.names = F,sep = "\t")

##### 查看整体修饰情况

type_ana <- select(output,contains('type'))
class(type_ana)
table(as.vector(as.matrix(type_ana)))



#########  每个毒素单独看
#names(table(output$toxin.abbr.x))

type_result <- data.frame()

for (j in names(table(output$toxin.abbr.x))) 
{
  
  type_toxin <- filter(output,toxin.abbr.x == j) %>% select(contains('type'))  ###筛选修饰类型
    
  linshi<- table(as.vector(as.matrix(type_toxin)))
  
  temp <- data.frame(
    table(as.vector(as.matrix(type_toxin)))
    ,j)
  #### 将含有修饰类型的数据框转化为向量并做汇总统计
  type_result<- rbind(type_result,temp)
}


type_result1 <- type_result
type_result1$Var1 <- as.character(type_result1$Var1)  #### 默认生成的变量为因子变量需要进行转化
type_result1[is.na(type_result1)]  <- "non_modify"  ### 将无修饰的标注为non_modify 方便后续长数据转宽数据


type_result_out1 <- dcast(type_result,j~Var1,value.var = 'Freq')

write.table(type_result_out1,file = "R_output-各毒素修饰类型汇总.txt",sep="\t",row.names = F)




#dir.create("R-OUTPUT")


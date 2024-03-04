## load package
library(stats)
#install.packages("dendextend")
library(dendextend)
library(ggplot2)
library(reshape2)

########### input data
rmsd.data <- read.table("INPUT/3FTx.txt",row.names = 1)
pla2 <- read.table("INPUT/PLA2.txt",row.names = 1)
crisp <- read.table("INPUT/CRISP.txt",row.names = 1)


############### 聚类实现
clust <- function(data,method,n) 
{
  normal.rmsd <-  log(data +1) /log(max(data +1 ))
  ##### hclust
  hc_result <- hclust(as.dist(normal.rmsd), method = method)  # 选择聚类方法，例如完全链接法
  # 绘制树状图
  
  num_clusters <- n  # 选择要切割的簇的数量
  clusters <- cutree(hc_result, k = num_clusters)
  
  #### plot 
  # 重新绘制树状图，根据簇的成员进行着色
  dend <- as.dendrogram(hc_result)  # 将层次聚类结果转换为树状图
  dend <- color_branches(dend, k = num_clusters)  # 根据簇标签着色
  
  # 绘制树状图
  plot(dend, main = "Dendrogram of RMSD Clustering with Clusters",
       #ylim = c(-5,2),
      cex= 1.2
       )
  
  
}

#clust("complete")
clust(rmsd.data,"centroid",3)
clust(pla2,"centroid",2)


## pla2
clust(pla2,"ward.D",2)
#  方法："ward.D", "ward.D2", "single", "complete", "average" (= UPGMA), "mcquitty" (= WPGMA), "median" (= WPGMC) or "centroid" (= UPGMC).

## crisp
clust(crisp,"ward.D",5)

# 画出来的图下方坐标标签太长，没有显示出来


####################### 聚类结束





###################### 开始相关性分析


rmsd.cor <- function(data) 
{
  

cor.mt <- cor(data, method = "pearson")

## 正则化 使得值全部在0-1之间
sigmoid_normalize <- function(x) {
  return(1 / (1 + exp(-x)))
}
normalized_cor_matrix <- sigmoid_normalize(cor.mt)


cor_matrix_melted <- melt(normalized_cor_matrix)


ggplot(data = cor_matrix_melted, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  #scale_fill_gradient(low = "white", high = "blue") +  # 颜色映射
  scale_fill_gradient2(low = "blue", mid = "white", high = "#FA7F6F", midpoint = 0) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(title = "3FTx RMSD Correlation Heatmap", x= NULL ,y = NULL)

}


##### 使用  rmsd.data 为输入的rmsd原始矩阵数据
rmsd.cor(rmsd.data) 
write.table(normalized_cor_matrix,"OUTPUT/3FTx_cor_matrix_data.txt",sep = "\t",row.names = T)
write.table(cor_matrix_melted,"OUTPUT/3FTx_cor_matrix_Long_data.txt",sep = "\t",row.names = T)
rmsd.cor(pla2) 






#install.packages("gggenes")
library(ggplot2)
library(gggenes)





#gene_loc<- read.delim("output/mydata.txt")

#根据gene_loc的abbr 列筛选3FTx对应行

locate_plot <- function(gene) {
  

#gene_loc_plot <- gene_loc[gene_loc$abbr == gene,] 

ggplot(gene, aes(xmin = start, xmax = end, 
                          y = molecule, fill = gene)) +
  geom_gene_arrow() +
  facet_wrap(~ molecule, scales = "free", ncol = 1) +
  scale_fill_brewer(palette = "Set3") +
  theme_genes()

}
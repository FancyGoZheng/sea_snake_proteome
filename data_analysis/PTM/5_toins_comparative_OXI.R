DIA <- read.xlsx("DIA_oxi_pos.xlsx",sheetIndex = 1,header = T,colIndex = c(1,2))
TMT <- read.xlsx("TMT_oxi_pos_outdata.xlsx",sheetIndex = 1,header = T,colIndex = c(1,2))
data1 <- DIA
data2 <- TMT
# 提取蛋白ID
ids_data1 <- data1$proteins
ids_data2 <- data2$protein





# 提取位点信息
get_sites <- function(data) {
  sites <- strsplit(as.character(data[, 2]), ",")
  return(sites)
}




# 创建一个空的结果数据框
result <- data.frame(ID = character(),
                     Unique_to_data1 = character(),
                     Unique_to_data2 = character(),
                     Common_sites = character(),
                     Union_sites = character(),
                     stringsAsFactors = FALSE)

# 遍历第一组数据的ID
for (i in seq_along(ids_data1)) {
  id <- ids_data1[i]
  
  # 检查ID是否在第二组数据中存在
  if (id %in% ids_data2) {
    # 获取第一组数据的位点
    sites_data1 <- unlist(get_sites(data1[i, ]))
    
    # 获取第二组数据中相应ID的位点
    sites_data2 <- unlist(get_sites(data2[ids_data2 == id, ]))
    
    # 获取第一组数据特有的位点
    unique_to_data1 <- setdiff(sites_data1, sites_data2)
    
    # 获取第二组数据特有的位点
    unique_to_data2 <- setdiff(sites_data2, sites_data1)
    
    # 获取两组数据共有的位点
    common_sites <- intersect(sites_data1, sites_data2)
    
    # 获取两组数据的并集位点
    union_sites <- union(sites_data1, sites_data2)
    
    # 将结果添加到结果数据框
    result <- rbind(result, c(id, paste(unique_to_data1, collapse = ","), paste(unique_to_data2, collapse = ","), paste(common_sites, collapse = ","), paste(union_sites, collapse = ",")))
  }
}
colnames(result) <- c("id","unique_to_DIA","unique_to_TMT","common_sites","union_sites")




write.xlsx(result ,"OUTPUT-Hh-OXI位点比较.xlsx")

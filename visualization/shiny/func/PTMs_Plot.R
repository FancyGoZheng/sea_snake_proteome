##   library(drawProteins)
##   library(ggplot2)

# data 

# data <- my_data[my_data$abbr=="VF",] 

PTMs_plot <- function(data) {
  
  p <- draw_canvas(data)
  p <- draw_chains(p, data, label_size = 5,fill = "#e8f5ff")
  p <- draw_phospho(p, data,fill ="#6aaeff",size = 5 )
  p <- p + theme_bw(base_size = 20) + 
    theme(panel.grid.minor =element_blank(), panel.grid.major =element_blank()) + 
    theme(axis.ticks =element_blank(), axis.text.y =element_blank()) + 
    theme(panel.border =element_blank())+
    theme(axis.text.x = element_text(size = 30, face = "bold"))+  ##刻度文本大小
    theme(axis.title.x = element_text(size = 35, face = "bold")) # x标题大小
  
  return(p)
}

# 函数使用
#   PTMs_plot(my_data)



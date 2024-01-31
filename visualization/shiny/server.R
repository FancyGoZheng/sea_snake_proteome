
library(visNetwork)
library(r3dmol)
library(shinyjs)
library(drawProteins)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(flexdashboard)
library(shinyalert)
library(shinydisconnect)

#shinyalert::runExample()

library(shinydashboardPlus)


data=read.delim("data/Hh_seqs.txt")
gene_data=read.delim("data/gene_locate.txt")
rmsd_data= read.csv("data/Hh_toxin_gene_RMSD_output.csv")
gene_loc<- read.delim("data/mydata_locate_plot.txt")
my_PTM_data <- read.delim("data/Hh_toxin_Oxi_PTMs.txt", row.names=1,encoding = "utf-8")




source("func/r3d_show.R")




shinyServer(function(input, output,session) {
  
  #### 分布图片  #####
  output$myImage <- renderImage({
    # 定义本地图片的路径
    img_path <- "./img/Hc地理分布.png"

    # 使用list来构建renderImage的返回值
    list(
      src = img_path,        # 图片的路径
      alt = "My Local Image", # 图片的替代文本
      width = "70%",
      height = "100%"
    )
  }, deleteFile = FALSE)

  #### 样本图片  #####

  
  
  
  output$sampleImage <- renderImage({
    # 定义本地图片的路径
    img_path <- "./img/Hh_样本图.png"
    
    # 使用list来构建renderImage的返回值
    list(
      src = img_path,        # 图片的路径
      alt = "My sample Image", # 图片的替代文本
      width = "auto",
      height = "100%",
      class = "center" 
    )
  }, deleteFile = FALSE)
  
  
  
  

# 进入提示 --------------------------------------------------------------------

  shinyalert(
    title = "Welcome to our database",
    text = "This is a database for Hydrophis curtus developed by Fancyzh and Ezioleon",
    size = "s", 
    closeOnEsc = TRUE,
    closeOnClickOutside = TRUE,
    html = TRUE,
    type = "success",
    showConfirmButton = TRUE,
    showCancelButton = FALSE,
    confirmButtonText = "OK",
    confirmButtonCol = "#79E1ED",
    timer = 0,
    imageUrl = "https://s2.loli.net/2024/01/26/YbplwyGkjr1XxaA.png",
    imageWidth = 200,
    imageHeight = 200,
    animation = TRUE
  ) 
  

# 第一个页面的UI美化 --------------------------------------------------------------

  
  output$uioutput_gailan <- renderUI({
    fluidPage(
      box(width = 12,
          title = "王尼玛",
          status = "primary",
          solidHeader = TRUE,
          collapsible = FALSE,
          HTML("<h4 class='named' style='margin-bottom: 0px;color:#3C8DBC'>评估结果概览</h4>"),
          br(),
          box(
            title = "颜值评估模型 • 检测结果",
            status = "primary",
            solidHeader = TRUE,
            width = 4,
            height = "320px",
            collapsible = FALSE,
            helpText("颜值打分"),
            gaugeOutput("gauge1", height = "150px"),
            p("颜值评估模型的评估结果为貌如潘安！")
          ),
          box(
            title = "才华评估模型 • 检测结果",
            status = "primary",
            solidHeader = TRUE,
            width = 4,
            height = "320px",
            collapsible = FALSE,
            helpText("才华打分"),
            gaugeOutput("gauge2", height = "150px"),
            p("才华评估模型的评估结果为读书少很好骗！")
          ),
          box(
            title = "有趣的灵魂 • 检测结果",
            status = "primary",
            solidHeader = TRUE,
            width = 4,
            height = "320px",
            collapsible = FALSE,
            helpText("有趣指数"),
            gaugeOutput("gauge3", height = "150px"),
            p("好看的皮囊千篇一律，有趣的灵魂万里挑一！")
          )
      )
    )
    
    fluidPage(
      
    )
  })
  
  
  
  

## 进化树图片

  output$treeImage <- renderImage({
    # 定义本地图片的路径
    img_path <- paste0("./img/tree/",input$module,".png")  ## 接收家族选择
    
    # 使用list来构建renderImage的返回值
    list(
      src = img_path,        # 图片的路径
      alt = "My Local Image", # 图片的替代文本
      width = "70%"
      
    )
  }, deleteFile = FALSE)
## 进化树图片

  
  ###  进化树下添加表格
  output$rmsd_table <- renderTable({
    rmsd_table <- rmsd_data
    colnames(rmsd_table)[1] <- "Family"
    rmsd_table[rmsd_data$dir == as.character(input$module),]
    
  })
  
  
  
  
  
  
   
  ######  家族选择  ##################
  modInput <- reactive({
    switch(input$module,
           "3FTx"="3FTx",
           "PLA2"="PLA2",
           "CRISP"="CRISP",
           "LIP"="LIP",
           "PLI"="PLI",
           "GH56"="GH56",
           "NGF"="NGF",
           "PDGF"="PDGF",
           "SVMP"="SVMP",
           "AChE_CES"="AChE_CES",
           "CST"="CST",
           "NP"="NP",
           "vKUN"="vKUN",
           "CATH"="CATH",
           "DPP"="DPP",
           "MCO"="MCO",
           "PDE"="PDE",
           "vLEC"="vLEC"
    )
  })

  #########   PTM 家族选择  #############
  PTM_Input <- reactive({
    switch(input$PTM_gene,
           "PLI-β" = "PLI-β",
             "Veficolin"=   "Veficolin",
             "5'-NT"=  "5'-NT",
             "QPCT"=  "QPCT",
             "PDGF"=  "PDGF",
             "3FTx-LNTX"=  "3FTx-LNTX",
             "VF"= "VF",
             "CST"=   "CST",
             "Waprin"=  "Waprin",
             "CRISP"= "CRISP",
             "vLEC"= "vLEC",
             "PLB"= "PLB",
             "MCO"= "MCO",
             "TCTP"= "TCTP",
             "PLI-γ"= "PLI-γ",
             "PLA2-I"= "PLA2-I",
             "AChE/CES"= "AChE/CES",
             "LIP"=   "LIP",
             "CAL"= "CAL",
    )
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  #### 毒素家族成员的关联选项框
  observeEvent(input$module, {
    # 根据第一个选项框的选择来筛选第二个选项框的选项
    selected_c1 <- input$module
    choices_c2 <- data$Gene_ID[data$family == selected_c1]
    
    # 更新第二个选项框的选项
    updateSelectInput(session, "gene", choices = choices_c2)
  })
  
  
  


  
  #### 每个家族的基因列表
  familyres <- reactive({
  
    familyres=data[data$family==input$module,c(1:5,9)]
    familyres$Transcript_ID=paste0('<a href=',"https://www.uniprot.org/uniprotkb/", 
                            familyres$Uniprot_ID,
                            "/entry",
                            " target='_blank'",">",
                            familyres$Transcript_ID,
                            '</a>')
    familyres$Transcript_ID= familyres$Transcript_ID
    familyres$Gene_ID=paste0('<a href=',"https://www.uniprot.org/uniprotkb/", 
                                   familyres$Uniprot_ID,
                                   "/entry",
                                   " target='_blank'",">",
                                   familyres$Gene_ID,
                                   '</a>')
  
    return(familyres)
  })
  
  output$familytable <- renderDataTable(
    familyres()[,c(2:5,1)], #### 结果取到1：5列 隐藏Uniprot编号
    options=list("pageLength"=3000)
    , escape = FALSE     
  )
  
### 基因信息
  familygene <- reactive({
    
    familygene=gene_data[gene_data$abbr==input$module,]
    
    return(familygene)
  })
  
  output$family.gene.table <- renderDataTable(
    familygene(), 
    options=list("pageLength"=3000)
    , escape = FALSE     
  )
  
source("func/gene_loc_plot.R")
  
  gene_locate_data  <- reactive({

    gene_locate=gene_loc[gene_loc$abbr==input$module,]

    return(gene_locate)
  })
  
  
 
  output$gene_loc <- renderPlot({  
    locate_plot(gene_locate_data())
    
  })
  

  
  
  
  
  
### 基因信息

  #### 3d结构展示

  output$m3d_show <- renderR3dmol(
    mol.display(paste0("pdb_file/",input$gene,".pdb") )
                                  )


#  生成指定个数的pdb图像

  ######## 监听输入家族来确定滑动条的最大值 ######## 
  observe({
    updateSliderInput(session, "percent", max = length(unique(data$Gene_ID[data$family == input$module])))
  })
  ##################################################
  
  selected_genes <- reactive({
    uniq_gene<- unique(data$Gene_ID[data$family == input$module])
    return(uniq_gene)
  })  
  
  output$boxes <- renderUI({
    lapply(1:input$percent, function(i) {
      box(title = paste0("Family:",input$module, "  ;  ","Gene ID: ",selected_genes()[i]), 
          width = 4, 
          status = "info",
          solidHeader = TRUE,
          collapsible = TRUE,
          mol.display(paste0("pdb_file/", selected_genes()[i], ".pdb")),
          
          
          
          p("  ")
          
          
          )
    })
  })
  

# 蛋白修饰图绘制 -----------------------------------------------------------------

  source("func/PTMs_Plot.R")
  
  
  
  PTM_gene_data <- reactive({
    
    my_PTM_data_plot <- my_PTM_data[my_PTM_data$abbr==input$PTM_gene,] 
    
    return(my_PTM_data_plot)
  })
  
  
  
  
  ############  绘PTM 图  ###########
  output$PTMs_plot <- renderPlot({
    PTMs_plot(PTM_gene_data())
  })
  
  
  
  ###########  输出表格  #########

  
  output$PTM_table <- renderDataTable(
    PTM_gene_data()[,c(10,6,1,3:5)], 
    options=list("pageLength"=3000)
    , escape = FALSE     
  )
  
  
  
  
  
  
  
  
  



rv <- reactiveValues()

num_images <- reactive({
  num_images <- input$percent
  return(num_images)
}) 


# 使用 observeEvent 监听滑动条的变化
observeEvent(input$percent, {
  num_images <- input$percent
  image_outputs <- lapply(1:as.numeric(num_images()), function(i) {
    
    
    id <- paste0("m3d_show_", i)
    
    gene_id <- if (i <= length(selected_genes())) {
      selected_genes()[i]  # 获取第i个基因ID
    } else {
      ""
    }
    
    # 创建一个容器，包含图像和基因ID文本
    div(
      h4(paste("Gene ID:", id,gene_id,selected_genes()[i])),  # 显示基因ID文本
      h2(paste("Gene ID:", id,gene_id,selected_genes()[i])),
      r3dmolOutput(id)  # 显示图像
    )

    
    
  })
  rv$images <- do.call(tagList, image_outputs)
})

# 在动态生成的图像输出元素中显示图像
output$mol_images <- renderUI({
  outputList <- lapply(1:as.numeric(num_images()), function(i) {
    id <- paste0("m3d_show_", i)
    div(
      #h4(paste("Gene ID:", id, selected_genes()[i])),
      h2(paste("Gene ID:", id, selected_genes()[i])),
      r3dmolOutput(id)
    )
  })
  do.call(tagList, outputList)
  
  
  
})

# 动态生成 renderR3dmol 函数
observe({
  output[[paste0("m3d_show_", 1)]] <- renderR3dmol({
    
    mol.display(paste0("pdb_file/", selected_genes()[1], ".pdb"))
  })
  
  outputOptions(output,paste0("m3d_show_", 1),    suspendWhenHidden = FALSE )
  
  output[[paste0("m3d_show_", 2)]] <- renderR3dmol({
    
    mol.display(paste0("pdb_file/", selected_genes()[2], ".pdb"))
  })
  outputOptions(output,paste0("m3d_show_",2),    suspendWhenHidden = FALSE )
  
  
  output[[paste0("m3d_show_", 3)]] <- renderR3dmol({
    
    mol.display(paste0("pdb_file/", selected_genes()[3], ".pdb"))
  })
  
  outputOptions(output,paste0("m3d_show_", 3),    suspendWhenHidden = FALSE )
  
  output[[paste0("m3d_show_", 4)]] <- renderR3dmol({
    
    mol.display(paste0("pdb_file/", selected_genes()[4], ".pdb"))
  })
  
  outputOptions(output,paste0("m3d_show_", 4),    suspendWhenHidden = FALSE )
  output[[paste0("m3d_show_", 5)]] <- renderR3dmol({
    
    mol.display(paste0("pdb_file/", selected_genes()[5], ".pdb"))
  })
  
  outputOptions(output,paste0("m3d_show_", 5),    suspendWhenHidden = FALSE )
  
    
 
      
    

})

  
  
  
  
  
#### 下载按钮
  output$downloadmodule <- downloadHandler(
    filename=function() {paste(input$module,'_family.csv',sep='')},
    content=function(file) {
      
      write.csv(data[data$family==as.character(input$module),],file,row.names=F)
        
        
        
        })
  
  
  output$downloadgenelist <- downloadHandler(
    filename=function() {paste(input$module,'_gene_info.csv',sep='')},
    content=function(file) {
      write.csv(gene_data[gene_data$abbr==input$module,],file,row.names=F)})
  
#### 下载按钮


 
  
  

  }
)

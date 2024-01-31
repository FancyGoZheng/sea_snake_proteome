
library(visNetwork)
library(r3dmol)
library(shiny)
library(shinydashboard)
library(flexdashboard)
library(shinyalert)
library(shinyjs)
library(shinydisconnect)
library(drawProteins)
library(ggplot2)

library(shinythemes)


# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("gggenes")

#install.packages("shinydashboardPlus")
#options(BioC_mirror="https://mirrors.tuna.tsinghua.edu.cn/bioconductor")

ui <- dashboardPage(

# 标题 和最右侧通知----------------------------------------------------------------------


  dashboardHeader(title = "Hydrophis curtus Database",
                  titleWidth = 400,
                  # Dropdown menu for notifications
                  # dropdownMenu( 
                  #   
                  #   type = "notifications",
                  #              badgeStatus = "warning",
                  #              notificationItem(icon = icon("users"),
                  #                               status = "info",
                  #                               "5 new members joined today"
                  #              ),
                  #              notificationItem(icon = icon("user", lib = "glyphicon"),
                  #                               status = "danger", "You changed your username")
                  # 
                  #   ),
                  
                  dropdownMenu(type = "messages", badgeStatus = "success",
                               messageItem(from = "bluesluyi",
                                           message = "This is a great database!",
                                           time = "3 hours",
                                           
                                           #href = "http://fontawesome.io/icons/"
                               ),
                               messageItem(from = "ezioleon",
                                           message = "Toxin database for Hydrophis cyanocinctus",
                                           #icon = icon("bell"),
                                           time = "2 hours"
                               ),
                               messageItem(from = "FancyGo",
                                           message = "Contact us to solve issues!",
                                           icon = icon("cog"),
                                           time = "4 hours"
                               )
                  ),
                  
                  # Dropdown menu for notifications
                  # dropdownMenu(type = "notifications", badgeStatus = "warning",
                  #              notificationItem(icon = icon("users"), status = "info",
                  #                               text =  "5 new members joined today"
                  #              ),
                  #              
                  #              notificationItem(icon = icon("warning"), status = "danger",
                  #                               text = "Chalk've run out"
                  #              ),
                  #              notificationItem(icon = icon("shopping-cart", lib = "glyphicon"),
                  #                               status = "success", 
                  #                               text = "The monitor bought 20 notebooks"
                  #              ),
                  #              notificationItem(icon = icon("user", lib = "glyphicon"),
                  #                               status = "danger", text = "Mrria changed her password"
                  #              )
                  # ),
                  
                  
                  dropdownMenu(type = "tasks", badgeStatus = "danger",
                               taskItem(value = 25, color = "aqua",
                                        "Toxin Family Evolution Tree"
                               ),
                               taskItem(value = 50, color = "green",
                                        "PTMs of toxin proteins"
                               ),
                               taskItem(value = 75, color = "yellow",
                                        "Toxin gene coordinates"
                               ),
                               taskItem(value = 99, color = "red",
                                        "Toxin protein structure"
                               )
                                
                              )
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
    
                  ),
  
  

# 侧边栏 ---------------------------------------------------------------------


  dashboardSidebar(width = 350,
    sidebarMenu(
      
      #### 家族选择放在侧边栏 ####
      fluidRow(column(8,selectInput(
        inputId = "module",
        label = "Select a Toxin Family",
        choices = c("3FTx","PLA2","CRISP","LIP","PLI","GH56","NGF","PDGF","SVMP","AChE_CES","CST","NP","vKUN","CATH","DPP","MCO","PDE","vLEC"),
        width = '200px'
      ))),

      #### 家族选择放在侧边栏 ####
      
      
      menuItem("Hydrophis cyanocinctus toxin molecular data", tabName = "tab1", icon = icon("dashboard")),
      menuItem("Family Tree", tabName = "tab2", icon = icon("tree")),
      menuItem("PTMs", tabName = "tab3", icon = icon("table")),
      menuItem("Family Gene Info", tabName = "tab4", icon = icon("info-circle")),
      #menuItem("Single Molecular structure", tabName = "tab5", icon = icon("cogs")),
      menuItem("Family Molecular structure", tabName = "tab6", icon = icon("sitemap"))
    )
  ),

# 内部主体 --------------------------------------------------------------------


  dashboardBody(
    useShinyjs(),
    tabItems(
      tabItem(tabName = "tab1",
              
# 增加说明介绍 ------------------------------------------------------------------
h1("Hydrophis curtus", align ="center"),
h4("    Hydrophis curtus, also known as Shaw's Sea Snake, short sea snake, but often includes Hydrophis hardwickii, is a species of venomous sea snake in the family Elapidae."),
h4("Hydrophis curtus The Beaked Sea Snake (Hydrophis curtus) is one of the dominant snake species in the Chinese waters. It belongs to the suborder Serpentes, family Elapidae, and subfamily Hydrophiinae. In China, it is primarily found in the shallow continental shelf areas along the southeastern coast, including Hainan, Fujian, Guangdong, Guangxi, and Zhejiang. In comparison to their terrestrial counterparts, sea snakes have evolved distinctive characteristics to adapt to the marine environment, such as a slightly flattened body, paddle-shaped tail, salt glands, and the ability to respire through the skin. Importantly, sea snakes are highly venomous, with venom potency surpassing that of common land snakes. The venom of sea snakes is complex, with diverse components and a wide range of functionalities, presenting significant potential for drug development.  As one of the most abundant and dangerous species among the 19 sea snake varieties in China. Due to its high medical relevance, several research teams have investigated this species "),


h4("    However, in recent years, due to extensive human fishing activities, the population of this sea snake has sharply declined. Hydrophis curtus has been classified as a second-level protected animal in the newly released 'List of Key Protected Wild Animals in China.'"),
h4("    Therefore, establishing a multi-omics database for this sea snake is crucial. It facilitates in-depth research into the diverse evolutionary and molecular regulatory mechanisms enabling Hydrophis curtus to adapt to marine ecosystems. Moreover, it provides essential support for the effective conservation of genetic resources, biodiversity, and sustainable utilization of the sea snake."),

              
#h2("Hydrophis cyanocinctus geographic distribution", align ="center"),
#imageOutput("myImage"),

tags$head(tags$style(HTML("
  .center {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: auto;
  }
"))),



h2("Sample image of Hydrophis curtus photographed by An Li.", align ="center"),
imageOutput("sampleImage"),             
      
              
tags$br(),
tags$br(),

              
              
              
              
              
              
              
              
# 此处为文章引用的代码 --------------------------------------------------------------             
              fluidPage(
                # fluidRow(column(8,selectInput(
                #   inputId = "module",
                #   label = "Select a Toxin Family",
                #   choices = c("3FTx","PLA2","CRISP","LIP","PLI","GH56","NGF","PDGF","SVMP","AChE_CES","CST","NP","vKUN","CATH","DPP","MCO","PDE","vLEC"),
                #   width = '200px'
                # ))),
                # fluidRow(column(6, selectInput("gene",
                #                                "Input a toxin molecular for struction investigation:",
                #                                choices = NULL))),
                # fluidRow(column(8,downloadButton('downloadmodule','Download Family Seqs'))),
                # fluidRow(column(8,downloadButton('downloadgenelist','Download Family gene info'))),
                # fluidRow(column(8,sliderInput("percent","Number of family member structures to  visualize :",min= 2,max= 5,step= 1,value= 2))),
                fluidRow(column(12, tags$div(
                  id = "citation_notice",
                  style = "border: 0.5px solid #ccc; padding: 1px; background-color:#F6EBFF ;    ",
                  tags$span("If you feel that our database has helped you in your research, please cite our article!",
                            style = "color: red; font-weight: bold;
                            font-size:24;"),
                  #tags$br(),
                  #tags$br(),
                  tags$span("   ")
                ))),


                

                
                fluidRow(column(12,
                       # 添加一个提示元素，可以是一个信息框或者其他元素
                       tags$div(
                         id = "citation_notice",
                         style = "border: 0.5px solid #ccc; padding: 1px; background-color:#F6EBFF ;    ",
                         
                         # tags$span("If you feel that our database has helped you in your research, please cite our article!",
                         #           style = "color: red; font-weight: bold;font-size:24;"), 
                         
                         tags$br(),
                         tags$a("[1]: Li A, et al. Molecular Biology and Evolution, 2021. doi: 10.1093/molbev/msab212.",
                                href = "https://doi.org/10.1093/molbev/msab212",
                                target = "_blank",
                                style = "color: balck; font-weight: bold;"),
                         tags$br(),
                         
                         tags$br(),
                         tags$a("[2]: Zheng H, et al. Molecular Biology and Evolution, 2023. doi: 10.1093/molbev/msad125.",
                                href = "https://doi.org/10.1093/molbev/msad125",
                                target = "_blank",
                                style = "color: balck; font-weight: bold;"),
                         
                         tags$br(),
                         tags$span("   "),
                         
                         
                         
                       ))),
                
                
                

# 最下端的notes 提示网站开发人员 ------------------------------------------------------

                
                fluidRow(column(12, div(style = "border-top: 1px solid #ccc; margin-top: 10px; margin-bottom: 10px;"),
                                helpText("Note: This Web database is developed and managed by Fancy_ZH, If you have any questions you can contact fancyzh@shu.edu.cn")))
              )
      ),


# 进化树面板 -------------------------------------------------------------------


      tabItem(tabName = "tab2",
              fluidPage(
              
              box(
                title = "Evolutionary tree",
                status = "primary",
                solidHeader = TRUE,
                width = 8,
                height = "800px",
                collapsible = TRUE,
                
                ##### 增加输入按钮
                # fluidRow(column(8,selectInput(
                #   inputId = "module",
                #   label = "Select a Toxin Family",
                #   choices = c("3FTx","PLA2","CRISP","LIP","PLI","GH56","NGF","PDGF","SVMP","AChE_CES","CST","NP","vKUN","CATH","DPP","MCO","PDE","vLEC"),
                #   width = '200px'
                # ))),
                ###### 增加完输入按钮
                
                imageOutput("treeImage"  ),
                tags$br(),
                tags$br(),
                tags$br(),
                tags$br(),
                tags$br(),
                tags$br(),
                p("This panel is to show the evolutionary tree of the selected toxin family")
              ),
              
              ############ 单个分子三维结构###################
              box(
                title = "Molecular structure",
                status = "danger",
                solidHeader = TRUE,
                width = 4,
                height = "800px",
                collapsible = TRUE,
                
                fluidRow(column(6, selectInput("gene",
                                               "Input a toxin molecular for struction investigation:",
                                               choices = NULL))),
                
                
                r3dmolOutput("m3d_show"),
                
                p("Three-dimensional structure of selected toxin proteins")
              ),
              
              ############ 单个分子三维结构###################
              
              
              ############ 家族成员信息   ###################
              box(
                title = "Family member information",
                status = "info",
                solidHeader = TRUE,
                width = 12,
                height = "820px",
                collapsible = TRUE,
                
                
                #gaugeOutput("gauge2", height = "150px"),
                h3("Click on the molecule ID to access the annotated molecule information obtained from the alignment via a hyperlink."),
                dataTableOutput("familytable"),
                
                p("View information on each member of the family")
              ),
              
              ############ 家族成员信息   ###################
              
              
             
              

              
              
              
              
              
              
      ),

),

# 蛋白修饰信息 -----------------------------------------------------------------


      tabItem(tabName = "tab3",
              
              
              box(
                title = "PTM information",
                status = "danger",
                solidHeader = TRUE,
                width = 10,
                height = "620px",
                collapsible = TRUE,
                
                # fluidRow(column(6, selectInput("PTM_gene",
                #                                "Select a family to view PTM information:",
                #                                choices = NULL))),
                
                fluidRow(column(8,selectInput(
                  inputId = "PTM_gene",
                  label = "Select a family to view PTM information:",
                  choices =    c("VF","Veficolin","MCO","DPP-IV","SVMP-III","5'-NT","AChE/CES","CRISP","PLI-γ","GH56","Waprin","vLEC","PLA2-I" ),#unique(my_PTM_data$abbr)
                  width = '400px'
                ))),
                
                
                
                plotOutput("PTMs_plot",width = "90%"),
                
                p("Distribution of protein modification sites for selected families")
              ),
              

                h1("  "),

              
              tags$br(),
              tags$br(),
              tags$br(),
              tags$br(),
              
              box(
                title = "Toxin protein PTM site",
                status = "info",
                solidHeader = TRUE,
                width = 12,
                height = "820px",
                collapsible = TRUE,
                
                
                
                
                dataTableOutput("PTM_table"),
                
                p("   ")
              ),
              
              
              
              

      ),

# 基因坐标信息 ------------------------------------------------------------------







      tabItem(tabName = "tab4",
              
              ########### 下载按钮  ###########
              box(
                title = "Family Gene File Download",
                status = "info",
                solidHeader = TRUE,
                width = 12,
                height = "320px",
                collapsible = TRUE,
                
                
                fluidRow(column(8,downloadButton('downloadmodule','Download Family Sequences'))),
                fluidRow(column(8,downloadButton('downloadgenelist','Download Family gene info'))),
                
                
                p("Clicking on the download button will allow you to download the sequence and gene coordinates of the corresponding family.")
              ),
              ########### 下载按钮  ###########
              
              
              ########### 坐标图  ###########
              box(
                title = "Family gene coordinate information",
                status = "info",
                solidHeader = TRUE,
                width = 12,
                height = "720px",
                collapsible = TRUE,
                plotOutput("gene_loc",width = "90%"),
                
                
                
                p("  ")
              ),
              ########### 下载按钮  ###########
              
              
              
              
              

              dataTableOutput("family.gene.table"),
      ),

# 单个分子的结构信息 -----------------------------------------------------------------

# 
#       tabItem(tabName = "tab5",
#               r3dmolOutput("m3d_show")
#       ),

# 一个家族内多个成员的结构信息 ----------------------------------------------------------


      tabItem(tabName = "tab6",
              
              fluidRow(column(8,sliderInput("percent","Number of family member structures to  visualize :",min= 2,max= 5,step= 1,value= 2))),
              
              uiOutput("boxes")
              
              #uiOutput("mol_images")
              
      )


# 后续的括号 -------------------------------------------------------------------



    )
  )
)






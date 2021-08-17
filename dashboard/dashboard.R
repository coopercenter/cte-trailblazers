library(shiny)
library(shinydashboard)

#nonduplicated <- read.csv(here::here('Projections_2018_28_cleaned.csv'))
#source(here::here('generating_1st_cluster_graphs.R'))
#source(here::here('generating_2nd_cluster_graphs.R'))
#source(here::here("generating_3rd_cluster_graphs.R"))
#info_text <- read.csv(here::here('informational_text.csv'))
#source(here::here('text_blocks.R'))
source(here::here('text_objects.R'))
source(here::here('all_graph_objects_in_one_place.R'))
title <- tags$a(
  href = "https://ctetrailblazers.org/",
  tags$img(
    src = "http://ctetrailblazers.org/wp-content/uploads/2015/01/Header1000X288_smallerimage.jpg",
    height = '92',
    #width = '50'
  ),
)

dbHeader <-
  dashboardHeader(
    title = title,
    tags$li(
      class = "dropdown",
      tags$style(".main-header {max-height: 60px}"),
      tags$style(
        ".main-header .logo {height: 60px;
        line-height: 55px !important;
        padding: 0 0px;}"
      ),
      tags$style(
        ".main-header .sidebar-toggle {height: 60px;
        line-height: 55px !important;
        padding: 0 20px;}"
      )
    ),
    titleWidth = 500
  )

ui <- fluidPage(titlePanel(dbHeader),
                fluidRow(
                  column(4,
                         wellPanel(
                           helpText(
                             "Welcome to the Trailblazers Cluster Briefs Dashboard! Please select an industry cluster below to see charts and information on the selected industry"
                           ),
                           selectInput(
                             inputId = "clusters",
                             label = "Select a Cluster to Display",
                             choices = c(
                               "Agriculture, Food, and Natural Resources",
                               "Architecture and Construction",
                               "Arts, Audio/Video Technology, and Communications",
                               "Business Management and Administration",
                               "Education and Training",
                               "Finance",
                               "Government and Public Administration",
                               "Health Science",
                               "Hospitality and Tourism",
                               "Human Services",
                               "Information Technology",
                               "Law, Public Safety, Corrections, and Security",
                               "Manufacturing",
                               "Marketing",
                               "Science, Technology, Engineering, and Mathematics",
                               "Transportation, Distribution, and Logistics",
                               "Energy"
                             ) #close input choices list
                           ), #close selection object
                           h3("Cluster Summary Information"),
                            textOutput('cluster_info'),
                           h3("What trends do we currently see? What trends may we anticipate?"),
                           textOutput('cluster_trend')
                         ) #close wellPanel
                         ), #close column
                  
                  column(8,
                         mainPanel(
                           h4('Education'),
                           textOutput('figure_1_text'),
                           plotOutput("plot1"),
                           h4("Employment"),
                           textOutput('figure_2_text'),
                           plotOutput("plot2"),
                           h4('Earnings and Growth'),
                           textOutput('figure_3_text'),
                           plotOutput("plot3")) #close main panel

                  
                ) #close column
                ) #Close fluidRow
                ) #close UI

server <- function(input, output){
  clusterSummary <- reactive({switch(
    input$clusters,
    "Agriculture, Food, and Natural Resources"= Ag_text,
    "Architecture and Construction"=Arc_text,
    "Arts, Audio/Video Technology, and Communications"=Arts_text,
    "Business Management and Administration"=Bus_text,
    "Education and Training"=Edu_text,
    "Finance"=Fin_text,
    "Government and Public Administration"= Gov_text,
    "Health Science"=Health_text,
    "Hospitality and Tourism"=Tour_text,
    "Human Services"=Hum_text,
    "Information Technology"=IT_text,
    "Law, Public Safety, Corrections, and Security"=Law_text,
    "Manufacturing"=Manuf_text,
    "Marketing"=Mark_text,
    "Science, Technology, Engineering, and Mathematics"=STEM_text,
    "Transportation, Distribution, and Logistics"=Transp_text,
    "Energy"=Energy_text
  )})
  
  graph1 <- reactive({switch(
    input$clusters,
    "Agriculture, Food, and Natural Resources"=Ag_graph_1,
    "Architecture and Construction"=Arc_graph_1,
    "Arts, Audio/Video Technology, and Communications"=Arts_graph_1,
    "Business Management and Administration"=Bus_graph_1,
    "Education and Training"=Edu_graph_1,
    "Finance"=Fin_graph_1,
    "Government and Public Administration"=Gov__graph_1,
    "Health Science"=Health_graph_1,
    "Hospitality and Tourism"= Tour_graph_1,
    "Human Services"=Hum_graph_1,
    "Information Technology"=IT_graph_1,
    "Law, Public Safety, Corrections, and Security"=Law_graph_1,
    "Manufacturing"=Manuf_graph_1,
    "Marketing"=Mark_graph_1,
    "Science, Technology, Engineering, and Mathematics"=Sci_graph_1,
    "Transportation, Distribution, and Logistics"=Transp_graph_1,
    "Energy"=Energy_graph_1
  )})
  
  graph2 <- reactive({switch(
    input$clusters,
    "Agriculture, Food, and Natural Resources"=Ag_graph_2,
    "Architecture and Construction"=Arc_graph_2,
    "Arts, Audio/Video Technology, and Communications"=Arts_graph_2,
    "Business Management and Administration"=Bus_graph_2,
    "Education and Training"=Edu_graph_2,
    "Finance"=Fin_graph_2,
    "Government and Public Administration"=Gov__graph_2,
    "Health Science"=Health_graph_2,
    "Hospitality and Tourism"= Tour_graph_2,
    "Human Services"=Hum_graph_2,
    "Information Technology"=IT_graph_2,
    "Law, Public Safety, Corrections, and Security"=Law_graph_2,
    "Manufacturing"=Manuf_graph_2,
    "Marketing"=Mark_graph_2,
    "Science, Technology, Engineering, and Mathematics"=Sci_graph_2,
    "Transportation, Distribution, and Logistics"=Transp_graph_2,
    "Energy"=Energy_graph_2
  )})
  
  graph3 <- reactive({switch(
    input$clusters,
    "Agriculture, Food, and Natural Resources"=Ag_graph_3,
    "Architecture and Construction"=Arc_graph_3,
    "Arts, Audio/Video Technology, and Communications"=Arts_graph_3,
    "Business Management and Administration"=Bus_graph_3,
    "Education and Training"=Edu_graph_3,
    "Finance"=Fin_graph_3,
    "Government and Public Administration"=Gov__graph_3,
    "Health Science"=Health_graph_3,
    "Hospitality and Tourism"= Tour_graph_3,
    "Human Services"=Hum_graph_3,
    "Information Technology"=IT_graph_3,
    "Law, Public Safety, Corrections, and Security"=Law_graph_3,
    "Manufacturing"=Manuf_graph_3,
    "Marketing"=Mark_graph_3,
    "Science, Technology, Engineering, and Mathematics"=Sci_graph_3,
    "Transportation, Distribution, and Logistics"=Transp_graph_3,
    "Energy"=Energy_graph_3
  )})
  
  output$cluster_info <-renderText({
    clus <- clusterSummary()
    info_text[[clus]]
  })

  
  output$plot1 <- renderPlot({ 
    #clusterx <- input$clusters
    #generate_cluster_graph_1(nonduplicated, clusterx)
    graph1()
  })

  output$plot2 = renderPlot({
    #clusterx <- input$clusters
    #generate_cluster_graph_2(nonduplicated,clusterx)
    graph2()
  })
  
  output$plot3 = renderPlot({
    #clusterx <- input$clusters
    #generate_cluster_graph_3(nonduplicated,clusterx)
    graph3()
  })
  
  output$figure_1_text <- renderText({
    "Figure 1 shows the predominant education levels of occupations by CTE career pathway. The percentages reflect the number of occupations at each educational level within a pathway, not the number of workers. The predominant level of education for each occupation is determined by Trailblazers based on national-level U.S. Bureau of Labor Statistics data."
  })
  
  output$figure_2_text <- renderText({
    "Figure 2 compares the estimated 2018 number of jobs in Virginia within each CTE career pathway to the projected 2028 number of jobs. Data are provided by the Virginia Employment Commission."
  })
  
  output$figure_3_text <- renderText({
    "Figure 3 presents the median 2018 annual incomes of occupations in Virginia by CTE career pathway. Data are provided by the Virginia Employment Commission."
  })
  
  output$cluster_info <- renderText({
    text_list <- clusterSummary()
    text_list[1]
  })
  
  output$cluster_trend <- renderText({
    text_list <- clusterSummary()
    text_list[-1]
  })
}

shinyApp(ui=ui, server=server)

library(shiny)
library(shinydashboard)
library(shinyWidgets)

#nonduplicated <- read.csv(here::here('Projections_2018_28_cleaned.csv'))
#source(here::here('generating_1st_cluster_graphs.R'))
#source(here::here('generating_2nd_cluster_graphs.R'))
#source(here::here("generating_3rd_cluster_graphs.R"))
#info_text <- read.csv(here::here('informational_text.csv'))
source('text_objects.R')
# source('all_graph_objects_in_one_place.R')
# source('ggobjects.R')

all_ggplots_list  <- readRDS("all_ggplots_list.Rds")
cluster_names_vec <- readRDS("cluster_names_vec.Rds")

clusters <- c(
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
)


dbHeader <-
  dashboardHeader(
    tags$li(
      class = "dropdown",
      tags$style(".main-header {max-height: 50px}"),
      tags$style(
        ".main-header .logo {height: 50px;
        line-height: 55px !important;
        padding: 0 0px;}"
      ),
      tags$style(
        ".main-header .sidebar-toggle {height:50px;
        line-height: 55px !important;
        padding: 0 00px;}"
      )
    ),
    # tags$li(a(
    #   href = 'https://ctetrailblazers.org/',
    #   tags$img(
    #     src = 'http://ctetrailblazers.org/wp-content/uploads/2015/01/Header1000X288_smallerimage.jpg',
    #     height = '82'
    #   )
    # ), class = "dropdown"),
    # tags$li(a(
    #   href = 'https://ceps.coopercenter.org/',
    #   tags$img(
    #     src = 'CCPS-Logo_Horiz_Color.png',
    #     height = '62'
    #   )
    # ), class = "dropdown"),
    titleWidth = 0
  )

black_line <- hr(style = "border-top: 1px solid #000000;")

ui <- fluidPage(titlePanel(dbHeader),
                fluidRow(
                   column(width = 12,
                      HTML(
                  '<h1 style="text-align:left;">Virginia Labor Market: Career Cluster Analysis</h1>
                  <br>'
                      )
                    )
                  ),
                fluidRow(
                  # column(4,
                  #        wellPanel(
                  #           h3(#"Please select a cluster from the dropdown menu below to see charts and information on the cluster"
                  #          ),
                  #          # selectInput(
                  #          #   inputId = "clusters",
                  #          #   label = "Select a Cluster to Display",
                  #          #   choices = clusters
                  #          # ), #close selection object
                  #          # h3("What trends do we currently see? What trends may we anticipate?"),
                  #          # textOutput('cluster_trend_bullet_1'),
                  #          # br(),
                  #          # textOutput('cluster_trend_bullet_2'),
                  #          # br(),
                  #          # textOutput('cluster_trend_bullet_3'),
                  #          # br(),
                  #          # textOutput('cluster_trend_bullet_4'),
                  #          # br(),
                  #          # textOutput('cluster_trend_bullet_5')
                  #        ) #close wellPanel
                  #        ), #close column
                  
                  #                  column(12,
                  mainPanel(
                    wellPanel(
                      
                      
                      selectInput(
                        inputId = "clusters",
                        label = "Select a Cluster to Display",
                        choices = clusters
                      ) #close selection object
                    ), # close wellPanel
                    
                    #box(
                    h2('Education'),
                    h5("Distribution of predominant education levels, by career pathway"),
                    
                    plotOutput("plot1"),
                    h5('Predominant education levels among occupations in each career pathway within the cluster, 2018 - 2028.
                                Reported percentages are based on the number of occupations at each educational level within a pathway. 
                                Percentages are not based on the number of workers employed in each pathway. 
                                Reported education levels reflect both the prevailing requirements of occupations and the typical level of education attained by workers employed in the occupations. 
                                Source: Determined by Trailblazers based on national-level data from the U.S. Bureau of Labor Statistics.')
                    #) #close box
                    ,
                    
                    black_line,
                    
                    #box(
                    h2("Occupational Growth"),
                    h5("Projected growth in number of jobs, Virginia, 2018 - 2028"),
                    plotOutput("plot2"),
                    h5("Projected change in the number of jobs in Virginia within each career pathway, 2018 - 2028. 
                                Shows change between estimated number of jobs in each pathway in 2018 versus projected number in 2028. (Projected percent change in parentheses.) 
                                Source: Virginia Employment Commission.")
                    # ) #close box
                    ,
                    
                    black_line,
                    
                    # box(
                    h2('Wages'),
                    h5("Median 2018 annual wages in Virginia"),
                    plotOutput("plot3"),
                    h5("Figure displays the median 2018 Virginia annual wages of all occupations within each pathway. 
                                Source: Virginia Employment Commission.")
                    # ), # close box
                    ,
                    
                    black_line,
                    
                    # add trends
                    h2("Trends"),
                    textOutput('cluster_trend_bullet_1'),
                    br(),
                    textOutput('cluster_trend_bullet_2'),
                    br(),
                    textOutput('cluster_trend_bullet_3'),
                    br(),
                    textOutput('cluster_trend_bullet_4'),
                    br(),
                    textOutput('cluster_trend_bullet_5')
                    
                  ) #close main panel
                  
                  
                  #                ) #close column
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
    all_ggplots_list$edu[[which(cluster_names_vec == input$clusters)]]
  )})
  
  graph2 <- reactive({switch(
    input$clusters,
    all_ggplots_list$job_growth[[which(cluster_names_vec == input$clusters)]]
  )})
  
  graph3 <- reactive({switch(
    input$clusters,
    all_ggplots_list$wages[[which(cluster_names_vec == input$clusters)]]
  )})
  
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
  
  output$cluster_trend_bullet_1 <- renderText({
    text_list <- clusterSummary()
    text_list[1]
  })
  
  output$cluster_trend_bullet_2 <- renderText({
    text_list <- clusterSummary()
    text_list[2]
  })
  
  output$cluster_trend_bullet_3 <- renderText({
    text_list <- clusterSummary()
    text_list[3]
  })
  
  output$cluster_trend_bullet_4 <- renderText({
    text_list <- clusterSummary()
    text_list[4]
  })
  
  output$cluster_trend_bullet_5 <- renderText({
    text_list <- clusterSummary()
    text_list[5]
  })
}

shinyApp(ui=ui, server=server)
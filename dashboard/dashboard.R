library(shiny)
library(shinydashboard)

nonduplicated <- read.csv(here::here('Projections_2018_28_cleaned.csv'))
source(here::here('generating_1st_cluster_graphs.R'))
source(here::here('generating_2nd_cluster_graphs.R'))
source(here::here("generating_3rd_cluster_graphs.R"))

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
                           helpText(label="Cluster Summary",
                            textOutput('cluster_info')
                           )
                         ) #close wellPanel
                         ), #close column
                  
                  column(8,
                         #fluidRow(column(
                           #width = 12, plotOutput("plot1")
                         #)),
                         #fluidRow(column(
                           #width = 12, plotOutput("plot2")
                         #)),
                         #fluidRow(column(
                           #width = 12, plotOutput("plot3")
                         #)))
                         mainPanel(
                           plotOutput("plot1"),
                           plotOutput("plot2"),
                           plotOutput("plot3")) #close main panel

                  
                ) #close column
                ) #Close fluidRow
                ) #close UI

server <- function(input, output){
  clusterSummary <- reactive({switch(
    input$clusters,
    "Agriculture Food and Natural Resources",
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
  )})
  
  output$plot1 <- renderPlot({ 
    clusterx <- input$clusters
    generate_cluster_graph_1(nonduplicated, clusterx)
  })

  output$plot2 = renderPlot({
    clusterx <- input$clusters
    generate_cluster_graph_2(nonduplicated,clusterx)
  })
  
  output$plot3 = renderPlot({
    clusterx <- input$clusters
    generate_cluster_graph_3(nonduplicated,clusterx)
  })
}

shinyApp(ui=ui, server=server)

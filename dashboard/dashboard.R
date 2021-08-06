library(shiny)

ui <- fluidPage(titlePanel("Hello Shiny!"),
                
                fluidRow(
                  column(4,
                         wellPanel(
                           selectInput(
                             inputId = "cluster",
                             label = "Select a Cluster to Display",
                             choices = c(
                               "Agriculture Food and Natural Resources",
                               "Architecture and Construction",
                               "Arts, AV Technology, and Communications",
                               "Business Management and Administration",
                               "Education and Training",
                               "Energy",
                               "Finance",
                               "GOvernment and Public Administration",
                               "Health Science",
                               "Hospitality and Tourism",
                               "Human Services",
                               "Information Technology",
                               "Law, Public Safety, Corrections, and Security",
                               "Manufacturing"
                             )
                           )
                         )),
                  
                  column(8,
                         fluidRow(column(
                           width = 12, plotOutput("plot1")
                         )),
                         `fluidRow(column(
                           width = 12, plotOutput("plot2")
                         )),
                         fluidRow(column(
                           width = 12, plotOutput("plot3")
                         )))
                ))   

server <- function(input, output){
  'clusterInput <- reactive(
    # wait to setup until viz format it finalized 
    switch(input$cluster, c(
           "Agriculture Food and Natural Resources"
           "Architecture and Construction",
           "Arts, AV Technology, and Communications",
           "Business Management and Administration",
           "Education and Training",
           "Energy",
           "Finance",
           "GOvernment and Public Administration",
           "Health Science",
           "Hospitality and Tourism",
           "Human Services",
           "Information Technology",
           "Law, Public Safety, Corrections, and Security",
           "Manufacturing"
           )
    
  cluster = clusterInput()
  '
  # some code to get the visualizations goes here
  
  # placeholder for now
  output$plot1 = renderPlot(hist(mtcars$mpg))
  output$plot2 = renderPlot(hist(mtcars$dist))
  outpot$plot3 = renderPlot(hist(mtcars$hp))
}

shinyApp(ui=ui, server=server)

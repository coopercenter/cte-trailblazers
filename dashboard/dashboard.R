library(shiny)
library(shinydashboard)

title <- tags$a(
  href = "https://www.dmme.virginia.gov/",
  tags$img(
    src = "DmmeLogo.png",
    height = '30',
    #width = '50'
  ),
  "Virginia Clean Economy Progress"
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
    tags$li(a(
      href = 'https://ceps.coopercenter.org/',
      tags$img(
        src = 'CCPS-Logo_Horiz_White.png',
        height = '30',
        width = '200'
      )
    ), class = "dropdown"),
    titleWidth = 500
  )


ui <- tagList(dashboardPage(dbHeader,
                            dashboardSidebar(
                              tags$style(".left-side, .main-sidebar {padding-top: 60px}"),
                              width = "0px",
                              sidebarMenu(
                                menuItem("Main", tabName = "main")
                              )
                            ),
                            dashboardBody(
                              tabItems(
                                tabItem(
                                  tabName = "main",
                                  h1("CTE Tralblazers Cluster Summary"),
                                  fluidRow(
                                    box(width = 6, selectInput(
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
                                    ),
                                    box(width = 6, plotOutput("plot1"))
                                  ),
                                  fluidRow(
                                    box(width = 6, plotOutput("plot2")),
                                    box(width = 6, plotOutput("plot3"))
                                  )
                                )
                              )
                            )
                        )
                      )


server <- function(input, output){
  clusterInput <- reactive({
    # wait to setup until viz format it finalized
    switch(input$cluster, c(
           "Agriculture Food and Natural Resources" = c(agri1, agri2, agri3),
           "Architecture and Construction" = construct,
           "Arts, AV Technology, and Communications" = arts,
           "Business Management and Administration" = business,
           "Education and Training" = edu,
           "Energy" = energy,
           "Finance" = finance,
           "Government and Public Administration" = govt,
           "Health Science" = health,
           "Hospitality and Tourism" = tours,
           "Human Services" = humans,
           "Information Technology" = IT,
           "Law, Public Safety, Corrections, and Security" = law,
           "Manufacturing" = manufact
              )
          )
  })
    

  # placeholder for now
  output$plot1 = renderPlot(hist(mtcars$mpg))
  output$plot2 = renderPlot(hist(mtcars$disp))
  output$plot3 = renderPlot(hist(mtcars$hp))
}

shinyApp(ui=ui, server=server)

# title <- tags$a(
#   href = "https://ctetrailblazers.org/",
#   tags$img(
#     src = "http://ctetrailblazers.org/wp-content/uploads/2015/01/Header1000X288_smallerimage.jpg",
#     height = '1'
#     #width = '50'
#   )
# )


dbHeader <-
  dashboardHeader(
    tags$li(
      class = "dropdown",
      tags$style(".main-header {max-height: 100px}"),
      tags$style(
        ".main-header .logo {height: 100px;
        line-height: 55px !important;
        padding: 0 0px;}"
      ),
      tags$style(
        ".main-header .sidebar-toggle {height: 100px;
        line-height: 55px !important;
        padding: 0 00px;}"
      )
    ),
    tags$li(a(
      href = 'https://ceps.coopercenter.org/',
      tags$img(
        src = 'CCPS-Logo_Horiz_Color.png',
        height = '62'
      )
    ), class = "dropdown"),
    tags$li(a(
      href = 'https://ctetrailblazers.org/',
      tags$img(
        src = 'http://ctetrailblazers.org/wp-content/uploads/2015/01/Header1000X288_smallerimage.jpg',
        height = '82'
      )
    ), class = "dropdown"),
    titleWidth = 0
  )
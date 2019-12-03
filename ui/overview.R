# Define overview page layout
overview <- tabPanel(
  "Overview",
  titlePanel(em("Overview", style = "font-family: 'Trebuchet MS'")),
  fluidRow(
    column(
      8,
      offset = 2,
      h2("Topic", style = "font-family: 'Trebuchet MS'"),
      p("Our domain of interest is Homelessness. In the Seattle King County area,
      there are about 12,500 homeless people living on the streets or in shelters.
        This not only makes the living environment of Seattle worse but also impacts
        the citizens’ daily life(crime, policing, junk/RVs, harassment etc).
        Confronted with this in our daily lives, we are interested in better
        understanding the issue locally and nationally including some of the
        factors contributing to it.", style = "font-size:12pt"),
      HTML('<center><img src="img.jpg" width = "1200" height = "600"></center>'),
      h2("Our Data Source", style = "font-family: 'Trebuchet MS'"),
      tableOutput("table"),
      tags$style(type="text/css", "#table {font-size:12pt;}")
    )
  ),
)

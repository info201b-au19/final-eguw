# Define overview page layout
overview <- tabPanel(
  "Overview",
  fluidRow(
    column(
      8,
      offset = 2,
      align = "center",
      h2("Topic", style = "font-family: 'Trebuchet MS'"),
      p("Our domain of interest is Homelessness. In the Seattle King County area,
      there are about 12,500 homeless people living on the streets or in shelters.
        This not only makes the living environment of Seattle worse but also impacts
        the citizens daily life(crime, policing, junk/RVs, harassment etc).
        Confronted with this in our daily lives, we are interested in better
        understanding the issue locally and nationally including some of the
        factors contributing to it.", style = "font-size:12pt"),
      h2("We have the following questions", style = "font-family: 'Trebuchet MS'"),
      tags$ul(
        tags$li("What homeless populations most often secure shelter, and how does it vary between states?"), 
        tags$li("Is there a positive relation between Consumer Price Index(CPI) and homeless population?"), 
        tags$li("Is there a correlation between crime rates and homelessness in certain regions?"),
        style = "font-family: 'Trebuchet MS'; font-size:14pt;
        font-style: italic; line-height: 1.8; list-style-position: inside"
      ),
      HTML('<center><img src="img.jpg" width = "75%" height = "75%"></center>'),
      h2("Our Data Source", style = "font-family: 'Trebuchet MS'"),
      tableOutput("table"),
      tags$style(type="text/css", "#table {font-size:12pt;}")
    )
  ),
)

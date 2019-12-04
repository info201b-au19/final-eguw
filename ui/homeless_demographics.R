# Define interactive page 1
homeless_demographics <- tabPanel(
  "Homeless Demograpics",
  titlePanel(em("Homeless Population Statistics", style = "font-family: 'Trebuchet MS'")),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "analysis",
                  label = "Analysis",
                  choices = c("Shelter","Family"),
                  selected = "Shelter")
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
  
)
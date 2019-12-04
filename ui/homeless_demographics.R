# Define interactive page 1
homeless_demographics <- tabPanel(
  "Homeless Demograpics",
  titlePanel(em("Homeless Population Statistics", style = "font-family: 'Trebuchet MS'")),
  fluidRow(
    column(
      8,
      offset = 2,
      leafletOutput("map"),
      selectInput(inputId = "analysis",
                  label = "Analysis",
                  choices = c("Shelter","Family"),
                  selected = "Shelter")
    )
  )
)
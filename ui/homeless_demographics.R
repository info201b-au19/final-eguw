# Define interactive page 1
homeless_demographics <- tabPanel(
  "Homeless Demograpics",
  titlePanel("Homeless Population Statistics"),
  
  leafletOutput("map"),
  
  fluidRow(
    column(
      8,
      offset = 2,
      selectInput(inputId = "analysis",
                  label = "Analysis",
                  choices = c("Shelter","Family"),
                  selected = "Shelter")
    )
  )
)
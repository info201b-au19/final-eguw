# Define interactive page 1
homeless_demographics <- tabPanel(
  "Homeless Demograpics",
  titlePanel("Homeless Population Statistics"),
  
  shelter_analysis(homeless_population_analysis),
  
  fluidRow(
    column(
      8,
      offset = 2,
      h4("Controls Placeholder")
    )
  )
)
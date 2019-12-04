# Define interactive page 1
homeless_demographics <- tabPanel(
  "Homeless Demograpics",
  titlePanel(em("Homeless Population Statistics",
                style = "font-family: 'Trebuchet MS'")),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "analysis",
                  label = "Analysis",
                  choices = c("Shelter", "Family"),
                  selected = "Shelter"),
      p("Use the control above and map to view different aspects of the 
      homeless population, and how they vary from state to state. You can see 
      the ratio of sheltered to unsheltered homeless, as well as those which 
      have family and those who do not.")
    ),
    mainPanel(
      leafletOutput("map")
    )
  )

)
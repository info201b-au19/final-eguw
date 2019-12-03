# Define interactive page 3
CR_HR <- tabPanel(
  "Crime Rate and Homelessness Rate by State",
  titlePanel("Is Homelessness Correlated to Crime Rates?"),
  
  # Sidebar layout
  sidebarLayout(
    # Controls
    sidebarPanel(
      selectInput(
        "selected", 
        label = "Select Crime",
        choices = list("Murder" = 1, "Rape" = 2), 
        selected = "Murder"
      ), 
      
      # Controls
    ),
    # Visualization
    mainPanel(
      # Visualization
    )
  )
)
# Define interactive page 3
CR_HR <- tabPanel(
  "Crime Rate and Homelessness Rate by State",
  titlePanel("Homelessness vs Crime"),
  
  # Sidebar layout
  sidebarLayout(
    # Controls
    sidebarPanel(
      #user chooses which crime they want to see on the graph 
      #with homeless rate
      selectInput(
        inputId = "selected", 
        label = "Select Crime",
        choices = list("crime_rate" = 3, "murder_rate" = 4, "robbery_rate" = 5, 
                       "rape_rate" = 6, "assault_rate" = 7, "burglary_rate" = 8, 
                       "larceny_rate" = 9, "mvtheft_rate" = 10), 
        selected = 3
      ), 
      
      # Controls
    ),
    # Visualization
    mainPanel(
      # Visualization
      plotlyOutput(outputId = "crimes_scats")
    )
  )
)
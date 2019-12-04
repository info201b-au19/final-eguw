# Define interactive page 3
CR_HR <- tabPanel(
  "Crime Rate and Homelessness Rate by State",
  titlePanel(em("Homelessness vs Crime", style = "font-family: 'Trebuchet MS'")),
  
  # Sidebar layout
  sidebarLayout(
    # Controls
    sidebarPanel(
      #user chooses which crime they want to see on the graph 
      #with homeless rate
      selectInput(
        inputId = "selected", 
        label = "Select Crime",
        choices = c("crime_rate", "murder_rate", "robbery_rate", 
                       "rape_rate", "assault_rate", "burglary_rate", 
                       "larceny_rate", "mvtheft_rate"), 
        selected = "crime_rate"
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
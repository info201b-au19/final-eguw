# Summary page
summary <- tabPanel(
  "Summary",
  titlePanel(em("Conclusions", style = "font-family: 'Trebuchet MS'")),
  fluidRow(
    column(
      8,
      offset = 2,
      h3("What populations are impacted by homelessness?"),
      p("There is a clear trend of greater amounts of homeless individuals without family,  
      then those with. This is likely due to the safety net that a family typically provides, 
      keeping family members out of homelessness."),
      h3("How many homeless are sheltered?"),
      p("There are vast disparities between states when it comes to the portion of homeless with shelter. 
      California for example had nearly twice as many unsheltered homeless as sheltered in 2016. 
      Where as only 4% of the homeless were unsheltered in Nebraska."),
      br(),
      br()
    )
  ),
  fluidRow(
    column(
      4,
      offset = 2,
      plotOutput("reg")
    ),
    column(
      4,
      h3("Which cities are most impacted by homelessness?"),
      p("Based on the bar chart we presented, New York(not in the graph because
      homeless rate is too high), San Francisco, San Jose, Seattle and Atlanta
      are with the highest homeless rate among all cities in the United States
      (and they all have high CPIs)."),
      h3("Is there a relationship between CPI and homeless ratio?"),
      p("Yes. Take a look at the regression line we drew, you will find that
      R = 0.54, meaning the model fits 54% of the data and the p-value = 3e-08,
      indicating strong evidence that the there is correlation between
      CPI(w/ Rent) and Homeless Population.")
    ),
    column(3),
  ),
  fluidRow(
    column(
      8,
      offset = 2,
      h3("Questions here"),
      p("Crime rate summary here")
    )
  )
)
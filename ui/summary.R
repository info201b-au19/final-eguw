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
      Where as only 4% of the homeless were unsheltered in Nebraska.")
    )
  ),
  fluidRow(),
  fluidRow()
)
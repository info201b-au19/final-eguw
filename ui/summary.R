# Summary page
summary <- tabPanel(
  "Summary",
  titlePanel(em("Conclusions", style = "font-family: 'Trebuchet MS'")),
  fluidRow(
    column(
      4,
      offset = 2,
      h2(strong("Homeless Populations",
        style = "font-family: 'Trebuchet MS'"
      )),

      # questions the homeless pop data and graphs can answer
      h3("What populations are impacted by homelessness?"),
      p("There is a clear trend of greater amounts of
        homeless individuals without family, then those with.
        This is likely due to the safety net that a family typically provides, 
        keeping family members out of homelessness."),
      h3("How many homeless are sheltered?"),
      p("There are vast disparities between states when it comes to
        the portion of homeless with shelter. California for example had nearly 
        twice as many unsheltered homeless as sheltered in 2016. 
        Where as only 4% of the homeless were unsheltered in Nebraska."),
      br(),
      br()
    ),
    column(
      4,
      offset = 2,
      tableOutput("fam_demographic_table"),
      br(),
      tableOutput("shelter_demographic_table"),
      br()
    ),
    
  ),
  
  fluidRow(
    column(
      4,
      offset = 2,
      plotOutput("reg")
    ),
    column(
      4,
      h2(strong("CPI", style = "font-family: 'Trebuchet MS'")),
      # questions that can be answered by CPI graphs and data
      h3("Which cities are most impacted by homelessness?"),
      p("Based on the bar chart we presented, New York(not in the graph because
        homeless rate is too high), San Francisco, San Jose, Seattle and Atlanta
        are with the highest homeless rate among all cities in the United States
        (and they all have high CPIs)."),
      h3("Is there a relationship between CPI and homeless ratio?"),
      p("Yes. Take a look at the regression line we drew, you will find that
        R = 0.54, meaning the model fits 54% of the data and the p-value = 3e-08,
        indicating strong evidence that the there is correlation between
        CPI(w/ Rent) and Homeless Population."),

      br(),
      br()
    ),
    column(3),
  ),
  fluidRow(
    column(
      4,
      offset = 2,
      h2(strong("Crime", style = "font-family: 'Trebuchet MS'")),

      # Questions that can be answered through the graph
      h3("Which crimes are most common amongst the homeless?"),
      p("From comparing the graphs, you can see that mostly 
        non-violent crimes (i.e. burglary and larceny) are more 
        common than violent ones(i.e. rape and assault). You might be
        asking yourself, 'why?'. Although we cannot answer definitively,
        one possible answer is that the homeless
        are just trying to by. Since they do not have 
        the resources to properly provide for themselves or even
        their families, they could possibly turn to
        theft to attain those resources."),
      h3("Overall, Is there a correlation between homlessness rates and crime rates?"),
      p("Yes there is, as you can see from our graph, there is a slight positive 
        correlation between crime rates and homelessness. Meaning that as state crime 
        rates go up, so do state homelessness rates. Although this tells us that there 
        is a positive correlation, it does not tell us causation of the results."),

      # broader implications
      h3("What does this all mean?"),
      p("This means that we, as a society, need to be doing a better 
        job at helping out the homeless. We need to remind ourselves that 
        it is not a crime to be homeless. If we can help get better resources
        for them then we can possibly lower the non-violent crime rates.")
    ),
    column(
      4,
      offset = 1,
      # plot for crime in summary
      plotlyOutput("sum_scat")
    )
  )
)

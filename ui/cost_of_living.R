cost_of_living <- tabPanel(
  "Cost of Living",
  setBackgroundColor("#DEEEFF"),
  titlePanel(em("Is Homeless rate related to Cost of Living?")),
  sidebarLayout(
    sidebarPanel(
      helpText(h4(em("Settings"))),
      selectInput(
        inputId = "control1",
        label = "Choose an Index",
        choices = c("Cost.of.Living.Index", "Rent.Index",
                    "Cost.of.Living.Plus.Rent.Index", "Groceries.Index",
                    "Local.Purchasing.Power.Index", "Monthly.Pass"),
        selected = "Cost.of.Living.Plus.Rent.Index"
      ),
      checkboxInput("control2", label = "Smoothed Curve", value = FALSE),
      tags$head(
        tags$style(type = "text/css", ".well { max-width: 350px; }")
      )
    ),
    mainPanel(
      h2("Plots Analysis", style = "font-family: 'Trebuchet MS'"),
      p("As you can see in the scatter plot, the smoothed curve indicates
          that there is a potential correlation between CPI and Homeless rate
          (check the box to show a smoothed curve). However, it is not quite
          obvious. To visualize the potential correlation between higher cost
          of living and Homeless rate, we have included another chart for
          better comparison. Also, you can choose other indices for
          comparison!", style = "font-size:16pt"
      ),
      fluidRow(
        column(width = 5, plotlyOutput("scatter")),
        column(width = 7, plotOutput("bar"))),
      htmlOutput(outputId = "space"),
      verbatimTextOutput(outputId = "note"),
      p("This bar chart includes 10 representative cities ranging from cities
        with below average CPIs(or your choice of Index) to those with the
        higest CPIs. As you can tell, as the CPI goes up, the Homelessness
        rates goes up. We have calculated the number of Homeless people in 1
        Million people to eliminate the influence by city population(larger
        cities tend to have higher CPIs and higher population, which means more
        homeless people). Note that Atlanta and Seattle are two outlier in this
        comparison, with unusual high population of Homeless. However, this
        can't deny that Homeless rate is correlated with CPI. We should be
        cocerned that Seattle's high homeless population has something to do
        with other factors such as lack of governance and bad drug
        control, etc.", style = "font-size:16pt"
      )
    )
  )
)

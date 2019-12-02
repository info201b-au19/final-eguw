# Load dependencies
## Libraries ##
library(shiny)
library(dplyr)
library(leaflet)
library(leaflet.minicharts)
library(ggplot2)
library(reshape2)
library(ggpubr)
library(stringr)
library(tidyr)
library(plotly)
library(shinyWidgets)
## Scripts ##
source("./scripts/data_wrangling.R")
source("scripts/shelter.R")
source("scripts/cos_charts.R")

# Read in datasets
cpi_2016 <- read.csv("data/cost-of-living/cost-of-living-2016.csv",
  stringsAsFactors = FALSE
)
states <- read.csv("data/homelessness/states.csv", stringsAsFactors = FALSE)
state_populations <- read.csv("data/homelessness/Population-by-state.csv",
  stringsAsFactors = FALSE
)
homelessness <- read.csv("data/homelessness/2007-2016-Homelessnewss-USA.csv",
  stringsAsFactors = FALSE
)

# Define server, and pass input values to visualization functions
server <- shinyServer(function(input, output) {
  output$scatter <- renderPlotly({
    sc <- get_chart(cpi_2016, homelessness, input$control1, 1)
    if (input$control2) {
      sc <- sc + geom_smooth()
    }
    sc <- ggplotly(sc, width = 500) %>% layout(autosize = FALSE)
    sc
  })

  output$bar <- renderPlot({
    bar <- get_chart(cpi_2016, homelessness, input$control1, 2)
    bar
  }, height = 500, width = 650, bg = "transparent")

  output$space <- renderUI({
    HTML(paste0("<br><br><br><br><br>"))
  })

  output$note <- renderText({
    paste(" Note: You may find that some index(es) is not strongly or not at
    all correlated to homeless rate. We concluded that CPI(w/ Rent) and CPI are
    two most relevant indices to Homeless rate. Which means the homeless
    population is highly realated to the Cost of living in a city.")
  })
})

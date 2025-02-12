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
source("scripts/crime_rate.R")

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
crime_stats <- read.csv("data/united-states-crime-rates-by-county/crime_data_w_population_and_crime_rate.csv",
  stringsAsFactors = FALSE
)

homeless_population_analysis <- population_analysis(states,
                                                    state_populations, 
                                                    homelessness)

# Define server, and pass input values to visualization functions
server <- shinyServer(function(input, output) {

  # shelter visualization
  output$map <- renderLeaflet({
    shelter_analysis(homeless_population_analysis, input$analysis)
  })

  # cost of living Visualization

  
  output$fam_demographic_table <- renderTable({
    select(homeless_population_analysis, state, homeless_indiv, homeless_fam) %>%
    arrange(-homeless_indiv) %>% 
    top_n(5)
  }, width = "75%")
  
  output$shelter_demographic_table <- renderTable({
    select(homeless_population_analysis, state, sheltered_homeless, unsheltered_homeless) %>%
      arrange(-unsheltered_homeless) %>% 
      top_n(5)
  }, width = "75%")
  
  #cost of living

  output$scatter <- renderPlotly({
    sc <- get_chart(cpi_2016, homelessness, input$control1, 1)
    if (input$control2) {
      sc <- sc + geom_smooth()
    }
    sc <- ggplotly(sc, width = 500) %>% layout(autosize = FALSE)
    sc
  })

  output$bar <- renderPlot(
    {
      bar <- get_chart(cpi_2016, homelessness, input$control1, 2)
      bar
    },
    height = 500,
    width = 650,
    bg = "transparent"
  )

  output$reg <- renderPlot(
    {
      reg <- get_chart(cpi_2016, homelessness, "Cost.of.Living.Plus.Rent.Index", 3)
      reg
    },
    height = 375,
    width = 450,
    bg = "transparent"
  )

  output$space <- renderUI({
    HTML(paste0("<br><br><br><br><br>"))
  })

  output$note <- renderText({
    paste(" Note: You may find that some index(es) is not strongly or not at all correlated to homeless rate. We concluded that CPI(w/ Rent) and CPI are
    two most relevant indices to Homeless rate. Which means the homeless population is highly realated to the Cost of living in a city.")
  })

  # crime Visualization passed through function
  output$crimes_scats <- renderPlotly({
    getscatplot(homelessness, crime_stats, input$selected)
  })

  output$ratesnote <- renderText({
    paste("Please note: All rates are per 100000 people in that state")
  })

  # visualization of crime for summary.R
  output$sum_scat <- renderPlotly({
    getscatplot(homelessness, crime_stats, "crime_rate")
  })

  # table for the Overview page showing where we got the data
  output$table <- renderTable(
    {
      sources <- c("Homeless Population",
                   "Cost of Living",
                   "US Crime Rates")
      urls <- c(
        "https://www.kaggle.com/adamschroeder/homelessness/data#",
        "https://www.kaggle.com/andytran11996/cost-of-living#cost-of-living-2018.csv",
        "https://www.kaggle.com/mikejohnsonjr/united-states-crime-rates-by-county"
      )
      refs <- paste0("<a href='", urls, "' target='_blank'>", sources, "</a>")

      source <- data.frame(
        source = refs,
        Collection_Methodology = c(
          "Combines Point-in-Time homeless count estimates with data from the 
          Department of Housing and Urband Development.",
          "Unknown", "Takes information from the US census 
          and national crime data from the counties in the US"
        ),
        Observations = c("86,530", "540", "3136"),
        Features = c("6", "8", "24")
      )
    },
    width = "75%",
    sanitize.text.function = function(x) x
  )
})

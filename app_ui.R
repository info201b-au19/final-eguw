# Load dependencies
library(shiny)
source("app_server.R")
source("./ui/overview.R")
source("./ui/homeless_demographics.R")
source("./ui/cost_of_living.R")
source("./ui/crime_rate.R")
source("./ui/summary.R")

# Build layout
ui <- navbarPage(
    theme = "StyleSheet.css",  # font stylesheet
    "Homelessness",         # application title
    overview,               # include the overview page
    homeless_demographics,  # include the interactive page 1
    cost_of_living,         # include the interactive page 2
    crime_ui,               # include the interactive page 3
    summary,                # include the summary page
)
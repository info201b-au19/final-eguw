# Load dependencies
library(shiny)
source("app_server.R")
source("./ui/overview.R")
source("./ui/interactive1.R")
source("./ui/interactive2.R")
source("./ui/interactive3.R")
source("./ui/summary.R")

# Build layout
ui <- navbarPage(
    "Homelessness", # application title
    overview,       # include the overview page
    interactive_1,  # include the interactive page 1
    interactive_2,  # include the interactive page 2
    interactive_3,  # include the interactive page 3
    summary         # include the summary page
)

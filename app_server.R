# Load dependencies
## Libraries ##
library(shiny)
library(dplyr)
library(leaflet)
library(leaflet.minicharts)
## Scripts ##
source("./scripts/data_wrangling.R")
source("scripts/shelter.R")

# Read in datasets
states <- read.csv("data/homelessness/states.csv", stringsAsFactors = FALSE)
state_populations <- read.csv("data/homelessness/Population-by-state.csv", stringsAsFactors = FALSE)
homelessness <- read.csv("data/homelessness/2007-2016-Homelessnewss-USA.csv", stringsAsFactors = FALSE)

# Define server, and pass input values to visualization functions
server <- shinyServer(function(input, output) {

})

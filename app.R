# Final Project
# Eric, Gabby, Vincent 

# Loading Shiny Library, UI, and Server
library(shiny)
source("app_ui.R")
source("app_server.R")
# Launch Shiny Application
shinyApp(ui = ui, server = server)

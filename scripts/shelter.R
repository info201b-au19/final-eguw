# Eric: Chart 1 (pie chart)
# Proportions of the homeless population that secure shelter
library(dplyr)
library(tidyr)

# return map illustrating homeless population with shelter
shelter_analysis <- function(summary) {

  basemap <- leaflet(data = summary, width = "100%", height = "400px") %>%
    addTiles() %>%
    setView(lng = -95.7129, lat = 37.0902, zoom = 2) %>%
    addMinicharts(
      summary$longitude, summary$latitude,
      type = "pie",
      chartdata = select(summary, sheltered_homeless, unsheltered_homeless),
      width = 20 / summary$sheltered
    )

  return(basemap)
}
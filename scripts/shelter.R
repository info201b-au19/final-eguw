# Eric: Chart 1 (pie chart)
# Proportions of the homeless population that secure shelter
library(dplyr)
library(tidyr)

# return map illustrating homeless population with shelter
shelter_analysis <- function(summary, choice) {
  colors <- c("#3FCC87","#7C998B")
  shelter <- summary %>% select(sheltered_homeless, unsheltered_homeless)
  family <- summary %>% select(homeless_indiv, homeless_fam)
  
  shelter_map <- leaflet(data = summary, width = "100%", height = "400px") %>%
    addTiles() %>%
    setView(lng = -95.7129, lat = 37.0902, zoom = 2) %>% 
    addMinicharts(
      summary$longitude, summary$latitude,
      chartdata = shelter,
      colorPalette = colors,
      legend = FALSE,
      type = "pie"
    ) %>% 
    addLegend(
      "topright",
      colors = colors,
      opacity = .8,
      labels = c("Sheltered Homeless", "Unsheltered Homeless")
    )
  
  family_map <- leaflet(data = summary, width = "100%", height = "400px") %>%
    addTiles() %>%
    setView(lng = -95.7129, lat = 37.0902, zoom = 2) %>% 
    addMinicharts(
      summary$longitude, summary$latitude,
      chartdata = family,
      colorPalette = colors,
      legend = FALSE,
      type = "pie"
    ) %>% 
    addLegend(
      "topright",
      colors = colors,
      opacity = .8,
      labels = c("Homeless Individuals", "Homeless Families")
    )
  
  if(choice == "Shelter"){
    return(shelter_map)   
  } else if (choice == "Family"){
    return(family_map)
  }
  
}

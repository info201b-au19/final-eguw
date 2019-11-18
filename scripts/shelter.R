# Eric: Chart 1 (pie chart)
# Proportions of the homeless population that secure shelter
library(dplyr)
library(tidyr)
library(leaflet)
library(leaflet.minicharts)

states <- read.csv("../data/homelessness/states.csv", stringsAsFactors = FALSE)

state_populations <- read.csv("../data/homelessness/Population-by-state.csv", stringsAsFactors = FALSE) %>%
  select(GEO.display.label, respop72016) %>% 
  rename(name = GEO.display.label, population = respop72016) %>%
  slice(-1) %>% 
  mutate(population = as.integer(population))

homelessness <- read.csv("../data/homelessness/2007-2016-Homelessnewss-USA.csv", stringsAsFactors = FALSE)

homelessness2016 <- filter(homelessness, Year == "1/1/2016", Measures == "Total Homeless") %>% 
                    mutate(Count = as.integer(gsub(",", "", Count))) %>% 
                    group_by(State) %>% 
                    summarize(
                      totalHomeless = sum(Count)
                    ) %>%
                    rename(state = State)

state_stats <- left_join(states, state_populations)

summary <- left_join(homelessness2016, state_stats) %>% 
            filter(state != "GU", state != "VI")

basemap <- leaflet(data = summary, width = "100%", height = "400px") %>%
  addTiles() %>%
  setView(lng = -95.7129, lat = 37.0902, zoom = 2) %>% 
  addMinicharts(
    summary$longitude, summary$latitude,
    type = "pie",
    chartdata = select(summary, totalHomeless, population)
  )


basemap
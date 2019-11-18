# Eric: Chart 1 (pie chart)
# Proportions of the homeless population that secure shelter
library(dplyr)
library(tidyr)

shelterAnalysis <- function(states, state_populations, homelessness) {
  
  state_populations <- state_populations %>%
    select(GEO.display.label, respop72016) %>% 
    rename(name = GEO.display.label, population = respop72016) %>%
    slice(-1) %>% 
    mutate(population = as.integer(population))
  
  homelessness2016 <- filter(homelessness, Year == "1/1/2016") %>% 
    mutate(Count = as.integer(gsub(",", "", Count))) %>% 
    spread(Measures,
           Count) %>% 
    select(State, "Sheltered Homeless", "Unsheltered Homeless", "Total Homeless") %>% 
    rename(sheleteredHomeless = "Sheltered Homeless",
           unshelteredHomeless = "Unsheltered Homeless",
           totalHomeless = "Total Homeless",
           state = State) %>%
    group_by(state) %>% 
    summarize(
      shelteredHomeless = sum(sheleteredHomeless),
      unshelteredHomeless = sum(unshelteredHomeless),
      totalHomeless = sum(totalHomeless)
    ) %>% 
    mutate(sheltered = shelteredHomeless / totalHomeless)
  
  state_stats <- left_join(states, state_populations)
  
  summary <- left_join(homelessness2016, state_stats) %>% 
    filter(state != "GU", state != "VI")
  
  return(summary)
}

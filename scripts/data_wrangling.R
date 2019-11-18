homelessPopulationAnalysis <- function(states, state_populations, homelessness) {
  
  state_populations <- state_populations %>%
    select(GEO.display.label, respop72016) %>% 
    rename(name = GEO.display.label, population = respop72016) %>%
    slice(-1) %>% 
    mutate(population = as.integer(population))
  
  homelessness2016 <- filter(homelessness, Year == "1/1/2016") %>% 
    mutate(Count = as.integer(gsub(",", "", Count))) %>% 
    spread(Measures,
           Count) %>% 
    select(State,
           "Sheltered Homeless",
           "Unsheltered Homeless",
           "Total Homeless",
           "Homeless Unaccompanied Children (Under 18)",
           "Homeless Veterans",
           "Homeless Individuals", 
           "Homeless People in Families") %>% 
    rename(sheleteredHomeless = "Sheltered Homeless",
           unshelteredHomeless = "Unsheltered Homeless",
           totalHomeless = "Total Homeless",
           homelessU18 = "Homeless Unaccompanied Children (Under 18)",
           homelessVets = "Homeless Veterans",
           homelessIndiv = "Homeless Individuals",
           homelessWFam = "Homeless People in Families",
           state = State) %>%
    group_by(state) %>% 
    summarize(
      shelteredHomeless = sum(sheleteredHomeless),
      unshelteredHomeless = sum(unshelteredHomeless),
      totalHomeless = sum(totalHomeless),
      homelessU18 = sum(homelessU18),
      homelessVets = sum(homelessVets),
      homelessIndiv = sum(homelessIndiv),
      homelessWFam = sum(homelessWFam)
    ) %>% 
    mutate(sheltered = shelteredHomeless / totalHomeless)
  
  state_stats <- left_join(states, state_populations)
  
  summary <- left_join(homelessness2016, state_stats) %>% 
    filter(state != "GU", state != "VI")
  
  return(summary)
}
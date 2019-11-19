population_analysis <- function(states, state_populations, homelessness) {

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
    rename(sheletered_homeless = "Sheltered Homeless",
           unsheltered_homeless = "Unsheltered Homeless",
           total_homeless = "Total Homeless",
           homeless_u18 = "Homeless Unaccompanied Children (Under 18)",
           homeless_vets = "Homeless Veterans",
           homeless_indiv = "Homeless Individuals",
           homeless_fam = "Homeless People in Families",
           state = State) %>%
    group_by(state) %>%
    summarize(
      sheltered_homeless = sum(sheletered_homeless),
      unsheltered_homeless = sum(unsheltered_homeless),
      total_homeless = sum(total_homeless),
      homeless_u18 = sum(homeless_u18),
      homeless_vets = sum(homeless_vets),
      homeless_indiv = sum(homeless_indiv),
      homeless_fam = sum(homeless_fam)
    ) %>%
    mutate(sheltered = sheltered_homeless / total_homeless)

  state_stats <- left_join(states, state_populations)

  summary <- left_join(homelessness2016, state_stats) %>%
    filter(state != "GU", state != "VI")

  return(summary)
}
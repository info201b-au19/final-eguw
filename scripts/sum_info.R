# Summary file for summary info


# function takes in a dataset and returns a list of info about it
get_summary_info <- function(dataset) {

  sum_data <- list()

# state with least homeless people
  sum_data$state_least_homeless <- dataset %>%
    filter(total_homeless == min(total_homeless)) %>%
    pull(name)

# state with most homeless people
  sum_data$state_most_homeless <- dataset %>%
    filter(total_homeless == max(total_homeless)) %>%
    pull(name)

# Average number of homeless per State
  sum_data$avg_homeless <- as.integer(mean(dataset$total_homeless))

# Total number of homeless
  sum_data$total_homeless <- sum(dataset$total_homeless)

# Number of homeless veterans in 2016
  sum_data$homeless_vets <- sum(dataset$homeless_vets)

# Number of homeless with family
  sum_data$homeless_family <- sum(dataset$homeless_fam)

# Number of homeless under 18 years old
  sum_data$homeless_u18 <- sum(dataset$homeless_u18)

  return(sum_data)

}

# Summary file for summary info 


# function takes in a dataset and returns a list of info about it 
get_summary_info <- function(dataset){
  
  sum_data <- list()
  
# state with least homeless people
  sum_data$state_least_homeless <- dataset %>% 
    filter(totalHomeless == min(totalHomeless)) %>% 
    pull(name)
    
# state with most homeless people  
  sum_data$state_most_homeless <- dataset %>% 
    filter(totalHomeless == max(totalHomeless)) %>% 
    pull(name)
  
# Average number of homeless per State
  sum_data$avg_homeless <- as.integer(mean(dataset$totalHomeless))
    
# Total number of homeless  
  sum_data$total_homeless <- sum(dataset$totalHomeless)
    
# Number of homeless veterans in 2016
  sum_data$homeless_vets <- sum(dataset$homelessVets)
  
# Number of homeless with family
  sum_data$homeless_family <- sum(dataset$homelessWFam)
    
# Number of homeless under 18 years old  
  sum_data$homeless_u18 <- sum(dataset$homelessU18)
  
  return(sum_data)
  
}





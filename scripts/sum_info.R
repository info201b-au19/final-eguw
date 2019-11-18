# Summary file for summary info 


# function takes in a dataset and returns a list of info about it 
get_summary_info <- function(dataset){
  
  sum_data <- list()
  
# year with most homeless people  
  sum_data$year_most_homeless <- dataset %>%
    mutate(year_num = year(as.Date(dataset$Year, format="%d/%m/%Y")),
           Count = as.numeric(as.factor(Count))) %>%
    group_by(year_num) %>%
    summarize(Count = sum(Count)) %>% 
    filter(Count == max(Count)) %>%
    pull(year_num)
  
# Which state had the most homeless people in 2016?
  sum_data$latest_state_most_hl <- dataset %>%
    mutate(year_num = year(as.Date(dataset$Year, format="%d/%m/%Y")),
           Count = as.numeric(as.factor(Count))) %>%
    filter(year_num == 2016, Measures != "Total Homeless") %>%
    group_by(State) %>%
    summarize(Count = sum(Count)) %>% 
    filter(Count == max(Count)) %>% 
    pull(State)
  
# Which state had the least homeless people in 2016?
  sum_data$latest_state_most_hl <- dataset %>%
    mutate(year_num = year(as.Date(dataset$Year, format="%d/%m/%Y")),
           Count = as.numeric(as.factor(Count))) %>%
    filter(year_num == 2016, Measures != "Total Homeless") %>%
    group_by(State) %>%
    summarize(Count = sum(Count)) %>% 
    filter(Count == min(Count)) %>% 
    pull(State)
  
# Average number of unsheltered homeless people (2007-2016)
  sum_data$avg_unshel_hl <- dataset %>%
    mutate(Count = as.numeric(as.factor(Count))) %>%
    filter(Measures == "Unsheltered Homeless") %>%
    summarize(Count = mean(Count)) %>% 
    pull(Count)
  
# Number of homeless veterans in 2016
  sum_data$homeless_vets <- dataset %>%
  mutate(year_num = year(as.Date(homelessness$Year, format="%d/%m/%Y")), 
         Count = as.numeric(as.factor(Count))) %>%
  filter(year_num == 2016, Measures == "Homeless Veterans") %>%
  summarize(Count = sum(Count)) %>%
  pull(Count)
  
# Which measure had the largest count in 2016?
  sum_data$sub_measure <- dataset %>%
    mutate(year_num = year(as.Date(dataset$Year, format="%d/%m/%Y")), 
           Count = as.numeric(as.factor(Count))) %>%
    filter(Measures != "Total Homeless", Measures != "Chronically Homeless", year_num == 2016) %>%
    group_by(Measures)%>%
    summarize(Count = sum(Count))%>%
    filter(Count == max(Count)) %>%
    pull(Measures)
  
  return(sum_data)
  
}





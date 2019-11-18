# Gabby: Chart 3 (scatterplot)
# Homelessness vs crime rate
library(dplyr)
library(plotly)

# Function to make the chart data_one = homelessness // data_two = crime
get_scatterplot <- function(data_one, data_two){
  
  twenty_sixteen_homepop <- data_one %>%
    mutate(year_num = (as.Date(data_one$Year, format="%d/%m/%Y")),
           Count = as.numeric(as.factor(Count))) %>%
    filter(year_num == "2016-01-01", Measures == "Total Homeless") %>% 
    group_by(State) %>%
    summarize(state_hl = sum(Count)) %>%
    filter(State != "GU", State != "PR", State != "VI") %>%
    mutate(homeless_per_100000 = (state_hl)/100000)
  
  crime_by_state <- data_two %>%
    mutate(state = substr(data_two$county_name,
                          nchar(data_two$county_name)-2,
                          nchar(data_two$county_name))) %>%
    group_by(state) %>%
    select(state, crime_rate_per_100000) %>%
    summarize(crime_rate_per_100000 = mean(crime_rate_per_100000))
  
  crime_hl_by_state<- data.frame(twenty_sixteen_homepop$State, 
                                 twenty_sixteen_homepop$homeless_per_100000,
                                 crime_by_state$crime_rate_per_100000)
  homeless_v_crime <- plot_ly(
    data = crime_hl_by_state,
    x = ~twenty_sixteen_homepop.homeless_per_100000, 
    y = ~crime_by_state.crime_rate_per_100000, 
    type = "scatter",
    alpha = .7,
    hovertext = crime_hl_by_state$twenty_sixteen_homepop.State,
    mode = "markers"
  ) %>%
    layout(
      title = "Homelessness vs Crime",
      yaxis= list(title = "State Crime Rates Per 100000"),
      xaxis= list(title = "State Homelessness Rates Per 100000")
    )
  
 
  return(homeless_v_crime)
}
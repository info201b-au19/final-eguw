# Gabby: Chart 3 (scatterplot)
# Homelessness vs crime rate
library(dplyr)
library(ggplot2)
library(plotly)
# download chart
crime <- read.csv("../data/united-states-crime-rates-by-county/crime_data_w_population_and_crime_rate.csv",
                  stringsAsFactors = FALSE)
homelessness <- read.csv("../data/homelessness/2007-2016-Homelessnewss-USA.csv",
                         stringsAsFactors = FALSE)

twenty_sixteen_hl <- homelessness %>%
  mutate(year_num = (as.Date(homelessness$Year, format="%d/%m/%Y")),
         Count = as.numeric(as.factor(Count))) %>%
  filter(year_num == "2016-01-01", Measures == "Total Homeless") %>% 
  group_by(State) %>%
  summarize(state_hl = sum(Count)) %>%
  filter(State != "GU", State != "PR", State != "VI") %>%
  mutate(homeless_per_100000 = (state_hl)/100000)

crime_by_state <- crime %>%
  mutate(state = substr(crime$county_name,
                        nchar(crime$county_name)-2,
                        nchar(crime$county_name))) %>%
  group_by(state) %>%
  select(state, crime_rate_per_100000) %>%
  summarize(crime_rate_per_100000 = mean(crime_rate_per_100000))

# making a dataframe combining the data

crime_hl_by_state<- data.frame(twenty_sixteen_hl$State, 
                               twenty_sixteen_hl$homeless_per_100000,
                               crime_by_state$crime_rate_per_100000)
# Visualization
plot_ly(
  data = crime_hl_by_state, 
  x = ~twenty_sixteen_hl.homeless_per_100000, 
  y = ~crime_by_state.crime_rate_per_100000, 
  type = "scatter", 
  alpha = .7,
  hovertext = crime_hl_by_state$twenty_sixteen_hl.State
) %>%
  
  layout(
    title = "Homelessness vs Crime",
    yaxis= list(title = "State Crime Rates Per 100000"),
    xaxis= list(title = "State Homelessness Rates Per 100000")
  )

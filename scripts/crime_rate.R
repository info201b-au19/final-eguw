# Gabby: Chart 3 (scatterplot)
# Homelessness vs crime rate
library(dplyr)
library(plotly)

# Function to make the chart  = homelessness // crime = crime
crime <- read.csv("../data/united-states-crime-rates-by-county/crime_data_w_population_and_crime_rate.csv",
                    stringsAsFactors = FALSE)
home <-  read.csv("../data/homelessness/2007-2016-Homelessnewss-USA.csv",
                                 stringsAsFactors = FALSE)
twenty_sixteen_homepop <- home %>%
  mutate(
    year_num = (as.Date(home$Year, format = "%d/%m/%Y")),
    Count = as.numeric(as.factor(Count))
  ) %>%
  filter(year_num == "2016-01-01", Measures == "Total Homeless") %>%
  group_by(State) %>%
  summarize(state_hl = sum(Count)) %>%
  filter(State != "GU", State != "PR", State != "VI") %>%
  mutate(homeless_per_100000 = (state_hl) / 100000)

crime_by_state <- crime %>%
  mutate(state = substr(
    crime$county_name,
    nchar(crime$county_name) - 2,
    nchar(crime$county_name)
  )) %>%
  group_by(state) %>%
  select(state, crime_rate_per_100000, MURDER, RAPE,
         ROBBERY, AGASSLT, BURGLRY, LARCENY, MVTHEFT,
         ARSON) %>%
  summarize(crime_rate_per_100000 = mean(crime_rate_per_100000), 
            murder_rate = mean(MURDER) / 100, 
            rape_rate = mean(RAPE) / 100,
            rob_rate = mean(ROBBERY) / 100, 
            assault_rate = mean(AGASSLT) / 100,
            burg_rate = mean(BURGLRY) / 100, 
            larceny_rate = mean(LARCENY) / 100, 
            mvtheft_rate = mean(MVTHEFT) / 100
            )
#joint the data sets together
crime_hl_by_state <- data.frame(
  state = twenty_sixteen_homepop$State,
  homeless_rate = twenty_sixteen_homepop$homeless_per_100000,
  crime_rate = crime_by_state$crime_rate_per_100000, 
  murder_rate = crime_by_state$murder_rate, 
  robbery_rate = crime_by_state$rob_rate, 
  rape_rate = crime_by_state$rape_rate, 
  assault_rate = crime_by_state$assault_rate, 
  burglary_rate = crime_by_state$burg_rate, 
  larceny_rate = crime_by_state$larceny_rate,
  mvtheft_rate = crime_by_state$mvtheft_rate
)

scat <- function(data, crimes){
  homeless_v_crime <- plot_ly(
    data = crimes,
    x = ~homeless_rate,
    y = ~crimes,
    type = "scatter",
    alpha = .7,
    hovertext = data$state,
    mode = "markers"
  ) %>%
    layout(
      title = "Homelessness vs Crime",
      yaxis = list(title = "State Crime Rates Per 100000"),
      xaxis = list(title = "State Homelessness Rates Per 100000")
    )
  return(homeless_v_crime)
  
}
murder <- scat(crime_hl_by_state, murder_rate)

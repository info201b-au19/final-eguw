# Gabby: Chart 3 (scatterplot)
# Homelessness vs crime rate
library(dplyr)
library(plotly)

# function that will return the scatterplot that the user selects
# from the selection bar

getscatplot <- function(data_one, data_two, choice_num) {
  twenty_sixteen_homepop <- data_one %>%
    mutate(
      year_num = (as.Date(data_one$Year, format = "%d/%m/%Y")),
      Count = as.numeric(as.factor(Count))
    ) %>%
    filter(year_num == "2016-01-01", Measures == "Total Homeless") %>%
    group_by(State) %>%
    summarize(state_hl = sum(Count)) %>%
    filter(State != "GU", State != "PR", State != "VI") %>%
    mutate(homeless_per_100000 = (state_hl) / 100000)
  
  crime_by_state <- data_two %>%
    mutate(state = substr(
      data_two$county_name,
      nchar(data_two$county_name) - 2,
      nchar(data_two$county_name)
    )) %>%
    group_by(state) %>%
    select(
      state, crime_rate_per_100000, MURDER, RAPE,
      ROBBERY, AGASSLT, BURGLRY, LARCENY, MVTHEFT,
      ARSON
    ) %>%
    summarize(
      crime_rate_per_100000 = mean(crime_rate_per_100000),
      murder_rate = mean(MURDER) / 100,
      rape_rate = mean(RAPE) / 100,
      rob_rate = mean(ROBBERY) / 100,
      assault_rate = mean(AGASSLT) / 100,
      burg_rate = mean(BURGLRY) / 100,
      larceny_rate = mean(LARCENY) / 100,
      mvtheft_rate = mean(MVTHEFT) / 100
    )
  # joint the data sets together
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

  type_crime <- colnames(crime_hl_by_state[choice_num])
  
  scatplot <- plot_ly(
    data = crime_hl_by_state,
    x = ~homeless_rate,
    y = ~type_crime,
    type = "scatter",
    alpha = .7,
    hovertext = crime_by_state$state,
    mode = "markers"
  ) %>%
    layout(
      title = paste(
        colnames(crime_hl_by_state[2]),
        "vs", colnames(crime_hl_by_state[choice_num])
      ),
      yaxis = list(title = colnames(crime_hl_by_state[choice_num])),
      xaxis = list(title = colnames(crime_hl_by_state[2]))
    )

  return(scatplot)
}


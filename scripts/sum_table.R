# file for summary table

get_sum_table <- function(df_temp, df_temp2, df_temp3) {
  df_city_cost <- df_temp %>%
    filter(nchar(Country) == 2) %>%
    select(City, Country, Cost.of.Living.Plus.Rent.Index) %>%
    arrange(Country)
  
  df_city_pop <- df_temp2 %>%
    filter(grepl("2016", Year) & Measures == "Total Homeless") %>%
    select(State, CoC.Name, Count)
  
  df_city_pop$CoC.Name <- gsub("/", " ", df_city_pop$CoC.Name)
  
  df_city_pop$City <- word(df_city_pop$CoC.Name, 1)
  a <- left_join(df_city_cost, df_city_pop, by = "City")
  
  df_city_pop$City <- word(df_city_pop$CoC.Name, 1, 2)
  b <- left_join(df_city_cost, df_city_pop, by = "City")
  
  df_combined <- rbind(a, b, by = "City") %>%
    na.omit() %>%
    filter(Country == State) %>%
    slice(-94) %>%
    select(City, State, Cost.of.Living.Plus.Rent.Index, Count) %>%
    rename(CPI = Cost.of.Living.Plus.Rent.Index) %>%
    mutate(Count = gsub(",", "", Count)) %>%
    mutate(Count = as.numeric(Count)) %>%
    mutate(CPI = as.numeric(CPI)) %>%
    group_by(State) %>%
    mutate(avg.cpi = mean(CPI)) %>%
    mutate(total_hl = sum(Count))

  df_temp3$GEO.display.label <- state.abb[match(df_temp3$GEO.display.label, state.name)]
  df_temp3$respop72016 <- as.numeric(df_temp3$respop72016) 

  sum_table <- df_combined %>%
    left_join(df_temp3, by = c("State" = "GEO.display.label")) %>%
    mutate(percentage = 100*total_hl/respop72016) %>%
    select(State, avg.cpi, total_hl, respop72016, percentage) %>%
    distinct() %>%
    arrange(desc(percentage)) %>%
    head(n = 10)
  
  sum_table <- kable(sum_table, digits = 2, align = "l",
                     col.names = c("State", "Avg.CPI", "Homeless Population",
                                   "Total Population", "Percentage(%)"),
                     caption = "Summary Table")
  return(sum_table)
}

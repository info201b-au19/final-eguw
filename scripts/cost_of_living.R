# Vincent: Chart 2 (bar chart)
# Comparison of cost of living vs homeless population

get_charts <- function(df_temp, df_temp2) {
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
    mutate(CPI2 = CPI*50)
  
  # Just a preview, since im doing bar chart rather than scatter plot
  scatter_plot <- ggplot() +
    geom_point(df_combined, mapping = aes(CPI, Count)) +
    xlim(40, 90) +
    ylim(0, 12000) +
    ggtitle("2016 Homeless Population vs. CPI (Rent included)")
  
  representative <- df_combined %>%
    filter(City == "Seattle" | City == "San Diego" | City == "Philadelphia" |
      City == "Atlanta" | City == "Detroit" | City == "Tucson" |
      City == "Springfield" | City == "San Jose" |
      City == "San Francisco" | City == "San Antonio") %>%
      arrange(CPI) %>%
      mutate(total_pop_millions = as.numeric(c("0.17", "0.54", "1.5", "0.67",
                                               "0.49", "1.58", "1.42", "0.74",
                                               "1.04", "0.88"))) %>%
      mutate(rate = Count/total_pop_millions)

  # To put cities in ascending order of cpi
  representative$City <- factor(representative$City, representative$City[1:10])
  long_rep <- gather(representative, event, total, CPI2, rate)
  
  bar_chart <- ggplot(long_rep, aes(x = City)) +
    geom_bar(aes(y = total, color = event, fill = event),
             stat = "identity", position = position_dodge(width = 0.8),
             width = 0.8, color = "white") +
    scale_y_continuous(sec.axis = sec_axis(~./50, name = "CPI (Rent included)")) +
    scale_fill_manual(
      values = c("aquamarine4", "indianred2"),
      labels = c("CPI", "Homeless")
    ) +
    labs(y = "# of Homeless (in 1 Million)", x = NULL, fill = NULL) +
    ggtitle("2016 CPI / Homeless Rate (in 10 representative cities)") +
    theme(axis.text.x = element_text(angle = 35))
  
  p <- ggarrange(scatter_plot, bar_chart, widths = c(2,3),
            ncol = 2, nrow = 1)
  
  return(p)
}

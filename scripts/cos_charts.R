get_chart <- function(df1, df2, control, ctype) {
  df_city_cost <- df1 %>%
    filter(nchar(Country) == 2) %>%
    select(City, Country, control) %>%
    arrange(Country)

  df_city_pop <- df2 %>%
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
    slice(-nrow(.)) %>%
    select(City, State, control, Count) %>%
    mutate(Count = gsub(",", "", Count)) %>%
    mutate(Count = as.numeric(Count))

  df_combined[[control]] <- as.numeric(df_combined[[control]])

  scatter_plot <- ggplot(df_combined, aes(df_combined[[control]], Count)) +
    geom_point(color = "red", alpha = 0.7) +
    ylim(0, 12000) +
    xlab(control) +
    ylab("Homeless Count") +
    ggtitle(paste0("2016 Homeless Population vs. ", control)) +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "transparent", colour = NA),
      plot.background = element_rect(fill = "transparent", colour = NA)
    )

  if (control == "Cost.of.Living.Plus.Rent.Index") {
    scatter_plot <- scatter_plot + xlim(40, 90)
  } else if (control == "Rent.Index") {
    scatter_plot <- scatter_plot + xlim(25, 87)
  } else if (control == "Cost.of.Living.Index") {
    scatter_plot <- scatter_plot + xlim(55, 100)
  } else if (control == "Groceries.Index") {
    scatter_plot <- scatter_plot + xlim(50, 100)
  }
  
  reg <- ggscatter(df_combined, control, "Count",
                  add = "reg.line",  # Add regressin line
                  add.params = list(color = "red", fill = "lightgray"), # Customize reg. line
                  conf.int = TRUE # Add confidence interval
    ) + 
    xlim(40, 90) +
    ylim(0, 12000) +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "transparent", colour = NA),
      plot.background = element_rect(fill = "transparent", colour = NA)
    )
    
  # Add correlation coefficient
  reg <- reg + stat_cor(method = "pearson", label.x = 65, label.y = 7500)

  df_combined$CPI2 <- df_combined[[control]] * 50

  representative <- df_combined %>%
    filter(City == "Seattle" | City == "San Diego" | City == "Philadelphia" |
      City == "Atlanta" | City == "Detroit" | City == "Tucson" |
      City == "Springfield" | City == "San Jose" |
      City == "San Francisco" | City == "San Antonio") %>%
    arrange(Count) %>%
    mutate(total_pop_millions = as.numeric(c(
      "0.17", "0.54", "0.67", "1.5",
      "0.49", "1.58", "1.04", "0.88",
      "1.42", "0.72"
    ))) %>%
    mutate(rate = Count / total_pop_millions) %>%
    arrange(CPI2)

  # To put cities in ascending order of cpi
  representative$City <- factor(representative$City, representative$City[1:10])
  long_rep <- gather(representative, event, total, CPI2, rate)

  bar_chart <- ggplot(long_rep, aes(x = City)) +
    geom_bar(aes(y = total, color = event, fill = event),
      stat = "identity", position = position_dodge(width = 0.8),
      width = 0.8, color = "white"
    ) +
    scale_y_continuous(sec.axis = sec_axis(~ . / 50,
      name = control
    )) +
    scale_fill_manual(
      values = c("aquamarine4", "indianred2"),
      labels = c(control, "Homeless")
    ) +
    labs(y = "# of Homeless (in 1 Million)", x = NULL, fill = NULL) +
    ggtitle(paste0(control, " / Homeless Rate (in 10 representative cities)")) +
    theme(
      axis.text.x = element_text(angle = 35, size = 12, face = "bold"),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "transparent", colour = NA),
      plot.background = element_rect(fill = "transparent", colour = NA)
    )

  if (ctype == 1) {
    return(scatter_plot)
  } else if (ctype == 2) {
    return(bar_chart)
  } else if (ctype == 3) {
    return(reg)
  }
}

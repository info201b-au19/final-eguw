# Vincent: Chart 2 (bar chart)
# Comparison of cost of living vs homeless population

library(dplyr)
library(stringr)
library(tidyr)
library(tidyverse)
library(ggplot2)

df_temp <- read.csv("../data/cost-of-living/cost-of-living-2016.csv",
  stringsAsFactors = FALSE
)
df_city_cost <- df_temp %>%
  filter(nchar(Country) == 2) %>%
  select(City, Country, Cost.of.Living.Plus.Rent.Index) %>%
  arrange(Country)

# Summary information of cost of living(plus rent) by city.
# Gabby, you can call this function in your sum_info, it provides
# top 10 citis and max, min, mean.

summary_cpi_by_city <- function() {
  top10_cities <- df_city_cost %>%
    arrange(desc(Cost.of.Living.Plus.Rent.Index)) %>%
    head(n = 10) %>%
    mutate(top_10 = paste0(City, " (", Cost.of.Living.Plus.Rent.Index, ")")) %>%
    pull(top_10)

  mean <- mean(df_city_cost$Cost.of.Living.Plus.Rent.Index)
  highest <- max(df_city_cost$Cost.of.Living.Plus.Rent.Index)
  lowest <- min(df_city_cost$Cost.of.Living.Plus.Rent.Index)
  list(
    "top 10 cities:" = top10_cities,
    "mean cpi:" = mean,
    "higest cpi:" = highest,
    "lowest cpi:" = lowest
  )
}

df_temp2 <- read.csv("../data/homelessness/2007-2016-Homelessnewss-USA.csv",
  stringsAsFactors = FALSE
)
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
  mutate(CPI2 = CPI * 50)

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
  arrange(CPI2)

# To put cities in ascending order of cpi
representative$City <- factor(representative$City, representative$City[1:10])
# LA is an outlier

long_rep <- gather(representative, event, total, CPI2:Count)

# Bar chart to be called
bar_chart <- ggplot(long_rep, aes(x = City)) +
  geom_bar(aes(y = total, color = event, fill = event),
    stat = "identity", position = position_dodge(width = 0.8),
    width = 0.8, color = "white"
  ) +
  scale_y_continuous(sec.axis = sec_axis(~ . / 50,
                                         name = "CPI (Rent included)")) +
  scale_fill_manual(
    values = c("indianred2", "aquamarine4"),
    labels = c("Homeless", "CPI")
  ) +
  labs(y = "Homeless Population", x = NULL, fill = NULL) +
  ggtitle("2016 CPI / Homeless Population (in 10 representative cities)") +
  theme(axis.text.x = element_text(angle = 40))

# file for summary table

source("../scripts/cost_of_living.r")
library(dplyr)

pop_by_state <- df_combined %>%
  group_by(State) %>%
  mutate(avg.cpi = mean(CPI)) %>%
  mutate(total_hl = sum(Count))

df_temp <- read.csv("../data/homelessness/Population-by-state.csv", stringsAsFactors = FALSE)
df_temp$GEO.display.label <- state.abb[match(df_temp$GEO.display.label, state.name)]
df_temp$respop72016 <- as.numeric(df_temp$respop72016) 

sum_table <- pop_by_state %>%
  left_join(df_temp, by = c("State" = "GEO.display.label")) %>%
  mutate(percentage = 100*total_hl/respop72016) %>%
  select(State, avg.cpi, total_hl, respop72016, percentage) %>%
  distinct() %>%
  arrange(desc(percentage))
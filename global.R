library(tidyverse)

shootings <- read_csv("data/database.csv")

shootings <- shootings %>% 
  mutate(armed = if_else(!(armed %in% c('gun', 'knife')), "Other", armed))

shootings <- shootings %>% 
  mutate(race = if_else(!(race %in% c('B', 'W', 'H')), "Other", race))

shootings <- shootings %>% 
  filter(!is.na(gender), !is.na(flee))


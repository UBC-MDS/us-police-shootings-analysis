# importing required libraries
library(tidyverse)
library(lubridate)

# reading the data
shootings <- read_csv("data/database.csv")

# grouping low frequency cases in the relevant variables
shootings <- shootings %>% 
    mutate(armed = if_else(!(armed %in% c('gun', 'knife')), "Other", armed))

shootings <- shootings %>% 
    mutate(race = if_else(!(race %in% c('B', 'W', 'H')), "Other", race))

shootings <- shootings %>% 
    filter(!is.na(gender), !is.na(flee))

# obtaining year and month from date to group by
shootings <- shootings %>%
    mutate(ym = format(as.POSIXct(date), "%Y-%m"))

# creating a map of states and number returned on interactive click
map <- shootings %>% 
    select(state) %>% 
    unique() %>% 
    arrange(state) %>% 
    mutate(index = 1:n())

# creating dataset for on-click line plot
country_gp <- shootings %>%
    group_by(state, ym) %>%
    mutate(count = n()) %>% 
    select(state, ym, count)

bar_dat <- shootings %>% 
    group_by(race) %>% 
    mutate(cases = n()) %>% 
    select(race, cases)
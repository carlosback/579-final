library(tidyverse)
library(ggplot2)
library(maps)
by_age = read.table("579-final/dataset/BYAGE.txt", 
               sep="|", 
               header = TRUE, 
               fill=FALSE, 
               strip.white=TRUE)
by_area = read.table("579-final/dataset/BYAREA.txt", 
                    sep="|", 
                    header = TRUE, 
                    fill=FALSE, 
                    strip.white=TRUE)

states <- map_data("state")
by_area$region <- tolower(by_area$AREA)
byarea_map <- by_area %>% 
  filter(SITE=="Female Breast") %>% 
  left_join(states, by="region")

byarea_map %>% 
  filter(EVENT_TYPE=="Incidence") %>% 
  mutate(rate = COUNT/POPULATION*100000) %>%
  ggplot(aes(x = long, y = lat, fill = rate, group = group)) +
  geom_polygon() 

library(dplyr)

meandata <-data%>%
group_by(variable)%>%
  select_if(is.numeric) %>%
  summarise_all(list(mean = ~mean(.), sd = ~sd(.), se = ~sd(./sqrt(.))))




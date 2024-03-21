library(dplyr)

calculate_summary_stats <- function(data) {
  summary_stats <- data %>%
    group_by() %>%
    select_if(is.numeric) %>%
    summarise_all(list(mean = ~mean(.), sd = ~sd(.), se = ~sd(./sqrt(.))))
  
  return(summary_stats)
}


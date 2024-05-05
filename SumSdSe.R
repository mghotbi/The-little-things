library(dplyr)

calculate_summary_stats <- function(data, grouping_var) {
  summary_stats <- data %>%
    group_by({{ grouping_var }}) %>%
    select_if(is.numeric) %>%
    summarise_all(list(mean = ~mean(.), sd = ~sd(.), se = ~sd(./sqrt(.))))
  
  return(summary_stats)
}

#Example
#summary_stats <- calculate_summary_stats(data, factor)


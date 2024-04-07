calculate_detailed_summary_stats <- function(data) {
  summary_stats <- data %>%
    group_by() %>%
    select_if(is.numeric) %>%
    summarise_all(list(mean = ~mean(.),
                       sd = ~sd(.),
                       se = ~sd(./sqrt(.)),
                       q25 = ~quantile(., 0.25),
                       median = ~median(.),
                       q75 = ~quantile(., 0.75)))
  
  return(summary_stats)
}


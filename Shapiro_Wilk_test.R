Shapiro_Wilk_test <- function(data, grouping_var) {
  with(data, {
    numeric_vars <- select_if(data, is.numeric)
    for (var_name in names(numeric_vars)) {
      clean_var <- na.omit(numeric_vars[[var_name]])
      # Normality of residuals
      shapiro_test_sqrt <- shapiro.test(resid(aov(clean_var ~ as.factor(get(grouping_var)))))
      print(paste("Shapiro-Wilk test for", var_name, "without transformation: p-value =", shapiro_test_sqrt$p.value))
      shapiro_test_sqrt <- shapiro.test(resid(aov(sqrt(clean_var) ~ as.factor(get(grouping_var)))))
      print(paste("Shapiro-Wilk test for", var_name, "with square root transformation: p-value =", shapiro_test_sqrt$p.value))
      shapiro_test_log <- shapiro.test(resid(aov(log(clean_var) ~ as.factor(get(grouping_var)))))
      print(paste("Shapiro-Wilk test for", var_name, "with log transformation: p-value =", shapiro_test_log$p.value))
      shapiro_test_zscale <- shapiro.test(resid(aov(scale(clean_var) ~ as.factor(get(grouping_var)))))
      print(paste("Shapiro-Wilk test for", var_name, "with Z-scaling: p-value =", shapiro_test_zscale$p.value))
    }  
  })
}

#Shapiro_Wilk_test(numeric_vars_plus_one, "Methods_processing_Spiked_dataset")



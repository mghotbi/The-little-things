# To test homogeneity of variances; Bartlett
Bartlett.test <- function(data, grouping_var, transformations = c("raw", "sqrt", "log", "zscale")) {
  with(data, {
    numeric_vars <- select_if(data, is.numeric)
    for (var_name in names(numeric_vars)) {
      clean_var <- na.omit(numeric_vars[[var_name]])
            for (transformation in transformations) {
        # Apply specified transformation
        if (transformation == "sqrt") {
          transformed_var <- sqrt(clean_var)
        } else if (transformation == "log") {
          transformed_var <- log(clean_var)
        } else if (transformation == "zscale") {
          transformed_var <- scale(clean_var)
        } else {
          transformed_var <- clean_var  # No transformation/raw
        }
                # Bartlett test for homogeneity of variances
        bartlett_result <- bartlett.test(transformed_var ~ as.factor(get(grouping_var)))
        
        print(paste("Bartlett test for", var_name, "with", transformation, "transformation: p-value =", bartlett_result$p.value))
      }    }    })}


# Usage:
#Bartlett.test(numeric_vars_plus_one, "Methods_processing_Spiked_dataset")

# Usage:
#test_homogeneity_variances(percent_spiked_among_methods, "Methods_processing_Spiked_dataset", transformation = "raw")

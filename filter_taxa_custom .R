filter_taxa_custom <- function(physeq, 
                               threshold_percentage = 0.5, 
                               threshold_mean_abundance = 0.001, 
                               threshold_count = 10,
                               threshold_relative_abundance = NULL) {
  
  nsamples <- nsamples(physeq)
  sample_sum <- sample_sums(physeq)
  
  filter_function <- function(x) {
    (sum(x > threshold_count) > nsamples * threshold_percentage) | 
      ((sum(x > threshold_count) > (nsamples * 0.1)) & (mean(x / sample_sum) > threshold_mean_abundance) & (max(x / sample_sum) > threshold_relative_abundance))
  }
  
  two_way_filtered <- filter_taxa(physeq, filter_function, prune = TRUE)
  return(two_way_filtered)
}

# Example with custom thresholds
#filtered_physeq <- filter_taxa_custom(physeq16S_adj_scaled,threshold_percentage = 0.6,threshold_mean_abundance = 0.0005,threshold_count = 5,threshold_relative_abundance = 0.01)

calculate_spike_percentage <- function(physeq) {
  # Calculate total reads for 16S samples
  total_reads_16S <- data.frame(Sample = sample_names(physeq), 
                                Total_Reads = sample_sums(otu_table(physeq)))
  
  # Subset taxa specific to spiked species
  spiked_species <- subset_taxa(physeq, Species == "Tetragenococcus_halophilus" | Species =="Tetragenococcus_sp.")
  
  # Calculate reads specific to spiked species
  spiked_reads <- data.frame(Sample = sample_names(spiked_species),
                             Total_Reads = sample_sums(otu_table(spiked_species)))
  
  # Merge total reads and spiked reads data frames
  merged_data <- merge(total_reads_16S, spiked_reads, by = "Sample", suffixes = c("_total", "_spiked"))
  
  # Calculate the percentage of spiked species reads relative to total reads
  merged_data$Percentage <- (merged_data$Total_Reads_spiked / merged_data$Total_Reads_total) * 100
  
  # Output the percentage
  return(merged_data)
}

calculate_spike_percentage <- function(physeq, spiked_species) {
  # Calculate total reads for 16S samples
  total_reads_16S <- data.frame(Sample = sample_names(physeq), 
                                Total_Reads = sample_sums(otu_table(physeq)))
  
  # Subset taxa specific to spiked species
  spiked_taxa <- subset_taxa(physeq, Species %in% spiked_species)
  
  # Check if there are any samples containing the spiked taxa
  if (ntaxa(spiked_taxa) == 0) {
    stop("No samples contain the spiked species.")
  }
  
  # Merge all ASVs rooted from spiked taxa into one
  merged_spiked <- merge_taxa(spiked_taxa, taxa_names(spiked_taxa))
  
  # Calculate reads specific to merged spiked taxa
  spiked_reads <- data.frame(Sample = sample_names(merged_spiked),
                             Total_Reads = sample_sums(otu_table(merged_spiked)))
  
  # Merge total reads and spiked reads data frames
  merged_data <- merge(total_reads_16S, spiked_reads, by = "Sample", suffixes = c("_total", "_spiked"))
  
  # Calculate the percentage of spiked taxa reads relative to total reads
  merged_data$Percentage <- (merged_data$Total_Reads_spiked / merged_data$Total_Reads_total) * 100
  
  # Output the percentage
  return(merged_data)
}

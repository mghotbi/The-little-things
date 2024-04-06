calculate_spikeIn_factors <- function(physeq, spiked_cells, hashcodes) {
  output_prefix <- "spikeIn_factors"  # Define the fixed output directory
  
  cat("Identifying spiked species...\n")
  
  # Check if the output_prefix directory exists, create it if necessary
  if (!dir.exists(output_prefix)) {
    if (!dir.create(output_prefix)) {
      stop("Failed to create directory:", output_prefix)
    }
  }
  
  # Exclude Tetragenococcus_halophilus and save it
  physeq_no_spiked <- subset_taxa(physeq, Species != "Tetragenococcus_halophilus")
  saveRDS(physeq_no_spiked, file.path(output_prefix, "Physeq_NO_Tetragenococcus_halophilus.rds"))
  cat("Saved file:", file.path(output_prefix, "Physeq_NO_Tetragenococcus_halophilus.rds\n"))
  
  # Calculate total reads
  spiked_16S_total_reads <- data.frame(Sample = rownames(sample_data(physeq)), Total_Reads = sample_sums(otu_table(physeq)))
  write.csv(spiked_16S_total_reads, file.path(output_prefix, "Spiked_16S_Total_Reads.csv"))
  cat("Saved file:", file.path(output_prefix, "Spiked_16S_Total_Reads.csv\n"))
  
  # Subset taxa with specified hashcodes relevant to spiked sp
  spiked_Tetra <- subset_taxa(physeq, row.names(tax_table(physeq)) %in% hashcodes)
  saveRDS(spiked_Tetra, file.path(output_prefix, "Spiked_Tetragenococcus_halophilus_read.rds"))
  
  # Merge Tetragenococcus_halophilus to one
  Tetragenococcus_halophilus_spiked_only <- merge_taxa(spiked_Tetra, taxa_names(spiked_Tetra))
  saveRDS(Tetragenococcus_halophilus_spiked_only, file.path(output_prefix, "Spiked_Tetragenococcus_halophilus_mergedtoOne.rds"))
  cat("Saved file:", file.path(output_prefix, "Spiked_Tetragenococcus_halophilus_mergedtoOne.rds\n"))
  
  # Calculate total reads for Tetragenococcus_halophilus
  spiked_Tetragenococcus_halophilus_reads <- data.frame(Sample = rownames(sample_data(Tetragenococcus_halophilus_spiked_only)), Total_Reads = sample_sums(otu_table(Tetragenococcus_halophilus_spiked_only)))
  write.csv(spiked_Tetragenococcus_halophilus_reads, file.path(output_prefix, "spiked_Tetragenococcus_halophilus_reads.csv"))
  cat("Saved file:", file.path(output_prefix, "spiked_Tetragenococcus_halophilus_reads.csv\n"))
  
  # Check if any negative values are present in the spiked Tetragenococcus_halophilus reads
  if (any(spiked_Tetragenococcus_halophilus_reads$Total_Reads < 0)) {
    cat("Negative values detected in spiked Tetragenococcus_halophilus reads. Converting to zero.\n")
    spiked_Tetragenococcus_halophilus_reads$Total_Reads[spiked_Tetragenococcus_halophilus_reads$Total_Reads < 0] <- 0
  }
  
  # Calculate scaling factor for Tetragenococcus_halophilus
  denominator_spiked_Tetragenococcus_halophilus_reads <- spiked_Tetragenococcus_halophilus_reads$Total_Reads
  metadata <- sample_data(physeq)
  scaling_factor_Tetragenococcus_halophilus <- ifelse(denominator_spiked_Tetragenococcus_halophilus_reads != 0, {
    ifelse(metadata$spiked_volume == 1, {
      spiked_cells / 2 / denominator_spiked_Tetragenococcus_halophilus_reads
    }, ifelse(metadata$spiked_volume == 2, {
      spiked_cells / denominator_spiked_Tetragenococcus_halophilus_reads
    }, 0))
  }, 0)
  
  write.csv(scaling_factor_Tetragenococcus_halophilus, file.path(output_prefix, "scaling_factor_Tetragenococcus_halophilus.csv"), row.names = FALSE)
  cat("Scaling factor for spiked Tetragenococcus_halophilus calculated and saved.\n")
  
  cat("Process complete. Scaling factor for spiked Tetragenococcus_halophilus saved in the output directory.\n")
  
  return(scaling_factor_Tetragenococcus_halophilus)
}

#spikeIn_factors <- calculate_spikeIn_factors(physeq16S_adj_scaled, 1874, hashcodes)

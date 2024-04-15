#designed to generate ridge plots to visualize the distribution of relative abundances of taxa
#this function rarefies data, excludes Specific Taxa relevant to spiked species, then does proportion transformation (%),gloms and prunes and plots; 

ridge_plot_it <- function(physeq, spiked_species = c("Tetragenococcus_halophilus", "Tetragenococcus_sp.")) {
  # Rarefy and tidy phyloseq object
  physeq <- rarefy_even_depth(physeq, rngseed = 500, 
                              sample.size = max(10, 0.9 * min(sample_sums(physeq))), 
                              replace = TRUE)
  physeq <- tidy_phyloseq(physeq)
  
  # Exclude specific spiked taxa
  if (!missing(spiked_species)) {
    physeq <- subset_taxa(physeq, !Species %in% spiked_species)
  }
  
  # Transform sample counts to proportions
  physeq <- transform_sample_counts(physeq, function(x) {x/sum(x) * 100})
  
  # Glom and prune taxa, and filter out taxa with very small abundances
  glom.1 <- tax_glom(physeq, taxrank = "Genus")
  glom.1 <- prune_taxa(taxa_sums(glom.1) > 0, glom.1)  # Filter out taxa with very small abundances
  
  # Convert to data frame
  ps <- psmelt(glom.1)
  
  # Plot
  ps %>%
    group_by(sample_name) %>%
    mutate(Proportion = Abundance) %>%
    filter(Proportion > 0 & !is.na(Phylum)) %>%
    ggplot(aes(y = Phylum, x = log10(Proportion), fill = Phylum)) +
    geom_density_ridges2(scale = 1, alpha = 0.8, show.legend = FALSE) +
    ggtitle("Distribution of Relative Abundances by Phylum") +
    labs(x = "Log10 (Proportion%)", y = NULL) +
    mytheme + scale_fill_manual(values = MG)
}

#Example;
#ridgeP<-ridge_plot_it(spiked_16S)
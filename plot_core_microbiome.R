#core microbiome plotting designed to generate a prevalence heatmap of core microbiome 
#this function have detection threshold for prevalence, it does NOT exclude Specific Taxa relevant to spiked species. It does gloms, prunes and does proportion transformation (%), renames taxa with an ASV prefix.
#Formats for BestHit and plots; so we need phyloseq, microbiome, and ggplot2 packages for

plot_core_microbiome_custom <- function(physeq, taxrank = "Genus", select_taxa = NULL, 
                                        prevalences = seq(0.03, 1, 0.03), 
                                        detections = 10^seq(log10(1e-3), log10(0.3), length = 5)) {
  # Glom taxa at specified taxonomic rank
  glom_phy <- tax_glom(physeq, taxrank = taxrank)
  
  # Prune taxa with no abundance if select_taxa is specified
  if (!is.null(select_taxa)) {
    glom_phy <- prune_taxa(select_taxa, glom_phy)
  }
  
  # Exclude the species level
  glom_phy <- subset_taxa(glom_phy, select = -Species)
  
  # Transform counts to relative abundance
  glom_phy <- transform_sample_counts(glom_phy, function(x) 100 * x / sum(x))
  
  # Rename taxa with ASV prefix
  taxa_names(glom_phy) <- paste0("ASV", seq(ntaxa(glom_phy)))
  
  # Format phyloseq object for besthit
  phy_rel_f <- format_to_besthit(glom_phy)
  
  # Plot core microbiome
  p.core <- plot_core(phy_rel_f, 
                      plot.type = "heatmap", 
                      colours = rev(brewer.pal(5, "Spectral")),
                      prevalences = prevalences, 
                      detections = detections, 
                      min.prevalence = 0.3) + 
    xlab("Detection Threshold (Relative Abundance (%))")
  
  # Customize plot/ as I add italic
  p.core + theme(axis.text.y = element_text(face = "italic"))
}

# Example :
# plot_core_microbiome_custom(physeq, taxrank = "Genus", select_taxa = NULL)

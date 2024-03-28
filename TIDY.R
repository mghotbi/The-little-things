library("phyloseq")
library("grid")

tidy_phyloseq <- function(my_phyloseq) {
  # Set ranks
  colnames(tax_table(my_phyloseq)) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")
  
  # Fix taxa names
  for (col in colnames(tax_table(my_phyloseq))) {
    tax_table(my_phyloseq)[, col] <- gsub("[a-z]__", "", tax_table(my_phyloseq)[, col])
  }
  
  # Replace NA in Phylum position with "Unidentified"
  tax_table(my_phyloseq)[is.na(tax_table(my_phyloseq)[, "Phylum"]), "Phylum"] <- "Unidentified"
  
  # Remove taxa with zero counts
  if (ntaxa(my_phyloseq) > 0) {
    my_phyloseq <- prune_taxa(taxa_sums(my_phyloseq) > 0, my_phyloseq)
    
    # Rename taxa names with ASV numbers
    taxa_names(my_phyloseq) <- paste0("ASV", seq(ntaxa(my_phyloseq)))
    
    # Check for and remove "Chloroplast" entries in Class
    if ("Class" %in% colnames(tax_table(my_phyloseq))) {
      my_phyloseq <- prune_taxa(taxa_names(my_phyloseq)[tax_table(my_phyloseq)[, "Class"] != " Chloroplast"], my_phyloseq)
    }
    
    # Check for and remove "Mitochondria" entries in Family
    if ("Family" %in% colnames(tax_table(my_phyloseq))) {
      my_phyloseq <- prune_taxa(taxa_names(my_phyloseq)[tax_table(my_phyloseq)[, "Family"] != " Mitochondria"], my_phyloseq)
    }
  }
  
  return(my_phyloseq)
}

library("phyloseq")
library("grid")

tidy_phyloseq <- function(my_phyloseq) {
  # Fix taxa names by removing any characters followed by '__' and any spaces after '__'
  for (col in colnames(tax_table(my_phyloseq))) {
    tax_table(my_phyloseq)[, col] <- gsub("[a-z]__\\s*", "", tax_table(my_phyloseq)[, col]) 
  }
  # Set ranks
  colnames(tax_table(my_phyloseq)) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")
  # Fix taxa names
  for (col in colnames(tax_table(my_phyloseq))) {
    # Trim leading and trailing whitespace from taxa names
    tax_table(my_phyloseq)[, col] <- trimws(tax_table(my_phyloseq)[, col])
  }
  # Replace NA in Phylum with "Unidentified"
  tax_table(my_phyloseq)[is.na(tax_table(my_phyloseq)[, "Phylum"]), "Phylum"] <- "Unidentified"
  
  # Remove taxa with zero counts
  if (ntaxa(my_phyloseq) > 0) {
    my_phyloseq <- prune_taxa(taxa_sums(my_phyloseq) > 0, my_phyloseq)
  }
  
  # Remove taxa classified as "Chloroplast" at the Class level
  my_phyloseq <- subset_taxa(my_phyloseq, Class != "Chloroplast")
  
  # Remove taxa classified as "Mitochondria" at the Family level
  my_phyloseq <- subset_taxa(my_phyloseq, Family != "Mitochondria")
  
  return(my_phyloseq)
}

summary_phyloseq <- function(physeq) {
  otu_table <- otu_table(physeq)
  summary_stats <- data.frame(
    ASV_ID = rownames(otu_table),
    Mean = apply(otu_table, 1, mean),
    Median = apply(otu_table, 1, median),
    SD = apply(otu_table, 1, sd),
    SE = apply(otu_table, 1, function(x) sd(x) / sqrt(length(x)))
  )
  return(summary_stats)
}

summary_stats <- summary_phyloseq()

# Check the summary statistics
head(summary_stats)
#summary based on sample_id
summ_phyloseq <- function(physeq) {
  otu_table <- otu_table(physeq)
  summary_stats <- data.frame(
    Sample_ID = colnames(otu_table),
    Mean = apply(otu_table, 2, mean),
    Median = apply(otu_table, 2, median),
    SD = apply(otu_table, 2, sd),
    SE = apply(otu_table, 2, function(x) sd(x) / sqrt(length(x)))
  )
  return(summary_stats)
}

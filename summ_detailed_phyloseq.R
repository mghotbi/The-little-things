summ_detailed_phyloseq <- function(physeq) {
  otu_table <- otu_table(physeq)
  summary_stats <- data.frame(
    Sample_ID = colnames(otu_table),
    Mean = apply(otu_table, 2, mean),
    Median = apply(otu_table, 2, median),
    SD = apply(otu_table, 2, sd),
    SE = apply(otu_table, 2, function(x) sd(x) / sqrt(length(x))),
    Q25 = apply(otu_table, 2, quantile, probs = 0.25),
    Q50 = apply(otu_table, 2, quantile, probs = 0.5),
    Q75 = apply(otu_table, 2, quantile, probs = 0.75)
  )
  return(summary_stats)
}

#summ_detailed_phyloseq(physeq16S_adj_scaled)
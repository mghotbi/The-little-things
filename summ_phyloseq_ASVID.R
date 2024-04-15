#summary based on ASV_ID 
summ_phyloseq_ASVID <- function(physeq) {
  otu_table <- otu_table(physeq)
  summary_stats <- data.frame(
    ASV_ID = rownames(otu_table),
    Mean = apply(otu_table, 1, mean),
    Median = apply(otu_table, 1, median),
    SD = apply(otu_table, 1, sd),
    SE = apply(otu_table, 1, function(x) sd(x) / sqrt(length(x))),
    Q25 = apply(otu_table, 1, quantile, probs = 0.25),
    Q50 = apply(otu_table, 1, quantile, probs = 0.5),
    Q75 = apply(otu_table, 1, quantile, probs = 0.75)
  )
  return(summary_stats)
}


#Example;
#summ_phyloseq_ASVID(spiked_16S)

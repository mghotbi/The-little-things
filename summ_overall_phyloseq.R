summ_overall_phyloseq <- function(physeq) {
  otu_table <- as.data.frame(otu_table(physeq))
  overall_summary <- data.frame(
    Variable = c("Mean", "Median", "SD", "SE", "Q25", "Q50", "Q75"),
    Value = c(
      mean(as.matrix(otu_table)),
      median(as.matrix(otu_table)),
      sd(as.matrix(otu_table)),
      sd(as.matrix(otu_table)) / sqrt(nrow(otu_table)),
      quantile(as.matrix(otu_table), 0.25),
      quantile(as.matrix(otu_table), 0.50),
      quantile(as.matrix(otu_table), 0.75)
    )
  )
  
  return(overall_summary)
}

#summ_overall_phyloseq(physeq16S_adj_scaled)

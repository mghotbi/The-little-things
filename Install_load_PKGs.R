install_load_packages <- function(reqpkg) {
  # Check which required packages are not installed
  neededpkg <- reqpkg[!reqpkg %in% installed.packages()]
  
  # Filter out packages that cannot be loaded
  neededpkg <- setdiff(neededpkg, c("zCompositions"))
  
  # Install required packages if they are not already installed
  if (length(neededpkg) > 0) {
    cat("The following package(s) need to be installed:", paste(neededpkg, collapse = ", "), "\n")
    install.packages(neededpkg, dependencies = TRUE)
  }
  
  # Load required packages
  cat("Loading required packages...\n")
  invisible(lapply(reqpkg, library, character.only = TRUE))
  cat("All required packages loaded successfully.\n")
}

# Define the list of required packages
reqpkg <- c("edgeR", "PoiClaClu", "microbiome","vcd", "phyloseq", "DESeq2", "foreach", "doParallel","viridis", 
            "plyr", "reshape2", "ggplot2", "grid", "vegan", "scales", "cluster", "ape", "dplyr","ggridges",
            "igraph", "ggnet", "microbiomeutilities","MicEco", "intergraph", "network", "SpiecEasi",
            "data.table", "decontam", "ggtext", "devtools", "dada2", "phyloseq","reshape2","plyr",
            "ggpubr", "agridat", "lme4", "rstatix", "emmeans", "microbiomeMarker", 
            "lmerTest", "reshape", "ggpubr", "gridExtra", "RColorBrewer", "cowplot","grid","ShortRead")

# Call the function to install and load the required packages
install_load_packages(reqpkg)

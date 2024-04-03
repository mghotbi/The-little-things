# Directory containing your R files
run_all_functions <- function(directory) {
  # List all R files in the directory
  file_names <- list.files(directory, pattern = "\\.R$", full.names = TRUE)
  
  # Source each R file
  for (file_name in file_names) {
    source(file_name, local = TRUE)
  }
}

#run_all_functions("G:/My Drive/GitHub/Spike_In_mixed_volume")

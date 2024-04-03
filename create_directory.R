create_directory <- function(directory_path) {
  # Check if the directory already exists
  if (!dir.exists(directory_path)) {
    # If it doesn't exist, create the directory
    dir.create(directory_path)
    cat("Directory created successfully.\n")
  } else {
    cat("Directory already exists.\n")
  }
}

# Call the function with the desired directory path
#create_directory("/path/to/your/new/directory")

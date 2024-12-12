# Load necessary library
library(dplyr)

# Read the dataset
data <- read.csv("Bvog_Unicycler_Final_AssemblyApril SP CDS TM.csv")

# Standardize IDs by removing the ":CDS:n" suffix
data <- data %>%
  mutate(standard_id = gsub(":CDS:[0-9]+$", "", ID))  # Add a new column with standardized IDs

# Filter CDS rows based on the presence of non-CDS rows for the same standardized ID
filtered_data <- data %>%
  group_by(standard_id) %>%                          # Group by standardized ID
  filter(any(Type != "CDS")) %>%                     # Keep groups where at least one Type is not "CDS"
  ungroup() %>%                                      # Ungroup to return a data frame
  select(-standard_id)                               # Drop the helper column

# Save the filtered dataset
write.csv(filtered_data, "filtered_CDS.csv", row.names = FALSE)

# Output the result
print("Filtered data saved to 'filtered_CDS.csv'")

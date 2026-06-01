if (!requireNamespace("tidyverse", quietly = TRUE)) {
  stop("Required package 'tidyverse' is not installed. Install it with: install.packages('tidyverse')")
}
library(tidyverse)

# Step 1. Import dataset
input_file <- "heart_disease.csv"
if (!file.exists(input_file)) {
  stop(paste("Input file not found:", input_file,
             "- ensure the CSV is in the working directory:", getwd()))
}

df <- tryCatch(
  read_csv(input_file, col_names = FALSE, show_col_types = FALSE),
  error = function(e) stop(paste("Failed to read", input_file, "-", conditionMessage(e)))
)

expected_cols <- c("age", "sex", "cp", "trestbps", "chol", "fbs",
                   "restecg", "thalach", "exang", "oldpeak",
                   "slope", "ca", "thal", "target")
if (ncol(df) != length(expected_cols)) {
  stop(paste("Expected", length(expected_cols), "columns but found", ncol(df),
             "in", input_file))
}
colnames(df) <- expected_cols

if (nrow(df) == 0) {
  warning(paste(input_file, "was read successfully but contains 0 rows"))
}

# View first few rows
head(df)
glimpse(df)

# Q1 Tasks:

# 2. Filtering (age > 50)
filtered <- df %>% filter(age > 50)

# 3. Selection (only 5 relevant columns)
selected <- filtered %>% select(age, sex, chol, thalach, target)


# 4. Sorting (descending cholesterol)
sorted <- selected %>% arrange(desc(chol))

# 5. Transformation - Create new categorical column "Risk_Level"
df <- df %>% 
  mutate(Risk_Level = case_when(
    chol > 300 ~ "High",
    chol > 200 ~ "Medium",
    TRUE ~ "Low"
  ))



# Save filtered + mutated data
output_file <- "heart_disease_processed.csv"
tryCatch(
  write_csv(df, output_file),
  error = function(e) stop(paste("Failed to write", output_file, "-", conditionMessage(e)))
)
message(paste("Wrote", nrow(df), "rows to", output_file))


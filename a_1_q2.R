# Q2 Tasks:

# Verify that df exists and has required columns from a_1_q1.R
if (!exists("df")) {
  stop("'df' not found. Run a_1_q1.R first: source('a_1_q1.R')")
}
required_cols <- c("sex", "chol", "thalach", "age", "target")
missing <- setdiff(required_cols, colnames(df))
if (length(missing) > 0) {
  stop(paste("df is missing required columns:", paste(missing, collapse = ", ")))
}

# 1. Another filter (males with high cholesterol)
male_high_chol <- df %>% filter(sex == 1 & chol > 250)
if (nrow(male_high_chol) == 0) {
  warning("No males with cholesterol > 250 found in the dataset")
}

# 2. Mutation - Create new column: Heart_Rate_Category
df <- df %>% 
  mutate(Heart_Rate_Category = case_when(
    thalach > 160 ~ "High",
    thalach > 130 ~ "Normal",
    TRUE ~ "Low"
  ))

# 3. Summary statistics (na.rm = TRUE prevents silent NA propagation)
summary_stats <- df %>% 
  summarise(
    Total_Patients = n(),
    Avg_Age = mean(age, na.rm = TRUE),
    Avg_Cholesterol = mean(chol, na.rm = TRUE),
    Max_Chol = max(chol, na.rm = TRUE),
    Min_Chol = min(chol, na.rm = TRUE),
    Disease_Count = sum(target > 0, na.rm = TRUE)
  )

na_counts <- colSums(is.na(df[required_cols]))
if (any(na_counts > 0)) {
  affected <- na_counts[na_counts > 0]
  warning(paste("NA values found in:",
                paste(names(affected), paste0("(", affected, ")"), collapse = ", "),
                "- summary stats computed with na.rm = TRUE"))
}

# Print summary
print(summary_stats)

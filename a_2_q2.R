# Verify that df exists and has required columns from a_1_q1.R
if (!exists("df")) {
  stop("'df' not found. Run a_1_q1.R first: source('a_1_q1.R')")
}
required_cols <- c("age", "chol", "thalach", "Risk_Level", "target")
missing <- setdiff(required_cols, colnames(df))
if (length(missing) > 0) {
  stop(paste("df is missing required columns:", paste(missing, collapse = ", "),
             "- ensure a_1_q1.R ran successfully"))
}

# 1. Filter
high_risk <- df %>% filter(Risk_Level == "High" | target > 0)
if (nrow(high_risk) == 0) {
  warning("No high-risk or diseased patients found after filtering")
}

# 2. Select
high_risk_subset <- high_risk %>% select(age, chol, thalach, Risk_Level, target)

# 3. Group by & Aggregate (na.rm = TRUE prevents silent NA propagation)
summary_by_risk <- df %>% 
  group_by(Risk_Level) %>% 
  summarise(
    Avg_Chol = mean(chol, na.rm = TRUE),
    Avg_Age = mean(age, na.rm = TRUE),
    Count = n(),
    Disease_Rate = mean(target > 0, na.rm = TRUE) * 100,
    .groups = "drop"
  )

sorted_final <- high_risk_subset %>% arrange(desc(chol))

# Save output in csv
output_file <- "assignment2_final.csv"
tryCatch(
  write_csv(sorted_final, output_file),
  error = function(e) stop(paste("Failed to write", output_file, "-", conditionMessage(e)))
)
message(paste("Wrote", nrow(sorted_final), "rows to", output_file))

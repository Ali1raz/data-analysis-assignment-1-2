# Q1: Visualizations

# Verify that df exists and has required columns from a_1_q1.R
if (!exists("df")) {
  stop("'df' not found. Run a_1_q1.R first: source('a_1_q1.R')")
}
required_cols <- c("cp", "age", "chol", "target", "Risk_Level")
missing <- setdiff(required_cols, colnames(df))
if (length(missing) > 0) {
  stop(paste("df is missing required columns:", paste(missing, collapse = ", "),
             "- ensure a_1_q1.R ran successfully"))
}

# 1. Bar Chart - Chest Pain Type
tryCatch(
  print(
    ggplot(df, aes(x = factor(cp))) +
      geom_bar(fill = "steelblue") +
      labs(title = "Distribution of Chest Pain Types",
           x = "Chest Pain Type (1-4)", y = "Count") +
      theme_minimal()
  ),
  error = function(e) warning(paste("Bar chart failed:", conditionMessage(e)))
)

# 2. Scatterplot - Age vs Cholesterol
tryCatch(
  print(
    ggplot(df, aes(x = age, y = chol, color = factor(target))) +
      geom_point(size = 3, alpha = 0.7) +
      labs(title = "Age vs Cholesterol by Heart Disease",
           x = "Age", y = "Cholesterol") +
      theme_minimal()
  ),
  error = function(e) warning(paste("Scatterplot failed:", conditionMessage(e)))
)

# 3. Pie Chart - Risk Level
tryCatch({
  risk_table <- df %>% count(Risk_Level)
  if (nrow(risk_table) == 0) {
    warning("No Risk_Level data available for pie chart")
  } else {
    print(
      ggplot(risk_table, aes(x = "", y = n, fill = Risk_Level)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar("y") +
        labs(title = "Proportion of Risk Levels") +
        theme_void()
    )
  }
},
error = function(e) warning(paste("Pie chart failed:", conditionMessage(e)))
)


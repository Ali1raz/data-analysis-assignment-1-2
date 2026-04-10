# Q1: Visualizations

# 1. Bar Chart - Chest Pain Type
ggplot(df, aes(x = factor(cp))) +
  geom_bar(fill = "steelblue") +
  labs(title = "Distribution of Chest Pain Types", 
       x = "Chest Pain Type (1-4)", y = "Count") +
  theme_minimal()

# 2. Scatterplot - Age vs Cholesterol
ggplot(df, aes(x = age, y = chol, color = factor(target))) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Age vs Cholesterol by Heart Disease",
       x = "Age", y = "Cholesterol") +
  theme_minimal()

# 3. Pie Chart - Risk Level
risk_table <- df %>% count(Risk_Level)
ggplot(risk_table, aes(x = "", y = n, fill = Risk_Level)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Proportion of Risk Levels") +
  theme_void()


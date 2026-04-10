# Q2 Tasks:

# 1. Another filter (males with high cholesterol)
male_high_chol <- df %>% filter(sex == 1 & chol > 250)

# 2. Mutation - Create new column: Heart_Rate_Category
df <- df %>% 
  mutate(Heart_Rate_Category = case_when(
    thalach > 160 ~ "High",
    thalach > 130 ~ "Normal",
    TRUE ~ "Low"
  ))

# # 3. Summary statistics
summary_stats <- df %>% 
  summarise(
    Total_Patients = n(),
    Avg_Age = mean(age),
    Avg_Cholesterol = mean(chol),
    Max_Chol = max(chol),
    Min_Chol = min(chol),
    Disease_Count = sum(target > 0)
  )

# Print summary

print(summary_stats)

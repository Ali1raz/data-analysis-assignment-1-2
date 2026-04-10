# 1. Filter
high_risk <- df %>% filter(Risk_Level == "High" | target > 0)

# 2. Select
high_risk_subset <- high_risk %>% select(age, chol, thalach, Risk_Level, target)


# 3. Group by & Aggregate
summary_by_risk <- df %>% 
  group_by(Risk_Level) %>% 
  summarise(
    Avg_Chol = mean(chol),
    Avg_Age = mean(age),
    Count = n(),
    Disease_Rate = mean(target > 0) * 100
  )

sorted_final <- high_risk_subset %>% arrange(desc(chol))

# Save output in csv
write_csv(sorted_final, "assignment2_final.csv")


library(tidyverse)

# Step 1. Import dataset
df <- read_csv("heart_disease.csv", col_names = FALSE)

colnames(df) <- c("age", "sex", "cp", "trestbps", "chol", "fbs", 
                  "restecg", "thalach", "exang", "oldpeak", 
                  "slope", "ca", "thal", "target")

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
write_csv(df, "heart_disease_processed.csv")


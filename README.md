# Heart Disease Data Analysis in R

[![Ask DeepWiki about this](https://deepwiki.com/badge.svg)](https://deepwiki.com/Ali1raz/data-analysis-assignment-1-2)

This project applies R data analysis and visualization techniques on the [Heart Disease dataset](https://archive.ics.uci.edu/dataset/45/heart+disease) (1,025 records, 14 clinical attributes). It covers data ingestion, transformation, feature engineering, summary statistics, and `ggplot2` visualizations across two assignments.

## Dataset

The dataset (`heart_disease.csv`) contains 1,025 patient records with the following 14 columns:

| Column     | Description                                      |
| ---------- | ------------------------------------------------ |
| `age`      | Age of the patient (years)                       |
| `sex`      | Sex (1 = male, 0 = female)                       |
| `cp`       | Chest pain type (0-3)                            |
| `trestbps` | Resting blood pressure (mm Hg)                   |
| `chol`     | Serum cholesterol (mg/dl)                        |
| `fbs`      | Fasting blood sugar > 120 mg/dl (1 = true)       |
| `restecg`  | Resting electrocardiographic results (0-2)       |
| `thalach`  | Maximum heart rate achieved                      |
| `exang`    | Exercise-induced angina (1 = yes)                |
| `oldpeak`  | ST depression induced by exercise                |
| `slope`    | Slope of the peak exercise ST segment            |
| `ca`       | Number of major vessels colored by fluoroscopy    |
| `thal`     | Thalassemia (1 = normal, 2 = fixed defect, 3 = reversible defect) |
| `target`   | Heart disease diagnosis (0 = no disease, >0 = disease) |

## Prerequisites

- **R** (>= 4.0)
- **RStudio** (recommended)
- **tidyverse** package (includes `dplyr`, `ggplot2`, `readr`, etc.)

Install the required package in R:

```r
install.packages("tidyverse")
```

## Project Structure

```
.
├── heart_disease.csv              # Raw input dataset (1,025 records)
├── a_1_q1.R                       # Assignment 1, Q1 — Import, filter, select, sort, transform
├── a_1_q2.R                       # Assignment 1, Q2 — Conditional filter, mutation, summary stats
├── a_2_q1.R                       # Assignment 2, Q1 — Bar chart, scatterplot, pie chart
├── a_2_q2.R                       # Assignment 2, Q2 — Wrangling, aggregation, export
├── heart_disease_processed.csv    # Output from a_1_q1.R (with Risk_Level column)
├── assignment2_final.csv          # Final output from a_2_q2.R (high-risk subset)
└── README.md
```

## How to Run

> Scripts must be executed **in order** because later scripts depend on the `df` data frame created by `a_1_q1.R`.

1. Open RStudio and set the working directory to this project folder.
2. Run the scripts sequentially:

```r
source("a_1_q1.R")   # loads df, creates Risk_Level, exports heart_disease_processed.csv
source("a_1_q2.R")   # filters, adds Heart_Rate_Category, prints summary stats
source("a_2_q1.R")   # generates bar chart, scatterplot, pie chart
source("a_2_q2.R")   # filters high-risk, aggregates by group, exports assignment2_final.csv
```

---

## Assignment 1

### Q1 — Data Ingestion, Filtering, Selection, Sorting, and Transformation (`a_1_q1.R`)

| Task | Technique | Details |
| ---- | --------- | ------- |
| **1. Import** | `read_csv()` | Loads `heart_disease.csv` and assigns 14 column names manually |
| **2. Filtering** | `filter(age > 50)` | Selects patients older than 50 |
| **3. Selection** | `select(age, sex, chol, thalach, target)` | Retrieves 5 relevant columns from the filtered set |
| **4. Sorting** | `arrange(desc(chol))` | Sorts rows by cholesterol in descending order |
| **5. Transformation** | `mutate()` + `case_when()` | Creates a new `Risk_Level` column based on cholesterol thresholds |

**Risk_Level thresholds:**

| Cholesterol (`chol`) | Risk Level |
| -------------------- | ---------- |
| > 300                | High       |
| > 200                | Medium     |
| <= 200               | Low        |

The enriched dataset is saved to `heart_disease_processed.csv`.

### Q2 — Conditional Filtering, Mutation, and Summary Statistics (`a_1_q2.R`)

| Task | Technique | Details |
| ---- | --------- | ------- |
| **1. Conditional Filter** | `filter(sex == 1 & chol > 250)` | Selects male patients with cholesterol above 250 |
| **2. Mutation** | `mutate()` + `case_when()` | Creates `Heart_Rate_Category` based on max heart rate (`thalach`) |
| **3. Summary Statistics** | `summarise()` | Reports total patients, average age, average/min/max cholesterol, and disease count |

**Heart_Rate_Category thresholds:**

| Max Heart Rate (`thalach`) | Category |
| -------------------------- | -------- |
| > 160                      | High     |
| > 130                      | Normal   |
| <= 130                     | Low      |

---

## Assignment 2

### Q1 — Data Visualization with ggplot2 (`a_2_q1.R`)

Three visualizations are generated with customized titles, axis labels, colors, and legends:

1. **Bar Chart** — Distribution of Chest Pain Types (`cp`)
   - Shows the frequency of each chest pain category (0-3).
   - *Insight:* Reveals which chest pain types are most common among patients.

2. **Scatterplot** — Age vs. Cholesterol colored by Heart Disease status (`target`)
   - Plots age on the x-axis and cholesterol on the y-axis, with points colored by disease diagnosis.
   - *Insight:* Helps identify whether age and cholesterol together correlate with heart disease presence.

3. **Pie Chart** — Proportion of Risk Levels
   - Displays the share of patients in each `Risk_Level` category (High / Medium / Low).
   - *Insight:* Shows the overall risk distribution across the patient population.

### Q2 — Data Wrangling, Aggregation, and Export (`a_2_q2.R`)

| Task | Technique | Details |
| ---- | --------- | ------- |
| **1. Filtering** | `filter(Risk_Level == "High" \| target > 0)` | Selects patients who are high-risk or have heart disease |
| **2. Selection** | `select(age, chol, thalach, Risk_Level, target)` | Retrieves 5 relevant columns |
| **3. Aggregation** | `group_by(Risk_Level)` + `summarise()` | Calculates average cholesterol, average age, count, and disease rate per risk level |
| **4. Sorting** | `arrange(desc(chol))` | Sorts the high-risk subset by cholesterol descending |

The final high-risk subset is exported to `assignment2_final.csv`.

**Aggregation output columns:**

| Column         | Formula                       |
| -------------- | ----------------------------- |
| `Avg_Chol`     | `mean(chol)`                  |
| `Avg_Age`      | `mean(age)`                   |
| `Count`        | `n()`                         |
| `Disease_Rate` | `mean(target > 0) * 100` (%)  |

---

## Output Files

| File                          | Generated By | Description                                            |
| ----------------------------- | ------------ | ------------------------------------------------------ |
| `heart_disease_processed.csv` | `a_1_q1.R`  | Full dataset with the added `Risk_Level` column        |
| `assignment2_final.csv`       | `a_2_q2.R`  | Subset of high-risk / diseased patients (5 columns)    |

## License

This project is for educational purposes as part of an R programming assignment.

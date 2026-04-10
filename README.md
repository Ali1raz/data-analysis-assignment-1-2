# Heart Disease Data Analysis in R

[![Ask DeepWiki about this](https://deepwiki.com/badge.svg)](https://deepwiki.com/Ali1raz/data-analysis-assignment-1-2)

R-based analysis and visualization of the [Heart Disease dataset](https://www.kaggle.com/datasets/johnsmith88/heart-disease-dataset?resource=download&select=heart.csv) (1,025 records, 14 attributes) using `tidyverse` and `ggplot2`.

## Prerequisites

- **R** (>= 4.0) and **RStudio**
- `install.packages("tidyverse")`

## Project Structure

| File | Description |
| ---- | ----------- |
| `heart_disease.csv` | Raw dataset (1,025 patient records) |
| `a_1_q1.R` | **Assignment 1 Q1** — Import, filter (`age > 50`), select, sort, transform (`Risk_Level`) |
| `a_1_q2.R` | **Assignment 1 Q2** — Conditional filter, mutation (`Heart_Rate_Category`), summary stats |
| `a_2_q1.R` | **Assignment 2 Q1** — Bar chart, scatterplot, pie chart with ggplot2 |
| `a_2_q2.R` | **Assignment 2 Q2** — Filtering, aggregation by `Risk_Level`, CSV export |
| `heart_disease_processed.csv` | Output: full dataset + `Risk_Level` column |
| `assignment2_final.csv` | Output: high-risk patient subset |

## How to Run

Run scripts **in order** in RStudio (each depends on `df` from `a_1_q1.R`):

```r
source("a_1_q1.R")
source("a_1_q2.R")
source("a_2_q1.R")
source("a_2_q2.R")
```

## Assignment 1

### Q1 — Data Wrangling (`a_1_q1.R`)

- **Import** `heart_disease.csv` with 14 named columns
- **Filter** patients with `age > 50`
- **Select** 5 columns: `age`, `sex`, `chol`, `thalach`, `target`
- **Sort** by cholesterol (descending)
- **Transform** — new `Risk_Level` column: High (`chol > 300`), Medium (`> 200`), Low (`<= 200`)
- Exports `heart_disease_processed.csv`

### Q2 — Filtering, Mutation & Stats (`a_1_q2.R`)

- **Filter** males (`sex == 1`) with `chol > 250`
- **Mutate** — new `Heart_Rate_Category`: High (`thalach > 160`), Normal (`> 130`), Low (`<= 130`)
- **Summary stats** — total patients, avg age, avg/min/max cholesterol, disease count

## Assignment 2

### Q1 — Visualization (`a_2_q1.R`)

- **Bar chart** — chest pain type distribution
- **Scatterplot** — age vs. cholesterol, colored by heart disease status
- **Pie chart** — proportion of Risk Levels

### Q2 — Wrangling & Aggregation (`a_2_q2.R`)

- **Filter** high-risk or diseased patients (`Risk_Level == "High" | target > 0`)
- **Select** 5 columns, **sort** by cholesterol descending
- **Group by** `Risk_Level` and compute avg cholesterol, avg age, count, disease rate
- Exports `assignment2_final.csv`

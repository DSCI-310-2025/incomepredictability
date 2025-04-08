# income-predictability

`income-predictability` is an R package developed by STAT 301 Group 8 that provides streamlined functions to support income classification tasks based on demographic and work-related data. It is built as part of a larger data science pipeline to predict whether an individual earns more than \$50K annually using features such as age, education, and hours worked per week.

## Key Features

- `download_data()` – Utility to download datasets from online sources.
- `train_test_split()` – Custom function to split data into training and testing sets with reproducibility.
- `train_logistic_model()` – Builds a logistic regression model to predict binary income outcomes.
- `compute_model_metrics()` – Computes evaluation metrics from a confusion matrix including accuracy, precision, recall, and Cohen's kappa.

## Where this package fits in the R ecosystem

`income-predictability` is intended as a lightweight and beginner-friendly package focused on pedagogy and reproducibility in statistical modeling. It complements existing packages in the R ecosystem:

- **`caret`** and **`tidymodels`**: These are comprehensive machine learning frameworks that provide advanced resampling, preprocessing, and modeling capabilities. `income-predictability` offers a minimal and educational alternative with a focused scope.
- **`rsample`**: Offers more flexibility for data splitting strategies. Our `train_test_split()` function handles simpler use cases with less setup.
- **`yardstick`**: A robust package for evaluating model performance. `compute_model_metrics()` offers a subset of commonly used metrics with a simplified interface.

## Installation

You can install the development version of the package using:
```r
install.packages("devtools")
devtools::install_github("DSCI-310-2025/incomepredictability")
```

## Getting Started

See the package vignette (`vignettes/predict-income.Rmd`) for an end-to-end example using the functions to train and evaluate a logistic regression model on income data.

## License

This package is licensed under the MIT License.

## Authors

Developed by Group 8 for STAT 301 at UBC.

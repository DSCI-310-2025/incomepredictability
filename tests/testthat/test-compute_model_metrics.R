library(here)
library(testthat)
library(incomepredictability)

# source(here::here("R", "compute_model_metrics.R"))

test_that("compute_model_metrics returns correct output for known confusion matrix", {
  cm <- matrix(c(50, 10, 5, 35), nrow = 2, byrow = TRUE)
  rownames(cm) <- c(">50K", "<=50K")
  colnames(cm) <- c(">50K", "<=50K")

  metrics <- compute_model_metrics(cm)

  expect_true("Accuracy" %in% metrics$Metric)
  expect_equal(nrow(metrics), 5)
  expect_type(metrics$Value, "double")

  actual_accuracy <- metrics$Value[metrics$Metric == "Accuracy"]
  expected_accuracy <- (50 + 35) / sum(cm)
  expect_equal(actual_accuracy, expected_accuracy)
})

test_that("compute_model_metrics handles empty confusion matrix", {
  empty_cm <- matrix(0, nrow = 2, ncol = 2)
  rownames(empty_cm) <- c(">50K", "<=50K")
  colnames(empty_cm) <- c(">50K", "<=50K")

  metrics <- compute_model_metrics(empty_cm)

  expect_true("Accuracy" %in% metrics$Metric)
  expect_equal(nrow(metrics), 5)
  expect_type(metrics$Value, "double")

  actual_accuracy <- metrics$Value[metrics$Metric == "Accuracy"]
  expected_accuracy <- (0 + 0) / sum(empty_cm)
  expect_equal(actual_accuracy, expected_accuracy)
})

test_that("compute_model_metrics errors with incorrect labels", {
  wrong_cm <- matrix(c(50, 10, 5, 35), nrow = 2, byrow = TRUE)
  rownames(wrong_cm) <- c("positive", "negative")
  colnames(wrong_cm) <- c("positive", "negative")

  expect_error(
    compute_model_metrics(wrong_cm),
    "Confusion matrix must have '<=50K' and '>50K' as row and column names."
  )
})

test_that("compute_model_metrics errors on invalid input types", {
  expect_error(compute_model_metrics(data.frame(a = 1:2)), "Input must be a matrix.")

  not_2x2 <- matrix(1:9, nrow = 3)
  rownames(not_2x2) <- c("<=50K", ">50K", "??")
  colnames(not_2x2) <- c("<=50K", ">50K", "??")
  expect_error(compute_model_metrics(not_2x2), "Confusion matrix must be 2x2.")
})

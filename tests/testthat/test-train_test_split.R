# tests/test_train_test_split.R
library(testthat)
library(here)
# source(here::here("R", "train_test_split.R"))
library(incomepredictability)

test_that("train_test_split correctly splits a data frame", {
  set.seed(1234)

  # Df of size 100
  sample_df <- data.frame(
    x = 1:100,
    y = 101:200
  )
  result <- train_test_split(sample_df, 0.8)

  # Test the split structure
  expect_true(is.list(result))
  expect_named(result, c("train", "test")) # check for proper element names
  # Row counts
  total_rows <- nrow(result$train) + nrow(result$test)
  expect_equal(total_rows, nrow(sample_df)) # train + test should = original nrow
  # Train/test split counts
  expect_equal(nrow(result$train), 80)
  expect_equal(nrow(result$test), 20)
  # Column similarity
  expect_equal(ncol(result$train), ncol(sample_df))
  expect_equal(ncol(result$test), ncol(sample_df))
})

# Handling fractional splits (testing floor() in our function)
test_that("train_test_split correctly splits a data frame", {
  set.seed(1234)

  # Df of size 7 (0.8 * 7 = 5.6, expecting 5 cause of floor())
  sample_df_2 <- data.frame(
    x = 1:7,
    y = 8:14
  )
  result <- train_test_split(sample_df_2, 0.8)

  # Train/test split counts
  expect_equal(nrow(result$train), 5)
  expect_equal(nrow(result$test), 2)
})

test_that("train_test_split works with small 10-row dataset", {
  df <- data.frame(x = 1:10, y = 11:20)
  result <- train_test_split(df, 0.6)

  expect_equal(nrow(result$train), 6)
  expect_equal(nrow(result$test), 4)
})

test_that("train_test_split handles 1-row input", {
  df <- data.frame(x = 1, y = 2)
  result <- train_test_split(df, 0.8)

  total <- nrow(result$train) + nrow(result$test)
  expect_true(total == 1 || total == 0)
})

test_that("train_test_split errors when input is not a data frame", {
  expect_error(train_test_split(1:10, 0.8), "data frame")
})

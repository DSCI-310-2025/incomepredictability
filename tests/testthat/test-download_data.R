# test_download_data.R
library(testthat)
library(here)
# source(here::here("R", "download_data.R"))
library(incomepredictability)


# test_that("download_data works correctly", {
#   test_url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"
#   test_output <- "housing.data"

#   download_data(test_url, test_output)
#   expect_true(file.exists(test_output))

#   if (file.exists(test_output)) file.remove(test_output)
# })

test_that("download_data works correctly", {
  test_url <- "https://raw.githubusercontent.com/miketham24/adult_dataset/refs/heads/main/adult.csv"
  test_output <- "housing.data"

  download_data(test_url, test_output)
  expect_true(file.exists(test_output))

  if (file.exists(test_output)) file.remove(test_output)
})

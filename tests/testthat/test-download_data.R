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

test_that("download_data overwrites existing file", {
  test_output <- tempfile()
  writeLines("old content", test_output)
  test_url <- "https://raw.githubusercontent.com/miketham24/adult_dataset/refs/heads/main/adult.csv"

  download_data(test_url, test_output)
  expect_true(file.exists(test_output))
})

test_that("download_data fails with invalid URL", {
  bad_url <- "http://this-domain-does-not-exist.abc/adult.csv"
  expect_error(
    suppressWarnings(download_data(bad_url, tempfile())),
    regexp = "Failed to download file"
  )
})

test_that("download_data errors on empty or non-string inputs", {
  expect_error(download_data("", "output.csv"), "`url` must be a non-empty string.")
  expect_error(download_data(123, "output.csv"), "`url` must be a non-empty string.")

  expect_error(download_data("https://example.com/data.csv", ""), "`output` must be a non-empty string.")
  expect_error(download_data("https://example.com/data.csv", 123), "`output` must be a non-empty string.")
})

#' Download a dataset from a URL and save it locally
#'
#' @param url A string specifying the URL of the dataset
#' @param output A string specifying the local file path to save the dataset
#' @return TRUE if download succeeds, otherwise throws an error
#' @examples
#' download_data("https://example.com/data.csv", "data/adult.csv")
#' @export
download_data <- function(url, output) {
  if (!is.character(url) || !nzchar(url)) {
    stop("`url` must be a non-empty string.")
  }
  if (!is.character(output) || !nzchar(output)) {
    stop("`output` must be a non-empty string.")
  }

  tryCatch(
    {
      download.file(url, output, mode = "wb")
      message("Dataset downloaded successfully.")
      return(TRUE)
    },
    error = function(e) {
      stop("Failed to download file: ", conditionMessage(e))
    }
  )
}

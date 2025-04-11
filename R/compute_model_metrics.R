#' Compute evaluation metrics from a confusion matrix
#'
#' @param confusion_matrix A 2x2 matrix with named rows and columns
#' @return A data frame with model evaluation metrics
#' @details
#' The function computes the following metrics:
#' \itemize{
#'   \item Sensitivity (True Positive Rate)
#'   \item Specificity (True Negative Rate)
#'   \item Precision (Positive Predictive Value)
#'   \item Accuracy
#'   \item Cohen's Kappa
#' }
#' @examples
#' cm <- matrix(c(50, 10, 5, 35),
#'   nrow = 2, byrow = TRUE,
#'   dimnames = list(c("<=50K", ">50K"), c("<=50K", ">50K"))
#' )
#' metrics <- compute_model_metrics(cm)
#' print(metrics)
#'
#' @export
compute_model_metrics <- function(confusion_matrix) {
  if (!is.matrix(confusion_matrix)) {
    stop("Input must be a matrix.")
  }

  if (!all(dim(confusion_matrix) == c(2, 2))) {
    stop("Confusion matrix must be 2x2.")
  }

  expected_labels <- c("<=50K", ">50K")
  if (!all(expected_labels %in% rownames(confusion_matrix)) ||
    !all(expected_labels %in% colnames(confusion_matrix))) {
    stop("Confusion matrix must have '<=50K' and '>50K' as row and column names.")
  }

  tp <- confusion_matrix[">50K", ">50K"]
  tn <- confusion_matrix["<=50K", "<=50K"]
  fp <- confusion_matrix[">50K", "<=50K"]
  fn <- confusion_matrix["<=50K", ">50K"]
  n <- tp + tn + fp + fn

  sensitivity <- tp / (tp + fn)
  specificity <- tn / (tn + fp)
  precision <- tp / (tp + fp)
  accuracy <- (tp + tn) / n

  observed_accuracy <- accuracy
  expected_accuracy <- ((tp + fp) / n) * ((tp + fn) / n) +
    ((tn + fp) / n) * ((tn + fn) / n)
  kappa <- (observed_accuracy - expected_accuracy) / (1 - expected_accuracy)

  metrics_df <- data.frame(
    Metric = c("Sensitivity", "Specificity", "Precision", "Accuracy", "Cohen's Kappa"),
    Value = c(sensitivity, specificity, precision, accuracy, kappa)
  )

  return(metrics_df)
}

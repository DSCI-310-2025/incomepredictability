#' Train a logistic regression model for binary classification
#'
#' @param data A data frame containing the variables to be used in the model
#' @param outcome_var A string specifying the name of the binary outcome variable
#' @param predictor_vars A character vector specifying the names of predictor variables
#' @param pos_class A string specifying the positive class in the outcome variable
#' @param neg_class A string specifying the negative class in the outcome variable
#'
#' @importFrom stats as.formula binomial glm predict
#' @importFrom utils download.file
#'
#' @return A list containing the trained model and the ROC curve object
#' @examples
#' # Example usage
#' # Assuming `adult_data` is a data frame with the necessary columns
#' # model_result <- train_logistic_model(adult_data, "income", c("age", "education_num"))
#' # print(model_result$model)
#' # plot(model_result$roc_curve)
#' @details
#' This function trains a logistic regression model using the specified outcome and predictor variables.
#' It also computes the ROC curve for the model.
#' The outcome variable should be a binary factor with two levels.
#' The function will convert the outcome variable to a factor if it is not already.
#' The positive class is assumed to be the one with a higher value.
#' The function requires the `pROC` package for ROC curve computation.
#' If the `pROC` package is not installed, an error will be thrown.
#' @export
train_logistic_model <- function(data, outcome_var, predictor_vars,
                                 pos_class = ">50K", neg_class = "<=50K") {
  if (!requireNamespace("pROC", quietly = TRUE)) {
    stop("Package 'pROC' is required but not installed.")
  }

  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.")
  }
  if (!is.character(outcome_var) || length(outcome_var) != 1) {
    stop("`outcome_var` must be a single string.")
  }
  if (!is.character(predictor_vars) || length(predictor_vars) == 0) {
    stop("`predictor_vars` must be a non-empty character vector.")
  }
  if (!outcome_var %in% names(data)) {
    stop("The outcome variable is not present in the data.")
  }
  if (!all(predictor_vars %in% names(data))) {
    missing_vars <- predictor_vars[!predictor_vars %in% names(data)]
    stop(
      "The following predictor variables are not present in the data: ",
      paste(missing_vars, collapse = ", ")
    )
  }

  if (!is.factor(data[[outcome_var]]) ||
    !all(c(neg_class, pos_class) %in% levels(data[[outcome_var]]))) {
    data[[outcome_var]] <- factor(as.character(data[[outcome_var]]),
      levels = c(neg_class, pos_class)
    )
  }

  formula_str <- paste(outcome_var, "~", paste(predictor_vars, collapse = " + "))
  model_formula <- as.formula(formula_str)

  model <- glm(model_formula, data = data, family = binomial())

  actual_classes <- data[[outcome_var]]
  predicted_probs <- predict(model, type = "response")
  roc_curve <- pROC::roc(actual_classes, predicted_probs)

  return(list(
    model = model,
    roc_curve = roc_curve,
    formula = model_formula
  ))
}

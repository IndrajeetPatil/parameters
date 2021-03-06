# .maxLik, .maxim


#' @export
model_parameters.maxLik <- model_parameters.default


#' @export
model_parameters.maxim <- model_parameters.default


#' @export
p_value.maxLik <- function(model, ...) {
  p <- summary(model)$estimate[, 4]

  .data_frame(
    Parameter = .remove_backticks_from_string(names(p)),
    p = as.vector(p)
  )
}


#' @export
ci.maxLik <- ci.default


#' @export
standard_error.maxLik <- standard_error.default

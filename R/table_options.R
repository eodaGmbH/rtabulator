#' @export
table_options <- function(
    columns = NULL,
    height = NULL,
    layout= c("fitColumns", "fitData", "fitDataFill", "fitDataStretch", "fitDataTable"),
    ...) {
  params <- as.list(environment())
  params$layout <- match.arg(layout)
  c(params, list(...))
}

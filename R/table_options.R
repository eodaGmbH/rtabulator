#' @export
table_options <- function(
    columns = NULL,
    height = NULL,
    layout = c("fitColumns", "fitData", "fitDataFill", "fitDataStretch", "fitDataTable"),
    selectable_rows = "highlight",
    header_visible = TRUE,
    movable_rows = FALSE,
    frozen_rows = NULL,
    row_height = NULL,
    # Experimental
    spreadsheet = FALSE,
    spreadsheet_rows = NULL,
    spreadsheet_columns = NULL,
    ...) {
  params <- as.list(environment())
  params$layout <- match.arg(layout)
  c(params, list(...))
}

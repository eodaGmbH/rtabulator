#' Table Options
#' @export
table_options <- function(
    index = "id",
    columns = NULL,
    height = NULL,
    group_by = NULL,
    # Must be TRUE in order to use 'undo' and 'redo'
    history = FALSE,
    layout = c("fitColumns", "fitData", "fitDataFill", "fitDataStretch", "fitDataTable"),
    # 'highlight', bool or integer
    selectable_rows = "highlight",
    header_visible = TRUE,
    movable_rows = FALSE,
    frozen_rows = NULL,
    row_height = NULL,
    add_row_pos = c("bottom", "top"),
    # Spreadsheet
    spreadsheet = FALSE,
    spreadsheet_rows = NULL,
    spreadsheet_columns = NULL,
    spreadsheet_column_definition = list(editor = "input"),
    ...) {
  params <- as.list(environment())
  params$layout <- match.arg(layout)
  params$add_row_pos <- match.arg(add_row_pos)
  return(c(params, list(...)))
}

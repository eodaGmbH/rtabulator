#' Table Options
#' @param height (character) The height of the table in px.
#' @param history (bool): description
#' @param colummns (list): description
#' @param layout (character): ...
#' @param responsive_layout (bool): description
#' @param movable_columns (bool): description
#' @param header_visible (bool): description
#' @param row_height description
#' @param add_row_pos (character): description
#' @param movable_rows (bool): description
#' @param resizable_rows (bool): description
#' @param frozen_rows description
#' @seealso \url{https://tabulator.info/docs/6.2/options}
#' @export
tabulator_options <- function(
    # General
    height = "311px",
    history = FALSE, # Must be TRUE in order to use 'undo' and 'redo'
    # Columns
    columns = NULL,
    layout = c("fitColumns", "fitData", "fitDataFill", "fitDataStretch", "fitDataTable"),
    responsive_layout = FALSE,
    movable_columns = FALSE,
    header_visible = TRUE,
    # Rows
    row_height = NULL,
    add_row_pos = c("bottom", "top"),
    movable_rows = FALSE,
    resizable_rows = FALSE,
    frozen_rows = NULL,
    # Data
    index = "id",
    # Row Grouping
    group_by = NULL,
    # Editing
    edit_trigger_event = "dblclick",
    # Selection
    selectable_rows = "highlight", # 'highlight', bool or integer
    # Pagination
    pagination = FALSE,
    paginations_size = 10,
    pagination_add_row = "page",
    # Spreadsheet
    spreadsheet = FALSE,
    spreadsheet_rows = NULL,
    spreadsheet_columns = NULL,
    spreadsheet_column_definition = list(editor = "input"),
    spreadsheet_sheets = NULL,
    spreadsheet_sheet_tabs = NULL,
    ...) {
  params <- as.list(environment())
  params$layout <- match.arg(layout)
  params$add_row_pos <- match.arg(add_row_pos)
  return(c(params, list(...)))
}

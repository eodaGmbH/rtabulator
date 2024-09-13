#' Tabulator Setup Options
#' @param height (character) The height of the table in px.
#' @param history (bool): Enable user interaction history functionality.
#' @param columns (list): Column definitions.
#'  If set to \code{NULL} definitions are auto generated from table data.
#' @param layout (character): Layout mode of the table columns.
#' @param responsive_layout (bool): Automatically hide and show columns to fit
#'  the width of the Tabulator element.
#' @param movable_columns (bool): Allow users to move and reorder rows.
#' @param header_visible (bool): Whether header is visible.
#' @param row_height (numeric): A fixed height of the rows.
#' @param add_row_pos (character): The table position where new rows are added.
#' @param movable_rows (bool): Allow users to move and reorder rows.
#' @param resizable_rows (bool): Allow user to resize rows.
#' @param frozen_rows (numeric): Number of frozen rows.
#' @param index (character): Field to be used as the unique index for each row.
#' @param group_by (character): Field to group rows by.
#' @param edit_trigger_event description
#' @param selectable_rows description
#' @param pagination (bool): description
#' @param pagination_size (integer): description
#' @param pagination_add_row (character): description
#' @param spreadsheet (bool): description
#' @param spreadsheet_rows (integer): description
#' @param spreadsheet_columns (integer): description
#' @param spreadsheet_column_definition description
#' @param spreadsheet_sheets (list): description
#' @param spreadsheet_sheet_tabs (bool): description
#' @param ... Further options.
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
    pagination_size = 10,
    pagination_add_row = "page",
    # Spreadsheet
    spreadsheet = FALSE,
    spreadsheet_rows = NULL,
    spreadsheet_columns = NULL,
    spreadsheet_column_definition = NULL,
    spreadsheet_sheets = NULL,
    spreadsheet_sheet_tabs = NULL,
    ...) {
  params <- as.list(environment())
  params$layout <- match.arg(layout)
  params$add_row_pos <- match.arg(add_row_pos)
  return(c(params, list(...)))
}

default_spreadsheet_options <- list(
  row_header = list(
    field = "_id",
    hozAlign = "center",
    headerSort = FALSE,
    frozen = TRUE
  ),
  spreadsheet_column_definition = list(editor = "input")
)

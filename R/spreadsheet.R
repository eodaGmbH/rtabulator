#' Spreadsheet definition for `tabulator()` HTML widget
#'
#' @param title Name of the spreadsheet.
#' @param key Unique key of the spreadsheet.
#' @param data Initial data of the spreadsheet.
#'  Set to `NULL` to create an empty spreadsheet.
#' @returns list with spreadsheet options to be used as a sheet of the
#'  `spreadsheet_sheets` parameter in [tabulator_options()]
#' @example examples/multiple_spreadsheets.R
#' @export
spreadsheet_def <- function(title, key = NULL, data = NULL) {
  return(compact(as.list(environment())))
}

## #' @export
# TODO: Is this useful? Yes, but rename to 'set_options_spreadsheet'
# and use 'modify_tabulator_options'
set_spreadsheet_mode <- function(
    widget,
    spreadsheet_rows = NULL,
    spreadsheet_columns = NULL,
    spreadsheet_column_definition = NULL,
    spreadsheet_sheets = NULL,
    spreadsheet_sheet_tabs = NULL,
    ...) {
  spreadsheet_options <- list(
    spreadsheet = TRUE,
    spreadsheetRows = spreadsheet_rows,
    spreadsheetColumns = spreadsheet_columns,
    spreadsheetColumnDefinition = spreadsheet_column_definition,
    spreadsheetSheets = spreadsheet_sheets,
    spreadsheetSheetTabs = spreadsheet_sheet_tabs,
    ...
  )
  widget$x$options <- keys_to_camel_case(utils::modifyList(
    utils::modifyList(widget$x$options, default_spreadsheet_options),
    compact(spreadsheet_options)
  ))
  return(widget)
}

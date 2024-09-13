## #' @export
# TODO: Is this useful?
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

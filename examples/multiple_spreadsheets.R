setup <- tabulator_options(
  spreadsheet = TRUE,
  spreadsheet_sheets = list(
    spreadsheet_def(
      title = "First",
      data = list(c(1, 2, 3))
    ),
    spreadsheet_def(
      title = "Second",
      data = list(c(4, 5, 6))
    )
  ),
  spreadsheet_sheet_tabs = TRUE
)

tabulator(data = NULL, setup, theme = "midnight")

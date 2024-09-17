#' Download table data
#' @param ctx (\code{\link{tabulatorContext}}): tabulator context object
#' @param type (character): csv, json or xlsx (needs sheetjs: \code{tabulator(..., sheetjs = TRUE)})
#' @param file_name (character): file name
#' @export
trigger_download <- function(ctx, type = c("csv", "json", "xlsx"), file_name) {
  invoke_method(ctx, "download", match.arg(type), file_name)
}

#' Submit data to R
#' @inheritParams trigger_download
#' @export
trigger_get_data <- function(ctx) {
  invoke_method(ctx, "getData")
}

#' Add a row to the table
#' @inheritParams trigger_download
#' @param row (list | NULL) row data or NULL to add an empty row
#' @export
add_row <- function(ctx, row = NULL) {
  invoke_method(ctx, "addRow", row)
}

#' Delete selected rows from the table
#' @inheritParams trigger_download
#' @export
delete_selected_rows <- function(ctx) {
  invoke_method(ctx, "deleteSelectedRows")
}

delete_row <- function(ctx) {
  print("Not implemented yet")
  return(ctx)
}

#' Undo changes
#' @inheritParams trigger_download
#' @export
undo <- function(ctx) {
  invoke_method(ctx, "undo")
}

#' Redo changes
#' @inheritParams trigger_download
#' @export
redo <- function(ctx) {
  invoke_method(ctx, "redo")
}

#' Submit data to R
#' @inheritParams trigger_download
#' @export
trigger_get_sheet_data <- function(ctx) {
  invoke_method(ctx, "getSheetData")
}

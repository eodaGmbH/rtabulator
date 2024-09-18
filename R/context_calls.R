#' Download table data
#' @param ctx (\code{\link{tabulatorContext}}): tabulator context object
#' @param type (character): csv, json or xlsx (needs sheetjs: \code{tabulator(..., sheetjs = TRUE)})
#' @param file_name (character, \code{NULL}): File name.
#' @returns tabulator context object
#'  If \code{NULL}, it is set to \code{"data.{type}"}.
#' @export
trigger_download <- function(ctx, type = c("csv", "json", "xlsx"), file_name = NULL) {
  if (is.null(file_name)) {
    file_name <- glue::glue("data.{type}")
  }

  invoke_method(ctx, "download", match.arg(type), file_name)
}

#' Submit data to R
#' @inheritParams trigger_download
#' @returns tabulator context object
#' @export
trigger_get_data <- function(ctx) {
  invoke_method(ctx, "getData")
}

#' Add row to table
#' @inheritParams trigger_download
#' @param row (list | NULL): row data or \code{NULL} to add an empty row
#' @returns tabulator context object
#' @export
add_row <- function(ctx, row = NULL) {
  invoke_method(ctx, "addRow", row)
}

#' Delete selected rows from table
#' @inheritParams trigger_download
#' @returns tabulator context object
#' @export
delete_selected_rows <- function(ctx) {
  invoke_method(ctx, "deleteSelectedRows")
}

# TODO: Test bindings
delete_row <- function(ctx) {
  print("Not implemented yet")
  return(ctx)
}

#' Undo changes
#' @inheritParams trigger_download
#' @returns tabulator context object
#' @export
undo <- function(ctx) {
  invoke_method(ctx, "undo")
}

#' Redo changes
#' @inheritParams trigger_download
#' @returns tabulator context object
#' @export
redo <- function(ctx) {
  invoke_method(ctx, "redo")
}

#' Submit sheet data to R
#' @inheritParams trigger_download
#' @returns tabulator context object
#' @export
trigger_get_sheet_data <- function(ctx) {
  invoke_method(ctx, "getSheetData")
}

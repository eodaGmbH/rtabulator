#' Download table data
#'
#' @details
#' If you want to support `xlsx` downloads, you need to include
#' the [sheetjs](https://sheetjs.com/) HTML dependency with `tabulator(..., sheetjs = TRUE)`.
#' @param ctx A [tabulatorContext()] object.
#' @param type File format.
#' @param file_name File name. Set to `"data.{type}"` if `file_name = NULL`.
#' @returns A [tabulatorContext()] object
#' @examples
#' \donttest{
#' tabulatorContext("table") |>
#'   trigger_download("csv", "table-data.csv")
#' }
#' @export
trigger_download <- function(ctx, type = c("csv", "json", "xlsx"), file_name = NULL) {
  type <- match.arg(type)
  if (is.null(file_name)) {
    file_name <- glue::glue("data.{type}")
  }

  invoke_method(ctx, "download", type, file_name)
}

#' Submit data to R
#' @inherit trigger_download params return
#' @examples
#' \donttest{
#' tabulatorContext("table") |>
#'   trigger_get_data()
#' }
#' @export
trigger_get_data <- function(ctx) {
  invoke_method(ctx, "getData")
}

#' Add row to table
#' @inherit trigger_download params return
#' @param row (list): row data or \code{NULL} to add an empty row
#' @examples
#' \donttest{
#' tabulatorContext("table") |>
#'   add_row()
#' }
#' @export
add_row <- function(ctx, row = NULL) {
  invoke_method(ctx, "addRow", row)
}

#' Delete selected rows from table
#' @inherit trigger_download params return
#' @examples
#' \donttest{
#' tabulatorContext("table") |>
#'   delete_selected_rows()
#' }
#' @export
delete_selected_rows <- function(ctx) {
  invoke_method(ctx, "deleteSelectedRows")
}

# TODO: Test bindings
delete_row <- function(ctx) {
  message("Not implemented yet")
  return(ctx)
}

#' Undo changes
#' @inherit trigger_download params return
#' @examples
#' \donttest{
#' tabulatorContext("table") |>
#'   undo()
#' }
#' @export
undo <- function(ctx) {
  invoke_method(ctx, "undo")
}

#' Redo changes
#' @inherit trigger_download params return
#' @examples
#' \donttest{
#' tabulatorContext("table") |>
#'   redo()
#' }
#' @export
redo <- function(ctx) {
  invoke_method(ctx, "redo")
}

#' Submit sheet data to R
#' @inherit trigger_download params return
#' @examples
#' \donttest{
#' tabulatorContext("table") |>
#'   trigger_get_sheet_data()
#' }
#' @export
trigger_get_sheet_data <- function(ctx) {
  invoke_method(ctx, "getSheetData")
}

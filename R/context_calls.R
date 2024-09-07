#' Download table data
#' @export
trigger_download <- function(ctx, type, file_name) {
  invoke_method(ctx, "download", type, file_name)
}

#' Add a row to the table
#' @export
add_row <- function(ctx, row = NULL) {
  invoke_method(ctx, "addRow", row)
}

#' Delete selected rows from the table
#' @export
delete_selected_rows <- function(ctx) {
  invoke_method(ctx, "deleteSelectedRows")
}

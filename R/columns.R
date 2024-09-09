#' Create columns definition from data
#' @param data (data.frame) data
#' @param editor (bool): Whether to make columns editable.
#' @param filter (bool): Whether to add a header filter to the columns.
#' @export
create_columns <- function(data, editor = FALSE, filter = FALSE) {
  data <- fix_colnames(data)
  dtype_is_numeric <- sapply(data, is.numeric)
  columns <- purrr::map(
    colnames(data),
    ~ list(
      title = .x,
      field = .x,
      hozAlign = as.vector(ifelse(dtype_is_numeric[.x], "right", "left"))
    )
  )
  if (isTRUE(editor)) {
    columns <- add_editor_to_columns(columns, data)
  }

  if (isTRUE(filter)) {
    columns <- add_filter_to_columns(columns)
  }

  return(columns)
}

fix_colnames <- function(data) {
  colnames(data) <- sub("\\.", "_", colnames(data))
  return(data)
}

set_auto_id <- function(data) {
  if ("id" %in% colnames(data)) {
    return(data)
  }

  data$id <- seq(1:nrow(data))
  return(data)
}

# TODO: Add possibility to add editor to specific columns only
add_editor_to_columns <- function(columns, data) {
  dtype_is_numeric <- sapply(data, is.numeric)
  for (index in 1:length(columns)) {
    columns[[index]]$editor <- as.vector(ifelse(dtype_is_numeric[index], "number", "input"))
  }

  return(columns)
}

add_filter_to_columns <- function(columns) {
  for (index in 1:length(columns)) {
    columns[[index]]$headerFilter <- TRUE # detects column type automatically
  }

  return(columns)
}

# Formatters
set_star_formatter <- function(widget, column, number_of_stars, hoz_align = "center") {

}

set_progress_formatter <- function(widget, column, hoz_align = "left") {
  col_update <- list(formatter = "progress", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

set_tick_cross_formatter <- function(widget, column) {
  col_update <- list(formatter = "tickCross")
  modify_col_def(widget, column, col_update)
}

modify_col_def <- function(widget, column, col_update) {
  for (index in 1:length(widget$x$options$columns)) {
    if (widget$x$options$columns[[index]]$field == column) {
      widget$x$options$columns[[index]] <- modifyList(
        widget$x$options$columns[[index]], col_update
      )
    }
  }

  return(widget)
}

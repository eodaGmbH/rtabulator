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

# Formatters ####

# Plain Text
#' @export
set_formatter_plaintext <- function(widget, column, number_of_stars, hoz_align = "left") {
  col_update <- list(formatter = "plaintext", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

# Text Area
#' @export
set_formatter_textarea <- function(widget, column, hoz_align = "left") {
  col_update <- list(formatter = "textarea", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

# HTML
#' @export
set_formatter_html <- function(widget, column, hoz_align = "left") {
  col_update <- list(formatter = "html", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

# Money
#' @export
set_formatter_money <- function(widget, column, decimal = ",", thousand = ".",
                                symbol = "£", symbol_after = "p",
                                negative_sign = T, precision = F,
                                hoz_align = "left") {
  col_update <- list(
    formatter = "money",
    formatterParams = list(
      decimal = decimal,
      thousand = thousand,
      symbol = symbol,
      symbolAfter = symbol_after,
      negativeSign = negative_sign,
      precision = precision
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

# Image
#' @export
set_formatter_image <- function(widget, column, height = "50px", width = "50px",
                                url_prefix = "",
                                url_suffix = "", hoz_align = "center") {
  col_update <- list(
    formatter = "image",
    formatterParams = list(
      height = height,
      width = width,
      urlPrefix = url_prefix,
      urlSuffix = url_suffix
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

# Link
#' @export
set_formatter_link <- function(
    widget, column,
    label_field = NULL,
    url_prefix = NULL,
    url = NULL,
    target = "_blank",
    hoz_align = "left") {

  col_update <- list(
    formatter = "link",
    formatterParams = compact(list(
      labelField = label_field,
      urlPrefix = url_prefix,
      url = url,
      target = target
    ))
  )
  modify_col_def(widget, column, col_update)
}

# Star
#' @export
set_formatter_star <- function(widget, column, number_of_stars, hoz_align = "center") {
  col_update <- list(
    formatter = "star",
    formatterParams = list(stars = number_of_stars),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}


# Progress
#' @export

set_formatter_progress <- function(
    widget, column,
    min = NULL,
    max = NULL,
    color = c("green", "orange", "red"),
    legend = "",
    legend_color = "#000000",
    legend_align = "center",
    hoz_align = "left") {


  if (is.null(min)){
    min <- min(widget$x$data[column])
  }
  if (is.null(max)){
    max <- max(widget$x$data[column])
  }
  col_update <- list(
    formatter = "progress",
    formatterParams = list(
      min = min,
      max = max,
      color = color,
      legend = legend,
      legendColor = legend_color,
      legendAlign = legend_align
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

#' @export
set_formatter_tick_cross <- function(widget, column) {
  col_update <- list(formatter = "tickCross")
  modify_col_def(widget, column, col_update)
}

modify_col_def <- function(widget, column, col_update) {
  for (index in 1:length(widget$x$options$columns)) {
    if (widget$x$options$columns[[index]]$field == column) {
      widget$x$options$columns[[index]] <- utils::modifyList(
        widget$x$options$columns[[index]], col_update
      )
    }
  }

  return(widget)
}


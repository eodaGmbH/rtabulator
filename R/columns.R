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
set_plaintext_formatter <- function(widget, column, number_of_stars, hoz_align = "left") {
  col_update <- list(formatter = "plaintext", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

# Text Area
#' @export
set_textarea_formatter <- function(widget, column, hoz_align = "left") {
  col_update <- list(formatter = "textarea", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

# HTML
#' @export
set_html_formatter <- function(widget, column, hoz_align = "left") {
  col_update <- list(formatter = "html", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

# Money
#' @export
set_money_formatter <- function(widget, column, decimal = ",", thousand = ".",
                                symbol = "£", symbolAfter = "p",
                                negativeSign = T, precision = F,
                                hoz_align = "left") {
  col_update <- list(
    formatter = "money",
    formatterParams = list(
      decimal = decimal,
      thousand = thousand,
      symbol = symbol,
      symbolAfter = symbolAfter,
      negativeSign = negativeSign,
      precision = precision
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

# Image
#' @export
set_image_formatter <- function(widget, column, height = "50px", width = "50px",
                                urlPrefix = "http://website.com/images/",
                                urlSuffix = ".png", hoz_align = "center") {
  col_update <- list(
    formatter = "image",
    formatterParams = list(
      height = height,
      width = width,
      urlPrefix = urlPrefix,
      urlSuffix = urlSuffix
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

# Link
#' @export

set_link_formatter <- function(widget, column, labelField = "", urlPrefix = "",
                               target = "_blank", hoz_align = "left") {
  col_update <- list(
    formatter = "link",
    formatterParams = list(
      labelField = labelField,
      urlPrefix = urlPrefix,
      target = target
    )
  )

  modify_col_def(widget, column, col_update)
}

# Star
#' @export
set_star_formatter <- function(widget, column, number_of_stars, hoz_align = "center") {
  col_update <- list(
    formatter = "star",
    formatterParams = list(stars = number_of_stars),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}


# Progress
#' @export

set_progress_formatter <- function(
    widget, column,
    min = NULL,
    max = NULL,
    color = c("green", "orange", "red"),
    legend = "",
    legendColor = "#000000",
    legendAlign = "center",
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
      legendColor = legendColor,
      legendAlign = legendAlign
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

#' @export
set_tick_cross_formatter <- function(widget, column) {
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

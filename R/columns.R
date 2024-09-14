#' Create column definitions from data
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

#' HTML Formatter
#' @param widget (\code{\link{tabulator}}) A tabulator widget.
#' @param column (character): The column the formatter is applied to.
#' @param hoz_align (character): The horizontal alignment of the column.
#' @example examples/formatters/formatter_html.R
#' @export
set_formatter_html <- function(widget, column, hoz_align = c("left", "center", "right")) {
  col_update <- list(formatter = "html", hozAlign = match.arg(hoz_align))
  modify_col_def(widget, column, col_update)
}

#' Plain Text Formatter
#' @inheritParams set_formatter_html
#' @export
# TODO: Add example
set_formatter_plaintext <- function(widget, column, hoz_align = "left") {
  col_update <- list(formatter = "plaintext", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

#' Text Area Formatter
#' @inheritParams set_formatter_html
#' @example examples/formatters/formatter_textarea.R
#' @export
set_formatter_textarea <- function(widget, column, hoz_align = "left") {
  col_update <- list(formatter = "textarea", hozAlign = hoz_align)
  modify_col_def(widget, column, col_update)
}

#' Money Formatter
#' @inheritParams set_formatter_html
#' @param decimal (character): Symbol to represent the decimal point.
#' @param thousand (character, bool): Symbol to represent the thousands separator.
#'  Set to \code{FALSE} to disable the separator.
#' @param symbol (character): The currency symbol.
#' @param symbol_after (bool): Whether to put the symbol after the number.
#' @param negative_sign (character, bool): The sign to show in front of the number.
#'  Set to \code{TRUE} causes negative numbers to be enclosed in brackets (123.45),
#'  which is the standard style for negative numbers in accounting.
#' @param precision (integer, bool): The number of decimals to display.
#'  Set to \code{FALSE} to display all decimals that are provided.
#' @example examples/formatters/formatter_money.R
#' @export
set_formatter_money <- function(
    widget,
    column,
    decimal = c(",", "."),
    thousand = c(".", ","),
    symbol = "$", # "\U20AC"
    symbol_after = "p",
    negative_sign = "-",
    precision = FALSE,
    hoz_align = "left") {
  # Body
  col_update <- list(
    formatter = "money",
    formatterParams = list(
      decimal = match.arg(decimal),
      thousand = match.arg(thousand),
      symbol = symbol,
      symbolAfter = symbol_after,
      negativeSign = negative_sign,
      precision = precision
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

#' Image Formatter
#' @inheritParams set_formatter_html
#' @param height (character): A CSS value for the height of the image.
#' @param width (character): A CSS value for the width of the image.
#' @param url_prefix (character): String to add to the start of the cell value
#'  when generating the image src url.
#' @param url_suffix (character): String to add to the end of the cell value
#'  when generating the image src url.
#' @example examples/formatters/formatter_image.R
#' @export
set_formatter_image <- function(
    widget,
    column,
    height = "50px",
    width = "50px",
    url_prefix = NULL,
    url_suffix = NULL,
    hoz_align = "center") {
  col_update <- list(
    formatter = "image",
    formatterParams = compact(list(
      height = height,
      width = width,
      urlPrefix = url_prefix,
      urlSuffix = url_suffix
    )),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

#' Link Formatter
#' @inheritParams set_formatter_html
#' @param label_field (character): Column to be used as label for the link.
#' @param url_prefix (character): Prefix to add to the URL value.
#' @param url (JS function): A JS function that return the URL value.
#'  The cell is passed to the function as its first argument.
#'  Use \link[htmlwidgets]{JS} to pass JS code.
#' @param target (character): Target attribute of the anchor tag.
#' @example examples/formatters/formatter_link.R
#' @export
set_formatter_link <- function(
    widget,
    column,
    label_field = NULL,
    url_prefix = NULL,
    url = NULL,
    target = "_blank",
    hoz_align = "left") {
  # Body
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

#' Star Rating Formatter
#' @inheritParams set_formatter_html
#' @param number_of_stars The maximum number of stars to be displayed.
#'  If set to \code{NA}, the maximum value of the column is used.
#' @example examples/formatters/formatter_star.R
#' @export
set_formatter_star <- function(widget, column, number_of_stars = NA, hoz_align = "center") {
  if (is.na(number_of_stars)) {
    number_of_stars <- max(widget$x$data[column])
  }

  col_update <- list(
    formatter = "star",
    formatterParams = list(stars = number_of_stars),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}


#' Progress Formatter
#' @inheritParams set_formatter_html
#' @param min (numeric): The minimum value for progress bar.
#'  If set to \code{NA} the minimum value of the column is used.
#' @param max (numeric): The maximum value for progress bar.
#'  If set to \code{NA} the maximum value of the column is used.
#' @param color (character): Either a single color or a vector of colors
#' @param legend (character, \code{TRUE}, JavaScript function): If set to \code{TRUE} the value of the cell is displayed.
#'  Set to \code{NA} to display no value at all.
#'  Use \link[htmlwidgets]{JS} to pass a JS function as legend.
#'  The cell value is passed to the function as its first argument.
#' @param legend_color (character): The text color of the legend.
#' @param legend_align (character): The text alignment of the legend.
#' @example examples/formatters/formatter_progress.R
#' @export
set_formatter_progress <- function(
    widget,
    column,
    min = NA,
    max = NA,
    color = c("yellow", "orange", "red"),
    legend = NA,
    legend_color = "#000000",
    legend_align = c("center", "left", "right", "justify"),
    hoz_align = "left") {
  if (is.na(min)) {
    min <- min(widget$x$data[column])
  }

  if (is.na(max)) {
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
      legendAlign = match.arg(legend_align)
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

#' Tick Cross Formatter
#' @inheritParams set_formatter_html
#' @example examples/formatters/formatter_tick_cross.R
#' @export
set_formatter_tick_cross <- function(widget, column) {
  col_update <- list(formatter = "tickCross")
  modify_col_def(widget, column, col_update)
}

#' Toggle Switch Formatter
#' @inheritParams set_formatter_html
#' @param size (numeric): The size of the switch in pixels.
#' @param on_value (character): The value of the cell for the switch to be on.
#' @param off_value (character) The value of the cell for the switch to be off.
#' @param on_truthy (bool): TODO: ???
#' @param on_color (character): The color of the switch if it is on.
#' @param off_color (character): The color of the switch if it is off.
#' @param clickable (bool): Enable switch functionality to toggle the cell value on click.
#' @example examples/formatters/formatter_toggle_switch.R
#' @export
set_formatter_toggle_switch <- function(
    widget,
    column,
    size = 20,
    on_value = "on",
    off_value = "off",
    on_truthy = FALSE,
    on_color = "green",
    off_color = "red",
    clickable = TRUE) {
  # Body
  col_update <- list(
    formatter = "toggle",
    formatterParams = list(
      size = size,
      onValue = on_value,
      offValue = off_value,
      onTruthy = on_truthy,
      onColor = on_color,
      offColor = off_color,
      clickable = clickable
    )
  )
  modify_col_def(widget, column, col_update)
}

#' Datetime Formatter
#' @inheritParams set_formatter_html
#' @param input_format (character): The datetime input format.
#' @param output_format (character): The datetime output format.
#' @param invalid_placeholder (character): The value to be displayed if an invalid datetime is provided.
#' @param timezone (character): The timezone of the datetime.
#' @example examples/formatters/formatter_datetime.R
#' @export
set_formatter_datetime <- function(
    widget,
    column,
    input_format = "yyyy-MM-dd hh:ss:mm",
    output_format = "yy/MM/dd",
    invalid_placeholder = "(invalid datetime)",
    timezone = NA) {
  # Body
  col_update <- list(
    formatter = "datetime",
    formatterParams = list(
      inputFormat = input_format,
      outputFormat = output_format,
      invalidPlaceholder = invalid_placeholder,
      timezone = timezone
    )
  )
  modify_col_def(widget, column, col_update)
}

#' Color Formatter
#' @inheritParams set_formatter_html
#' @example examples/formatters/formatter_color.R
#' @export
set_formatter_color <- function(widget, column) {
  col_update <- list(formatter = "color")
  modify_col_def(widget, column, col_update)
}

#' Traffic Light Formatter
#' @inheritParams set_formatter_progress
#' @example examples/formatters/formatter_traffic_light.R
#' @export
set_formatter_traffic_light <- function(
    widget,
    column,
    min = NA,
    max = NA,
    color = c("green", "orange", "red"),
    hoz_align = "center") {
  # Body
  if (is.na(min)) min <- min(widget$x$data[column])

  if (is.na(max)) max <- max(widget$x$data[column])

  col_update <- list(
    formatter = "traffic",
    formatterParams = list(
      min = min,
      max = max,
      color = color
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, column, col_update)
}

# Other

#' Make columns editable
#' @inheritParams set_formatter_html
#' @param columns (character vector): Columns the editor is applied to.
#' @param type (character): Either \code{input} or \code{number}.
#' @example examples/formatters/column_editor.R
#' @export
set_column_editor <- function(widget, columns, type = c("input", "number")) {
  col_update <- list(editor = match.arg(type))
  for (column in columns) {
    widget <- modify_col_def(widget, column, col_update)
  }

  return(widget)
}

#' Add header filter
#' @inheritParams set_column_editor
#' @param columns (character vector): Columns the editor is applied to.
#'  If set to \code{NULL}, the editor is applied to all columns.
#' @example examples/misc/header_filter.R
#' @export
set_header_filter <- function(widget, columns = NULL) {
  if (is.null(columns)) {
    columns <- colnames(widget$x$data)
  }

  col_update <- list(headerFilter = TRUE)
  for (column in columns) {
    widget <- modify_col_def(widget, column, col_update)
  }

  return(widget)
}

#' Add a calculation to a column
#' @inheritParams set_formatter_html
#' @param func (character): The calculation function to be applied.
#' @export
set_top_calc <- function(
    widget,
    column,
    func = c("avg", "max", "min", "sum", "count", "unique"),
    precision = 2) {
  col_update <- list(topCalc = match.arg(func), topCalcParams = list(precision = precision))
  modify_col_def(widget, column, col_update)
}

# #' @export
set_bottom_calc <- function(widget, column) {

}


# Generics

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

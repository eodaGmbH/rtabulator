# Formatters ####

#' Set HTML formatter
#' @param widget A [tabulator()] HTML widget.
#' @param columns The names of the columns the formatter is applied to.
#' @param hoz_align (character): The horizontal alignment of the column.
#' @returns The updated [tabulator()] HTML widget
#' @example examples/formatters/formatter_html.R
#' @export
set_formatter_html <- function(widget, columns, hoz_align = c("left", "center", "right")) {
  .Deprecated("formatter_html")
  col_update <- list(formatter = "html", hozAlign = match.arg(hoz_align))
  modify_col_def(widget, columns, col_update)
}

#' Set plain text formatter
#' @inherit set_formatter_html params return
#' @examples
#' tabulator(iris) |>
#'   set_formatter_plaintext("Species", hoz_align = "right")
#' @export
set_formatter_plaintext <- function(widget, columns, hoz_align = "left") {
  .Deprecated("formatter_plaintext")
  col_update <- list(formatter = "plaintext", hozAlign = hoz_align)
  modify_col_def(widget, columns, col_update)
}

#' Set text area formatter
#' @inherit set_formatter_html params return
#' @example examples/formatters/formatter_textarea.R
#' @export
set_formatter_textarea <- function(widget, columns, hoz_align = "left") {
  .Deprecated("formatter_textarea")
  col_update <- list(formatter = "textarea", hozAlign = hoz_align)
  modify_col_def(widget, columns, col_update)
}

#' Set money formatter
#' @inherit set_formatter_html params return
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
    columns,
    decimal = c(",", "."),
    thousand = c(".", ","),
    symbol = "$", # "\U20AC"
    symbol_after = "p",
    negative_sign = "-",
    precision = FALSE,
    hoz_align = "left") {
  # Body
  .Deprecated("formatter_money")
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
  modify_col_def(widget, columns, col_update)
}

#' Set image formatter
#' @inherit set_formatter_html params return
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
    columns,
    height = "50px",
    width = "50px",
    url_prefix = NULL,
    url_suffix = NULL,
    hoz_align = "center") {
  # Body
  .Deprecated("formatter_image")
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
  modify_col_def(widget, columns, col_update)
}

#' Set link formatter
#' @inherit set_formatter_html params return
#' @param label_field (character): Column to be used as label for the link.
#' @param url_prefix (character): Prefix to add to the URL value.
#' @param url (JavaScript function): A JavaScript function that return the URL value.
#'  The cell is passed to the function as its first argument.
#'  Use \link[htmlwidgets]{JS} to pass JS code.
#' @param target (character): Target attribute of the anchor tag.
#' @example examples/formatters/formatter_link.R
#' @export
set_formatter_link <- function(
    widget,
    columns,
    label_field = NULL,
    url_prefix = NULL,
    url = NULL,
    target = "_blank",
    hoz_align = "left") {
  # Body
  .Deprecated("formatter_link")
  col_update <- list(
    formatter = "link",
    formatterParams = compact(list(
      labelField = label_field,
      urlPrefix = url_prefix,
      url = url,
      target = target
    )),
    hozAlign = hoz_align
  )
  modify_col_def(widget, columns, col_update)
}

#' Set star rating formatter
#' @inherit set_formatter_html params return
#' @param number_of_stars The maximum number of stars to be displayed.
#'  If set to \code{NA}, the maximum value of the column is used.
#' @example examples/formatters/formatter_star.R
#' @export
set_formatter_star <- function(widget, columns, number_of_stars = NA, hoz_align = "center") {
  if (is.na(number_of_stars)) {
    number_of_stars <- max(widget$x$data[columns])
  }
  .Deprecated("formatter_star")

  col_update <- list(
    formatter = "star",
    formatterParams = list(stars = number_of_stars),
    hozAlign = hoz_align
  )
  modify_col_def(widget, columns, col_update)
}

#' Set progress formatter
#' @inherit set_formatter_html params return
#' @param min (numeric): The minimum value for progress bar.
#'  If set to \code{NA}, the minimum value of the column is used.
#' @param max (numeric): The maximum value for progress bar.
#'  If set to \code{NA}, the maximum value of the column is used.
#' @param color (character): Either a single color or a vector of colors
#' @param legend (character, \code{TRUE}, JavaScript function): If set to \code{TRUE},
#'  the value of the cell is displayed. Set to \code{NA} to display no value at all.
#'  Use \link[htmlwidgets]{JS} to pass a JavaScript function as legend.
#'  In this case, the cell value is passed to the function as its first argument.
#' @param legend_color (character): The text color of the legend.
#' @param legend_align (character): The text alignment of the legend.
#' @example examples/formatters/formatter_progress.R
#' @export
set_formatter_progress <- function(
    widget,
    columns,
    min = NA,
    max = NA,
    color = c("yellow", "orange", "red"),
    legend = NA,
    legend_color = "#000000",
    legend_align = c("center", "left", "right", "justify"),
    hoz_align = "left") {
  .Deprecated("formatter_progress")
  # Body
  if (is.na(min)) {
    min <- min(widget$x$data[columns])
  }

  if (is.na(max)) {
    max <- max(widget$x$data[columns])
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
  modify_col_def(widget, columns, col_update)
}

#' Set tick cross formatter
#' @inherit set_formatter_html params return
#' @example examples/formatters/formatter_tick_cross.R
#' @export
set_formatter_tick_cross <- function(widget, columns, hoz_align = "center") {
  .Deprecated("formatter_tick_cross")
  col_update <- list(formatter = "tickCross", hozAlign = hoz_align)
  modify_col_def(widget, columns, col_update)
}

#' Set toggle switch formatter
#' @inherit set_formatter_html params return
#' @param size (numeric): The size of the switch in pixels.
#' @param on_value (character): The value of the cell for the switch to be on.
#' @param off_value (character) The value of the cell for the switch to be off.
#' @param on_truthy (bool): Whether to show the switch as on if the value of the cell is truthy.
#' @param on_color (character): The color of the switch if it is on.
#' @param off_color (character): The color of the switch if it is off.
#' @param clickable (bool): Enable switch functionality to toggle the cell value on click.
#' @example examples/formatters/formatter_toggle_switch.R
#' @export
set_formatter_toggle_switch <- function(
    widget,
    columns,
    size = 20,
    on_value = "on",
    off_value = "off",
    on_truthy = FALSE,
    on_color = "green",
    off_color = "red",
    clickable = TRUE) {
  # Body
  .Deprecated("formatter_toggle_switch")
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
  modify_col_def(widget, columns, col_update)
}

#' Set datetime formatter
#'
#' @details
#' To use this formatter, you need to include
#' the [luxon](https://moment.github.io/luxon/) HTML dependency with `tabulator(..., luxon = TRUE)`.
#' @inherit set_formatter_html params return
#' @param input_format (character): The datetime input format.
#' @param output_format (character): The datetime output format.
#' @param invalid_placeholder (character): The value to be displayed
#'  if an invalid datetime is provided.
#' @param timezone (character): The timezone of the datetime.
#' @example examples/formatters/formatter_datetime.R
#' @export
set_formatter_datetime <- function(
    widget,
    columns,
    input_format = "yyyy-MM-dd hh:ss:mm",
    output_format = "yy/MM/dd",
    invalid_placeholder = "(invalid datetime)",
    timezone = NA,
    hoz_align = "left") {
  .Deprecated("formatter_datetime")
  # Body
  col_update <- list(
    formatter = "datetime",
    formatterParams = list(
      inputFormat = input_format,
      outputFormat = output_format,
      invalidPlaceholder = invalid_placeholder,
      timezone = timezone
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, columns, col_update)
}

#' Set color formatter
#' @inherit set_formatter_html params return
#' @example examples/formatters/formatter_color.R
#' @export
set_formatter_color <- function(widget, columns) {
  .Deprecated("formatter_color")
  col_update <- list(formatter = "color")
  modify_col_def(widget, columns, col_update)
}

#' Set traffic light formatter
#' @inherit set_formatter_progress params return
#' @example examples/formatters/formatter_traffic_light.R
#' @export
set_formatter_traffic_light <- function(
    widget,
    columns,
    min = NA,
    max = NA,
    color = c("green", "orange", "red"),
    hoz_align = "center") {
  .Deprecated("formatter_traffic_light")
  # Body
  if (is.na(min)) min <- min(widget$x$data[columns])

  if (is.na(max)) max <- max(widget$x$data[columns])

  col_update <- list(
    formatter = "traffic",
    formatterParams = list(
      min = min,
      max = max,
      color = color
    ),
    hozAlign = hoz_align
  )
  modify_col_def(widget, columns, col_update)
}

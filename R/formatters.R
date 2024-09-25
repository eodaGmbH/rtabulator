# Formatters ####

#' HTML formatter
#' @returns A list of column options for setting up the formatter.
#' @example examples/formatters/formatter_html.R
#' @export
formatter_html <- function(){
  col_update <- list(formatter = "html")
  return(col_update)
}

#' Plain text formatter
#' @inherit formatter_html return
#' @example examples/formatters/formatter_html.R
#' @export
formatter_plaintext <- function() {
  col_update <- list(formatter = "plaintext")
  return(col_update)
}

#' Text area formatter
#' @inherit formatter_html return
#' @example examples/formatters/formatter_textarea.R
#' @export
formatter_textarea <- function() {
  col_update <- list(formatter = "textarea")
  return(col_update)
}

#' Money formatter
#' @inherit formatter_html return
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
formatter_money <- function(
    decimal = c(",", "."),
    thousand = c(".", ","),
    symbol = "$ ", # "\U20AC"
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
    )
  )
  return(col_update)
}

#' Image formatter
#' @inherit formatter_html return
#' @param height (character): A CSS value for the height of the image.
#' @param width (character): A CSS value for the width of the image.
#' @param url_prefix (character): String to add to the start of the cell value
#'  when generating the image src url.
#' @param url_suffix (character): String to add to the end of the cell value
#'  when generating the image src url.
#' @example examples/formatters/formatter_image.R
#' @export
formatter_image <- function(
    height = "50px",
    width = "50px",
    url_prefix = NULL,
    url_suffix = NULL) {
  # Body
  col_update <- list(
    formatter = "image",
    formatterParams = compact(list(
      height = height,
      width = width,
      urlPrefix = url_prefix,
      urlSuffix = url_suffix
    ))
  )
  return(col_update)
}

#' Link formatter
#' @inherit formatter_html return
#' @param label_field (character): Column to be used as label for the link.
#' @param url_prefix (character): Prefix to add to the URL value.
#' @param url (JavaScript function): A JavaScript function that return the URL value.
#'  The cell is passed to the function as its first argument.
#'  Use \link[htmlwidgets]{JS} to pass JS code.
#' @param target (character): Target attribute of the anchor tag.
#' @example examples/formatters/formatter_link.R
#' @export
formatter_link <- function(
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
  return(col_update)
}

#' Star rating formatter
#' @inherit formatter_html return
#' @param number_of_stars The maximum number of stars to be displayed.
#'  If set to \code{NA}, the maximum value of the column is used.
#' @example examples/formatters/formatter_star.R
#' @export
formatter_star <- function(number_of_stars = NA) {
  col_update <- list(
    formatter = "star",
    formatterParams = list(stars = number_of_stars)
  )
  return(col_update)
}

#' Progress formatter
#' @inherit formatter_html return
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
formatter_progress <- function(
    min = NA,
    max = NA,
    color = c("yellow", "orange", "red"),
    legend = NA,
    legend_color = "#000000",
    legend_align = c("center", "left", "right", "justify")) {
  # Body

  col_update <- list(
    formatter = "progress",
    formatterParams = list(
      min = min,
      max = max,
      color = color,
      legend = legend,
      legendColor = legend_color,
      legendAlign = match.arg(legend_align)
    )
  )
  return(col_update)
}

#' Tick cross formatter
#' @inherit formatter_html return
#' @example examples/formatters/formatter_tick_cross.R
#' @export
formatter_tick_cross <- function() {
  col_update <- list(formatter = "tickCross")
  return(col_update)
}

#' Set toggle switch formatter
#' @inherit formatter_html return
#' @param size (numeric): The size of the switch in pixels.
#' @param on_value (character): The value of the cell for the switch to be on.
#' @param off_value (character) The value of the cell for the switch to be off.
#' @param on_truthy (bool): Whether to show the switch as on if the value of the cell is truthy.
#' @param on_color (character): The color of the switch if it is on.
#' @param off_color (character): The color of the switch if it is off.
#' @param clickable (bool): Enable switch functionality to toggle the cell value on click.
#' @example examples/formatters/formatter_toggle_switch.R
#' @export
formatter_toggle_switch <- function(
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
  return(col_update)
}

#' Set datetime formatter
#'
#' @details
#' To use this formatter, you need to include
#' the [luxon](https://moment.github.io/luxon/) HTML dependency with `tabulator(..., luxon = TRUE)`.
#' @inherit formatter_html return
#' @param input_format (character): The datetime input format.
#' @param output_format (character): The datetime output format.
#' @param invalid_placeholder (character): The value to be displayed
#'  if an invalid datetime is provided.
#' @param timezone (character): The timezone of the datetime.
#' @example examples/formatters/formatter_datetime.R
#' @export
formatter_datetime <- function(
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
  return(col_update)
}

#' Set color formatter
#' @inherit formatter_html return
#' @example examples/formatters/formatter_color.R
#' @export
formatter_color <- function() {
  col_update <- list(formatter = "color")
  return(col_update)
}

#' Set traffic light formatter
#' @inherit formatter_progress params return
#' @example examples/formatters/formatter_traffic_light.R
#' @export
formatter_traffic_light <- function(
    min = NA,
    max = NA,
    color = c("green", "orange", "red")) {
  # Body
  col_update <- list(
    formatter = "traffic",
    formatterParams = list(
      min = min,
      max = max,
      color = color
    )
  )
  return(col_update)
}

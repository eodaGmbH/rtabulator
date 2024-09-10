#' Create a Tabulator Widget
#'
#' @param data (data.frame or list): In spreadsheet mode data needs to be a list or \code{NULL}
#'  for an empty spreadsheet.
#' @param options (list): Setup options. See \code{\link{tabulator_options}}.
#' @param editable (bool): Whether the table is editable.
#' @param theme (character): Theme to apply to the table.
#' @param width Width of the widget.
#' @param height Height of the widget.
#' @param elementId description
#' @param ... Named arguments that are appended to the \code{options} parameter.
#' @import htmlwidgets
#' @export
tabulator <- function(
    data,
    options = tabulator_options(),
    rtabulator_auto_columns = TRUE,
    editable = FALSE,
    theme = c("default", "midnight", "modern", "simple", "site", "bootstrap3", "bootstrap4", "bootstrap5", "bulma", "materialize", "semanticui"),
    width = NULL,
    height = NULL,
    elementId = NULL,
    ...) {
  if (is.null(options)) options <- list()

  options <- utils::modifyList(options, list(...))
  if (isTRUE(options$spreadsheet)) {
    # ...
  } else {
    data <- fix_colnames(data)
    if (getOption("rtabulator.auto_columns", TRUE) && is.null(options$columns)) {
      options$columns <- create_columns(data, editor = editable)
    }

    data <- set_auto_id(data)
  }

  theme <- match.arg(theme)
  stylesheet_text <- ifelse(theme == "default", NA, read_tabulator_theme(theme))

  x <- list(
    data = data,
    options = keys_to_camel_case(compact(options)),
    stylesheetText = stylesheet_text
  )


  # create widget
  htmlwidgets::createWidget(
    name = "rtabulator",
    x,
    width = width,
    height = height,
    package = "rtabulator",
    elementId = elementId
  )
}

#' Shiny bindings for rtabulator
#'
#' Output and render functions for using rtabulator within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a rtabulator
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name rtabulator-shiny
#'
#' @export
tabulatorOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "rtabulator", width, height, package = "rtabulator")
}

#' @rdname rtabulator-shiny
#' @export
renderTabulator <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, tabulatorOutput, env, quoted = TRUE)
}

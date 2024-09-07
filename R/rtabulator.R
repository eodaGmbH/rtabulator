#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
tabulator <- function(data, table_options = NULL,
                       rtabulator_auto_columns = TRUE,
                       width = NULL, height = NULL, elementId = NULL, ...) {
  table_options <- merge_lists(table_options, list(...))
  if (is.null(table_options)) table_options <- list()

  if (isTRUE(table_options$spreadsheet)) {
    # ...
  } else {
    data <- fix_colnames(data)
    if (rtabulator_auto_columns && is.null(table_options$columns)) {
      table_options$columns <- create_columns(data)
    }
  }

  x <- list(
    data = data,
    options = keys_to_camel_case(compact(table_options))
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

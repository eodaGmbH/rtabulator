#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
tabulator <- function(data, options = tabulator_options(),
                      rtabulator_auto_columns = TRUE,
                      editable = FALSE,
                      width = NULL, height = NULL, elementId = NULL, ...) {
  if (is.null(options)) options <- list()

  options <- utils::modifyList(options, list(...))
  if (isTRUE(options$spreadsheet)) {
    # ...
  } else {
    data <- fix_colnames(data)
    if (rtabulator_auto_columns && is.null(options$columns)) {
      options$columns <- create_columns(data, editor = editable)
    }

    data <- set_auto_id(data)
  }

  x <- list(
    data = data,
    options = keys_to_camel_case(compact(options))
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

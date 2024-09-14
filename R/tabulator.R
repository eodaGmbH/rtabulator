#' Create a Tabulator Widget
#'
#' Dots in column names are replaced by underscores.
#' @param data (data.frame, character or list): In spreadsheet mode data needs to be a list or \code{NULL}
#'  for an empty spreadsheet.
#' @param options (list): Setup options. See \code{\link{tabulator_options}}.
#' @param editable (bool): Whether the table is editable.
#' @param sheetjs (bool): Whether to add sheetjs (\url{https://sheetjs.com/}) dependency,
#'  which is needed for xlsx downloads.
#' @param theme (character): Theme to apply to the table.
#' @param col_select (character vector) Columns to select.
#'  Passed to \code{\link[readr]{read_csv}} if \code{data} is a file name.
#' @param width Width of the widget.
#' @param height Height of the widget.
#' @param element_id The unique ID of the widget.
#' @param ... Named arguments that are appended to the \code{options} parameter.
#' @example examples/multiple_spreadsheets.R
#' @import htmlwidgets
#' @export
tabulator <- function(
    data,
    options = tabulator_options(),
    editable = FALSE,
    sheetjs = FALSE,
    theme = c("default", "midnight", "modern", "simple", "site", "bootstrap3", "bootstrap4", "bootstrap5", "bulma", "materialize", "semanticui"),
    col_select = NULL,
    width = NULL,
    height = NULL,
    element_id = NULL,
    ...) {
  if (is.null(options)) options <- list()

  if (is.character(data)) {
    data <- readr::read_csv(data, show_col_types = FALSE, col_select = !!col_select)
  }

  # TODO: Use Pipe, but then we need to set required R Version to > 4.1
  options <- utils::modifyList(options, list(...))
  options <- keys_to_camel_case(compact(options))
  if (isTRUE(options$spreadsheet)) {
    # ...
    options <- utils::modifyList(default_spreadsheet_options, options)
  } else if (is.data.frame(data)) {
    data <- fix_colnames(data)
    if (getOption("rtabulator.auto_columns", TRUE) && is.null(options$columns)) {
      options$columns <- create_columns(data, editor = editable)
    }

    data <- set_auto_id(data)
  }

  theme <- match.arg(theme)
  # stylesheet_text <- ifelse(theme == "default", NA, read_tabulator_theme(theme))
  stylesheet_text <- NA

  x <- list(
    data = data,
    options = keys_to_camel_case(compact(options)),
    stylesheetText = stylesheet_text
  )

  # TODO: Make it optional when datetime formatter is called
  dependencies <- list(luxon_dependency)
  if (theme != "default") {
    dependencies <- c(dependencies, list(get_theme_dependeny(theme)))
  }

  if (sheetjs) {
    dependencies <- c(dependencies, list(sheetjs_dependency))
  }

  # create widget
  htmlwidgets::createWidget(
    name = "rtabulator",
    x,
    width = width,
    height = height,
    package = "rtabulator",
    dependencies = dependencies,
    elementId = element_id
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

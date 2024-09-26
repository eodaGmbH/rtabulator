#' HTML widget to work with tabular data
#'
#' @details
#' Dots in column names are replaced by underscores.
#' @param data (data.frame, character or list): In spreadsheet mode data needs to be a list or \code{NULL}
#'  for an empty spreadsheet.
#' @param options List of setup options. Defaults to [tabulator_options()].
#' @param editable Whether the table is editable.
#' @param luxon Whether to add [luxon](https://moment.github.io/luxon/) HTML dependency,
#'  which is required for [set_formatter_datetime()].
#' @param sheetjs Whether to add [sheetjs](https://sheetjs.com/) HTML dependency,
#'  which is required for [trigger_download()] to support downloads of `xlsx` files.
#' @param theme Name of the theme to be applied to the table.
#' @param col_select Passed to [readr::read_csv()] if `data` is a file name.
#' @param width,height Output size.
#' @param element_id Unique ID of the widget element.
#' @param ... Named arguments that are appended to the `options` parameter.
#' @seealso [tabulatorOutput()] for use within Shiny apps
#' @returns A HTML widget
#' @example examples/multiple_spreadsheets.R
#' @import htmlwidgets
#' @export
tabulator <- function(
    data,
    options = tabulator_options(),
    editable = FALSE,
    luxon = FALSE,
    sheetjs = FALSE,
    theme = c("default", "midnight", "modern", "simple", "site", "bootstrap3", "bootstrap4", "bootstrap5", "bulma", "materialize", "semanticui"),
    col_select = NULL,
    width = NULL,
    height = NULL,
    element_id = NULL,
    ...) {
  # Body
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
    bindingOptions = list(lang = "r"),
    stylesheetText = stylesheet_text
  )

  dependencies <- list()
  if (isTRUE(luxon)) {
    dependencies <- c(dependencies, list(luxon = luxon_dependency))
  }

  if (theme != "default") {
    dependencies <- c(dependencies, list(get_theme_dependeny(theme)))
  }

  if (sheetjs) {
    dependencies <- c(dependencies, list(sheet = sheetjs_dependency))
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
#' @returns Components for use inside a Shiny app.
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

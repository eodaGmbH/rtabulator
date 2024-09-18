# See example here: https://github.com/eodaGmbH/py-tabulator/blob/main/docs/examples/getting_started/shiny_core_multi_row_headers.py
#' Set multi column header
#' @inheritParams set_formatter_html
#' @param multi_columns (list): Multi column definitions.
#' @example examples/experimental/multi_column_header.R
#' @export
set_multi_column_header <- function(widget, multi_columns) {
  res <- list()
  for (key in names(multi_columns)) {
    column_names <- multi_columns[[key]]
    column_defs <- purrr::map(column_names, ~ find_column(widget, .x))
    res <- append(res, list(list(title = key, columns = column_defs)))
  }

  # Add columns not used in multi_columns
  used_cols <- unlist(multi_columns)
  for (column_name in unlist(purrr::map(widget$x$options$columns, ~ .x$field))) {
    if (!column_name %in% used_cols) res <- append(res, list(find_column(widget, column_name)))
  }

  # return(res)
  widget$x$options$columns <- res
  return(widget)
}

find_column <- function(widget, column) {
  column_def <- NULL
  for (item in widget$x$options$columns) {
    if (item$field == column) column_def <- item
  }

  return(column_def)
}

# Themes ####

get_theme_dependeny <- function(
    theme = c("midnight", "modern", "simple", "site", "bootstrap3", "bootstrap4", "bootstrap5", "bulma", "materialize", "semanticui")) {
  # Body
  theme <- match.arg(theme)
  htmltools::htmlDependency(
    name = "tabulator-theme",
    version = "6.2.5",
    src = system.file("htmlwidgets/libs/tabulator", package = "rtabulator"),
    stylesheet = glue::glue("tabulator_{theme}.min.css"),
    all_files = FALSE
  )
}

# #' Create column definitions from data
# #' @param data (data.frame) data
# #' @param editor (bool): Whether to make columns editable.
# #' @param filter (bool): Whether to add a header filter to the columns.
# #' @returns list
# TODO: We do not need to export this func anymore
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

  if (nrow(data) == 0) {
    data$id <- numeric()
    return(data)
  }

  data$id <- seq(1:nrow(data))
  return(data)
}

# TODO: Add possibility to add editor to specific columns only
# TODO: Check if func is obsolete
add_editor_to_columns <- function(columns, data) {
  dtype_is_numeric <- sapply(data, is.numeric)
  for (index in 1:length(columns)) {
    columns[[index]]$editor <- as.vector(ifelse(dtype_is_numeric[index], "number", "input"))
  }

  return(columns)
}

# TODO: Check if func is obsolete
add_filter_to_columns <- function(columns) {
  for (index in 1:length(columns)) {
    columns[[index]]$headerFilter <- TRUE # detects column type automatically if editor type is set
  }

  return(columns)
}

#' Apply a column setter function to multiple columns
#' @inherit set_formatter_html params return
#' @param columns (character vector): The columns the column setter function (\code{.f}) is applied to.
#'  If set to \code{NULL},  it is applied to all columns.
#' @param .f (function): The column setter function that updates the column settings.
#' @param ... Arguments that are passed to \code{.f}.
#' @example examples/for_each_col.R
#' @export
for_each_col <- function(widget, columns = NULL, .f, ...) {
  if (is.null(columns)) columns <- colnames(widget$x$data)

  args <- list(...)

  for (column in columns) {
    widget <- do.call(.f, c(list(widget = widget, column = column), args))
  }

  return(widget)
}


# Other

# TODO: Deprecated
# #' Make columns editable
# #' @inheritParams set_formatter_html
# #' @param columns (character vector): Columns the editor is applied to.
# #' @param type (character): Either \code{input} or \code{number}.
# #' @example examples/formatters/column_editor.R
set_column_editor_ <- function(widget, columns, type = c("input", "number")) {
  col_update <- list(editor = match.arg(type))
  for (column in columns) {
    widget <- modify_col_def(widget, column, col_update)
  }

  return(widget)
}

#' Set editor
#' @inherit set_formatter_html params return
#' @param editor (character): The editor type.
#' @param validator (character vector): One or more validators to validate user input.
#' @param ... Optional editor parameters depending on the selected editor.
#' @seealso
#'  * \url{https://tabulator.info/docs/6.2/edit} for available editors
#'  * \url{https://tabulator.info/docs/6.2/validate} for available validators
#' @md
#' @example examples/editors.R
#' @export
set_editor <- function(
    widget,
    columns,
    editor = c(
      "input", "textarea", "number", "range",
      "tickCross", "star", "progress", "date", "time", "datetime", "list"
    ),
    validator = NULL,
    ...) {
  # Body
  col_update <- list(editor = match.arg(editor), validator = validator)
  editor_params <- list(...)
  if (length(editor_params) > 0) {
    col_update$editorParams <- keys_to_camel_case(compact(editor_params))
  }

  modify_col_def(widget, columns, col_update)
}

#' Set header filter
#' @inherit set_formatter_html params return
#' @param type (character): The type of the filter.
#' @param values_lookup (bool): Whether to use unique column values for the list filter.
#' @param func (character): The filter function.
#' @param clearable (bool): Whether to display a cross to clear the filter.
#' @param placeholder (character): Text that is displayed when no filter is set.
#' @example examples/misc/header_filter.R
#' @export
# TODO: Rename to params that they match params used by Tabulator JS
set_header_filter <- function(
    widget,
    columns,
    # TODO: Rename to 'filter_type' or just 'filter' or 'header_filter'?
    type = c("input", "number", "list", "tickCross"),
    # TODO: Rename to 'filter_func'?
    func = c("like", "=", ">", ">=", "<", "<="),
    values_lookup = TRUE,
    clearable = TRUE,
    placeholder = NULL) {
  # Body
  if (is.null(type)) {
    type <- ifelse(is.numeric(widget$x$data[, columns]), "number", "input")
  } else {
    type <- match.arg(type)
  }

  header_filter_params <- compact(list(
    clearable = clearable,
    valuesLookup = values_lookup
  ))
  col_update <- list(
    headerFilter = type,
    headerFilterPlaceholder = placeholder,
    headerFilterFunc = func,
    headerFilterParams = header_filter_params
  )
  modify_col_def(widget, columns, col_update)
}

#' Set tooltip
#' @inherit set_formatter_html params return
#' @example examples/misc/tooltip.R
#' @export
set_tooltip <- function(widget, columns) {
  modify_col_def(widget, columns, list(tooltip = TRUE))
}


#' Set column defaults
#' @inherit set_formatter_html params return
#' @param editor (character, bool): One of \code{"input"} or \code{"number"}.
#'  If set to \code{FALSE} cells are not editable.
#' @param header_filter (character, bool): One of \code{"input"} or \code{"number"}.
#'  Set to \code{FALSE} to disable header filters.
#' @param header_sort (bool): Whether to enable header sorting.
#' @param tooltip (bool): Whether to show tooltips displaying the cell value.
#' @param width (integer): Fixed width of columns.
#' @param ... Additional settings.
#' @seealso \url{https://tabulator.info/docs/6.2/columns#defaults}
#' @example examples/column_defaults.R
#' @export
set_column_defaults <- function(
    widget,
    editor = FALSE,
    header_filter = FALSE,
    header_sort = TRUE,
    tooltip = TRUE,
    width = NULL,
    ...) {
  # Body
  widget$x$options$columnDefaults <- compact(list(
    editor = editor,
    headerFilter = header_filter,
    headerSort = header_sort,
    tooltip = tooltip,
    width = width,
    ...
  ))
  return(widget)
}

#' Set calculation
#' @inherit set_formatter_html params return
#' @param func (character): The calculation function to be applied
#'  to the values of the \code{column}.
#' @param precision (integer)  The number of decimals to display.
#'  Set to \code{FALSE} to display all decimals.
#' @param pos (character): Position at which calculated values are displayed.
#' @examples
#' tabulator(iris) |>
#'   set_calculation("Sepal_Length", "avg")
#' @export
set_calculation <- function(
    widget,
    columns,
    func = c("avg", "max", "min", "sum", "count", "unique"), # Rename to 'calc'?
    precision = 2,
    pos = c("top", "bottom")) {
  # Body
  pos <- match.arg(pos)
  col_update <- list(match.arg(func), list(precision = precision))
  names(col_update) <- c(paste0(pos, "Calc"), paste0(pos, "CalcParams"))
  modify_col_def(widget, columns, col_update)
}

# Generics

#' Modify column definition
#' @inherit set_formatter_html params return
#' @param col_update A named list containing the updates to apply to each column in `columns`.
#' The updates are merged into the existing column definitions.
#' @importFrom utils modifyList
#' @export
#' @examples
#'
#' df <- data.frame(values = c(1,2,3), names = c("a","b","c"))
#' tabulator(df) |>
#'   modify_col_def(c("values","names"),
#'   col_update = list(hozAlign = "center"))

modify_col_def <- function(widget, columns, col_update) {
  for (column in columns) {
    for (index in 1:length(widget$x$options$columns)) {
      if (widget$x$options$columns[[index]]$field == column) {
        widget$x$options$columns[[index]] <- utils::modifyList(
          widget$x$options$columns[[index]], col_update
        )
      }
    }
  }

  return(widget)
}

#' Setup options for `tabulator()` HTML widget
#'
#' @param height (character) The height of the table in pixels.
#' @param history (bool): Enable user interaction history functionality.
#' @param columns (list): Column definitions.
#'  If set to \code{NULL}, definitions are auto generated from table data.
#' @param layout (character): Layout mode of the table columns.
#' @param responsive_layout (bool): Automatically hide and show columns to fit
#'  the width of the Tabulator element.
#' @param movable_columns (bool): Allow users to move and reorder rows.
#' @param header_visible (bool): Whether header is visible.
#' @param row_height (numeric): A fixed height of the rows.
#' @param add_row_pos (character): The table position where new rows are added.
#' @param movable_rows (bool): Allow users to move and reorder rows.
#' @param resizable_rows (bool): Allow user to resize rows.
#' @param frozen_rows (numeric): Number of frozen rows.
#' @param index (character): Field to be used as the unique index for each row.
#' @param group_by (character vector): Field to group rows by. Pass multiple values
#'  for multi level grouping.
#' @param group_start_open (bool vector): Open state of groups when grouping is enabled.
#'  The length of the vector depends on the number of levels set with \code{group_by}.
#' @param group_toggle_element (character, bool): One of \code{arrow} or \code{header}.
#'  Set to \code{FALSE} to disable toggling at all.
#' @param edit_trigger_event (character): Event that triggers a cell edit.
#' @param selectable_rows (character, bool, integer) Set to \code{FALSE} to disble row selection.
#'  If set to \code{TRUE}, you can select as many rows as you want.
#'  If set to \code{"highlight"}, rows are just highlighted but do not change state when clicked.
#'  An integer value sets the maximum number of rows that can be selected.
#' @param pagination (bool): Whether to enable pagination.
#' @param pagination_size (integer): Number of rows on each page.
#' @param pagination_size_selector (list): Add pagination size selector.
#' @param pagination_add_row (character): Where to add rows to the table when pagination is enabled.
#' @param spreadsheet (bool): Whether to enable spreadsheet mode.
#' @param spreadsheet_rows (integer): Number of spreadsheet rows.
#' @param spreadsheet_columns (integer): Number of spreadsheet columns.
#' @param spreadsheet_column_definition Column definition used for all columns in the sheet.
#' @param spreadsheet_sheets (list): List of sheet definitions.
#' @param spreadsheet_sheet_tabs (bool): Whether to show sheet tabs in the footer.
#' @param ... Further options.
#' @returns list with setup options to be used as `options` parameter in [tabulator()]
#' @seealso \url{https://tabulator.info/docs/6.2/options} for a complete list of available options
#' @example examples/tabulator_setup.R
#' @export
tabulator_options <- function(
    # General
    height = "311px",
    history = FALSE, # Must be TRUE in order to use 'undo' and 'redo'
    # Columns
    columns = NULL,
    layout = c("fitColumns", "fitData", "fitDataFill", "fitDataStretch", "fitDataTable"),
    responsive_layout = FALSE,
    movable_columns = FALSE,
    header_visible = TRUE,
    # Rows
    row_height = NULL,
    add_row_pos = c("bottom", "top"),
    movable_rows = FALSE,
    # TODO: Add movable rows params
    # ---
    # movable_rows_connected_tables = NULL,
    # movable_rows_receiver = NULL,
    # movable_rows_sender = NULL,
    # ---
    resizable_rows = FALSE,
    frozen_rows = NULL,
    # Data
    index = "id",
    # Row Grouping
    group_by = NULL,
    group_start_open = TRUE,
    group_toggle_element = NULL,
    # Editing
    edit_trigger_event = c("dblclick", "click", "focus"),
    # Selection
    selectable_rows = "highlight", # 'highlight', bool or integer
    # Pagination
    pagination = FALSE,
    pagination_size = 10,
    pagination_size_selector = FALSE,
    pagination_add_row = c("page", "table"),
    # Spreadsheet
    spreadsheet = FALSE,
    spreadsheet_rows = NULL,
    spreadsheet_columns = NULL,
    spreadsheet_column_definition = NULL,
    spreadsheet_sheets = NULL,
    spreadsheet_sheet_tabs = NULL,
    ...) {
  # Body
  params <- as.list(environment())
  params$layout <- match.arg(layout)
  params$add_row_pos <- match.arg(add_row_pos)
  params$edit_trigger_event <- match.arg(edit_trigger_event)
  params$pagination_add_row <- match.arg(pagination_add_row)
  return(c(params, list(...)))
}

default_spreadsheet_options <- list(
  row_header = list(
    field = "_id",
    hozAlign = "center",
    headerSort = FALSE,
    frozen = TRUE
  ),
  spreadsheet_column_definition = list(editor = "input")
)

#' Set pagination options
#' @inherit set_formatter_html params return
#' @inheritParams tabulator_options
#' @example examples/options/pagination_options.R
#' @export
set_options_pagination <- function(
    widget,
    pagination = TRUE,
    pagination_size = 10,
    pagination_size_selector = FALSE,
    pagination_add_row = c("page", "table"),
    ...) {
  # Body
  options_update <- list(
    pagination = pagination,
    paginationSize = pagination_size,
    paginationSizeSelector = pagination_size_selector,
    paginationAddRow = match.arg(pagination_add_row),
    ...
  )
  modify_tabulator_options(widget, options_update)
}

#' Set group by options
#' @inherit set_formatter_html params return
#' @inheritParams tabulator_options
#' @example examples/options/group_by_options.R
#' @export
set_options_group_by <- function(
    widget,
    group_by,
    group_start_open = TRUE,
    group_toggle_element = "header",
    ...) {
  # Body
  options_update <- list(
    groupBy = group_by,
    groupStartOpen = group_start_open,
    groupToggleElement = group_toggle_element,
    ...
  )
  modify_tabulator_options(widget, options_update)
}

modify_tabulator_options <- function(widget, options) {
  widget$x$options <- utils::modifyList(
    widget$x$options,
    keys_to_camel_case(compact(options))
  )
  return(widget)
}

# Column generics ####

modify_list <- function(x, y) {
  utils::modifyList(keys_to_camel_case(x), keys_to_camel_case(y))
}

# tabulator(iris) |> set_column_update("Species", list(hoz_align = "right"))
set_column_update <- function(widget, columns, col_update = NULL, ...) {
  modify_col_def(widget, columns, modify_list(col_update, list(...)))
}

# data.frame(x = c("green", "red"), y = 1:2) |> tabulator() |> set_column_formatter("x", "color")
set_column_formatter <- function(widget, columns, formatter, formatter_params = NULL, ...) {
  col_update <- list(
    formatter = formatter,
    formatterParams = formatter_params
  )
  set_column_update(widget, columns, col_update, ...)
}

# tabulator(iris) |> set_column_editor(c("Sepal_Length", "Sepal_Width"), "number", list(step = 0.1))
set_column_editor <- function(widget, columns, editor, editor_params = NULL, ...) {
  col_update <- list(
    editor = editor,
    editor_params = keys_to_camel_case(editor_params)
  )
  set_column_update(widget, columns, col_update, ...)
}

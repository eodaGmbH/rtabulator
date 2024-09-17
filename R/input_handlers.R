# https://book.javascript-for-r.com/shiny-complete.html
input_handler_data <- function(value, ...) {
  if (debug_mode()) {
    print("custom input handler data")
  }

  data <- value$data
  try(data <- tabulator_data_as_df(value$data))

  return(data)
}

# TODO: Not used at the moment
input_handler_sheet_data <- function(value, ...) {
  data <- value$data
  # try(jsonlite::fromJSON(jsonlite::toJSON(value, auto_unbox = TRUE)))
  return(data)
}

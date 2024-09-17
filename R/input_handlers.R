# https://book.javascript-for-r.com/shiny-complete.html
input_handler_data <- function(value, ...) {
  if (debug_mode()) {
    print("custom input handler data")
  }

  if (getOption("rtabulator.raw_data", FALSE)) {
    return(value)
  }

  data <- value$data
  try(data <- tabulator_data_as_df(value$data))
  return(data)
}

# TODO: Not used at the moment
input_handler_sheet_data <- function(value, ...) {
  if (debug_mode()) {
    print("custom input handler data")
  }

  if (getOption("rtabulator.raw_data", FALSE)) {
    return(value)
  }

  data <- value$data
  # try(data <- jsonlite::fromJSON(jsonlite::toJSON(value$data, auto_unbox = TRUE)))
  try(data <- sheet_data_to_matrix(data), silent = TRUE)
  return(data)
}

sheet_data_to_matrix <- function(data) {
  vec <- unlist(purrr::map(data, ~ as_vec(.x)))
  # try({vec <- as.numeric(vec)})
  return(matrix(vec, nrow = length(data), byrow = TRUE))
}

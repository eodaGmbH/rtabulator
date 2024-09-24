# https://book.javascript-for-r.com/shiny-complete.html
input_handler_data <- function(value, ...) {
  if (getOption("rtabulator.raw_data", FALSE)) {
    return(value)
  }

  data <- value$data
  try(data <- tabulator_data_as_df(value$data))
  return(data)
}

input_handler_sheet_data <- function(value, ...) {
  if (getOption("rtabulator.raw_data", FALSE)) {
    return(value)
  }

  data <- value$data
  try(data <- sheet_data_to_matrix(data), silent = TRUE)
  return(data)
}

sheet_data_to_matrix <- function(data) {
  vec <- unlist(purrr::map(data, ~ as_vec(.x)))
  return(matrix(vec, nrow = length(data), byrow = TRUE))
}

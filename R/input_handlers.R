# https://book.javascript-for-r.com/shiny-complete.html
input_handler_data <- function(data, ...) {
  return(tabulator_data_as_df(data))
}

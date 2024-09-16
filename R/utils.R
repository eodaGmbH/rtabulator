to_camel_case <- function(x) {
  gsub("_(\\w?)", "\\U\\1", x, perl = TRUE)
}

keys_to_camel_case <- function(x) {
  stats::setNames(x, to_camel_case(names(x)))
}

# Remove NULL values from list
compact <- function(x) {
  x[!sapply(x, is.null)]
}

#' Parse List to Data Frame
#' @param x (list): A list of named lists.
#' @export
list_to_data_frame <- function(x) {
  # jsonlite::toJSON(x, auto_unbox = TRUE) |> jsonlite::fromJSON()
  return(do.call(rbind.data.frame, x))
}

tabulator_data_as_data_frame <- function(data) {
  return(as.data.frame(purrr::map(data, ~ unlist(.x))))
}

# as.data.frame(purrr::map(input$data, ~ unlist(.x)))

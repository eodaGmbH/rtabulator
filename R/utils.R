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

#' Convert a list of names lists to data frame
#' @param x (list): A list of named lists.
#' @export
list_to_data_frame <- function(x) {
  # jsonlite::toJSON(x, auto_unbox = TRUE) |> jsonlite::fromJSON()
  return(do.call(rbind.data.frame, x))
}

#' Convert input data to data frame
#' @param data (list): The input data returned in a Shiny app.
#' @export
tabulator_data_as_df <- function(data) {
  return(as.data.frame(purrr::map(data, ~ unlist(.x))))
}


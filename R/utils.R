to_camel_case <- function(x) {
  gsub("_(\\w?)", "\\U\\1", x, perl = TRUE)
}

keys_to_camel_case <- function(x) {
  stats::setNames(x, to_camel_case(names(x)))
}

# Drop NULL values from list
compact <- function(x) {
  x[!sapply(x, is.null)]
}

# Convert list of named lists to data frame
list_to_data_frame <- function(x) {
  # jsonlite::toJSON(x, auto_unbox = TRUE) |> jsonlite::fromJSON()
  return(do.call(rbind.data.frame, x))
}

# Convert data returned from JavaScript ####

as_NA <- function(...) NA

as_vec <- function(l) {
  unlist(purrr::modify_if(l, is.null, as_NA))
}

tabulator_data_as_df <- function(data) {
  return(as.data.frame(purrr::map(data, ~ as_vec(.x))))
}

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

#' @export
list_to_data_frame <- function(x) {
  # jsonlite::toJSON(x, auto_unbox = TRUE) |> jsonlite::fromJSON()
  return(do.call(rbind.data.frame, x))
}

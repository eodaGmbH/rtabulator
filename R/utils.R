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

fix_colnames <- function(data) {
  colnames(data) <- sub("\\.", "_", colnames(data))
  data
}

create_columns <- function(data) {
  data <- fix_colnames(data)
  dtype_is_numeric <- sapply(data, is.numeric)
  purrr::map(
    colnames(data),
    ~ list(
      title = .x,
      field = .x,
      hozAlign = as.vector(ifelse(dtype_is_numeric[.x], "right", "left"))
    )
  )
}

# hozAlign = ifelse(is.numeric(.x), "right", "left")

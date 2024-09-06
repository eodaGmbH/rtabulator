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

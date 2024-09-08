fix_colnames <- function(data) {
  colnames(data) <- sub("\\.", "_", colnames(data))
  return(data)
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

set_auto_id <- function(data) {
  if ("id" %in% colnames(data)) {
    return(data)
  }

  data$id <- seq(1:nrow(data))
  return(data)
}

# TODO: Add possibility to select specific columns
add_editor_to_columns <- function(columns, data = NULL) {
  if (is.null(data)) {
    for (index in 1:length(columns)) {
      columns[[index]]$editor <- "input"
    }
    return(columns)
  }

  dtype_is_numeric <- sapply(data, is.numeric)
  for (index in 1:length(columns)) {
    columns[[index]]$editor <- as.vector(ifelse(dtype_is_numeric[index], "number", "input"))
  }

  return(columns)
}

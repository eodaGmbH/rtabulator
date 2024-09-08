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

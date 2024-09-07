add_editor_to_columns <- function(columns, choices = NULL, data = NULL) {
  for (index in 1:length(columns)) {
    columns[[index]]$editor = "input"
  }
  return(columns)
}

df <- data.frame(
  values = c(1, 2, 3),
  names = c("a", "b", "c")
)
tabulator(df) |>
  set_column_editor_input("names")

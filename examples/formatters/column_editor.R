data <- data.frame(
  age = c(10, 20, 40),
  first_name = c("Franz", "Ferdinand", "Julia"),
  last_name = c("Young", "Bowie", "Blackey")
)

tabulator(data, width = 500) |>
  set_column_editor(c("first_name", "last_name")) |>
  set_column_editor("age", type = "number")

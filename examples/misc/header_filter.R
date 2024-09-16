data <- data.frame(
  age = c(10, 20, 40),
  first_name = c("Franz", "Ferdinand", "Julia"),
  last_name = c("Young", "Bowie", "Blackey")
)

tabulator(data) |>
  set_header_filter("age", type = NULL, func = "<=", placeholder = "max age") |>
  set_header_filter("first_name", placeholder = "Fran") |>
  set_header_filter("last_name", type = "list")

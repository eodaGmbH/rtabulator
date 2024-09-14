data <- data.frame(
  age = c(10, 20, 40),
  first_name = c("Franz", "Ferdinand", "Julia"),
  last_name = c("Young", "Bowie", "Blackey")
)

tabulator(data) |>
  set_header_filter2("age", type = NULL ,func = "<=", placeholder = "max age") |>
  set_header_filter2("first_name", placeholder = "Fran") |>
  set_header_filter2("last_name", type = "li")
  # set_header_filter()

data <- data.frame(
  age = c(10, 20, 40),
  first_name = c("Franz", "Ferdinand", "Julia"),
  last_name = c("Young", "Bowie", "Blackey")
)

tabulator(data) |>
  set_header_filter()

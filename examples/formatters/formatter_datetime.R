data <- data.frame(
  Person = c("Franz", "Ferdinand"),
  Birthday = c(
    "2024-12-06 22:00:10",
    "2023-06-07 14:12:45"
  )
)

tabulator(data, luxon = TRUE) |>
  set_formatter_datetime("Birthday", output_format = "dd.MM.yyyy")

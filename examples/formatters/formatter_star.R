data <- data.frame(
  Passengers = c("Hans", "Franz", "Ferdinand", "Julia"),
  PassengerClass = c(1, 2, 1, 3)
)

tabulator(data, width = 200) |>
  set_columns("PassengerClass",
              formatter = formatter_star(number_of_stars = max(data$PassengerClass)))


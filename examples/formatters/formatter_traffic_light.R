data <- data.frame(
  label = 1:10,
  value = 1:10
)

tabulator(data, width = 200) |>
  set_columns("value", formatter = formatter_traffic_light())

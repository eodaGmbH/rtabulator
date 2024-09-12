data <- data.frame(
  label = 1:10,
  value = 1:10
)

tabulator(data, width = 200) |>
  set_formatter_traffic_light("value") |>
  set_formatter_plaintext("label", hoz_align = "center")

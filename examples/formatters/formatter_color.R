data <- data.frame(
  Label = c("R", "G", "B"),
  Color = c("red", "green", "blue")
)

tabulator(data, width = 200) |>
  set_columns(columns = "Color", formatter = formatter_color())

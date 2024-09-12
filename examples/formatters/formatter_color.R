data <- data.frame(
  Label = c("R", "G", "B"),
  Color = c("red", "green", "blue")
)

tabulator(data, width = 200) |>
  set_formatter_color("Color")

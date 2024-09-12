data <- data.frame(
  Language = c("R", "Python", "Julia"),
  Available = c("yes", "yes", "no")
)

tabulator(data) |>
  set_formatter_toggle_switch("Available", on_value = "yes", off_value = "no")

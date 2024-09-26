data <- data.frame(
  Language = c("R", "Python", "Julia"),
  Available = c("yes", "yes", "no")
)

tabulator(data) |>
  set_columns("Available",
    formatter = formatter_toggle_switch(on_value = "yes", off_value = "no")
  )

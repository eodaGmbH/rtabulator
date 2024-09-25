data <- data.frame(
  id = 1:6,
  value = c(10, 0, 100, 20, 40, 60),
  value2 = c(10, 0, 100, 20, 40, 60),
  value3 = c(10, 0, 100, 20, 40, 60)
)

js_func <- htmlwidgets::JS("(cellValue) => `${cellValue}%`")

tabulator(data) |>
  set_columns("value", formatter = formatter_progress())|>
  set_columns("value2", formatter = formatter_progress(legend = TRUE, legend_align = "left")) |>
  set_columns("value3", formatter = formatter_progress(legend = js_func, legend_align = "right"))

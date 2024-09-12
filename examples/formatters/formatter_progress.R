data <- data.frame(
  id = 1:6,
  value = c(10, 0, 100, 20, 40, 60),
  value2 = c(10, 0, 100, 20, 40, 60),
  value3 = c(10, 0, 100, 20, 40, 60)
)

js_func <- htmlwidgets::JS("(cellValue) => `${cellValue}%`")

tabulator(data, width = 300) |>
  set_formatter_progress("value") |>
  set_formatter_progress("value2", legend = TRUE, legend_align = "left") |>
  set_formatter_progress("value3", legend = js_func, legend_align = "right")

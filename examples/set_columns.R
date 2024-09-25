t <- tabulator(
  data.frame(
    numbers = c(1,11,3),
    text = c("How","are","you"),
    colors = c("red", "green", "blue"),
    progress = c(10,50,100),
    johncena = c("can't", "see", "me")))

t |>
  # set a title and formatter with default values
  set_columns("colors", title = "Colors", formatter = formatter_color()) |>
  # change horizontal alignment using hoz_align
  set_columns(c("numbers", "text"), hoz_align = "center") |>
  set_columns("johncena", visible = FALSE) |>
  # set formatter params in the formatter function
  set_columns("progress", formatter = formatter_progress(max = 50))|>
  # use the ... argument to add parameters that might be implemented in the JS library
  set_columns("numbers", sorter = "string")

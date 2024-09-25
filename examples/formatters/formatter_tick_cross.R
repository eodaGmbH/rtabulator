data <- data.frame(
  Artist = c("Art Blackey", "Nirvana", "Bob Marley"),
  Grunge = c(0, 1, 0),
  Jazz = c(1, 0, 0),
  Reggae = c(0, 0, 1)
)

tabulator(data, width = 400) |>
  set_columns("Grunge", formatter = formatter_tick_cross()) |>
  set_columns("Jazz", formatter = formatter_tick_cross()) |>
  set_columns("Reggae", formatter = formatter_tick_cross())

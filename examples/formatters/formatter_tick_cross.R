data <- data.frame(
  Artist = c("Art Blackey", "Nirvana", "Bob Marley"),
  Grunge = c(0, 1, 0),
  Jazz = c(1, 0, 0),
  Reggae = c(0,0,1)
)

tabulator(data, width = 400) |>
  set_formatter_tick_cross("Grunge") |>
  set_formatter_tick_cross("Jazz") |>
  set_formatter_tick_cross("Reggae")

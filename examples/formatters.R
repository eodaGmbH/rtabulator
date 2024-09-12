data_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"

tabulator(data_url) |>
  set_formatter_star("Pclass", number_of_stars = 3) |>
  set_formatter_tick_cross("Survived") |>
  set_formatter_progress("Fare", legend = TRUE)

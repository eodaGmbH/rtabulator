data_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"

tabulator(data_url) |>
  set_star_formatter("Pclass", number_of_stars = 3) |>
  set_tick_cross_formatter("Survived") |>
  set_progress_formatter("Fare", legend = TRUE)

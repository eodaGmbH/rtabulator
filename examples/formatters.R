tabulator("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv") |>
  set_star_formatter("Pclass", number_of_stars = 3) |>
  set_tick_cross_formatter("Survived")

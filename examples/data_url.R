data_url <- "https://raw.githubusercontent.com/eodaGmbH/rtabulator/main/data-raw/titanic.csv"

# tabulator(data_url)
tabulator(data_url, col_select = c("PassengerId", "Name", "Pclass", "Fare", "Survived")) |>
  set_formatter_star("Pclass") |>
  set_formatter_tick_cross("Survived") |>
  set_formatter_progress("Fare", legend = TRUE, legend_align = "left")

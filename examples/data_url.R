data_url <- "https://raw.githubusercontent.com/eodaGmbH/rtabulator/main/data-raw/titanic.csv"

tabulator(
  data_url,
  col_select = c("PassengerId", "Name", "Pclass", "Fare", "Survived"),
  pagination = T,
  column_calcs = "both"
) |>
  set_formatter_star("Pclass") |>
  set_formatter_tick_cross("Survived") |>
  set_formatter_progress("Fare", legend = TRUE, legend_align = "right", hoz_align = "right") |>
  set_calculation("Fare", func = "avg") |>
  set_calculation("Pclass", func = "unique", pos = "bottom")

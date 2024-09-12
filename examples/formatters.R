data_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"

tabulator(data_url) |>
  set_formatter_star("Pclass", number_of_stars = 3) |>
  set_formatter_tick_cross("Survived") |>
  set_formatter_progress("Fare", legend = TRUE)


# -----
sample_data <- data.frame(
  label = c("This is a link"),
  link = c("https://eoda.de"),
  link2 = c("eoda.de")
)

tabulator(sample_data) |>
  set_formatter_link("link", label_field = "label") |>
  set_formatter_link("link2", url_prefix = "https://")

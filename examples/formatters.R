data_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"

tabulator(data_url) |>
  set_star_formatter("Pclass", number_of_stars = 3) |>
  set_tick_cross_formatter("Survived") |>
  set_progress_formatter("Fare", legend = TRUE)


# -----
sample_data <- data.frame(
  label = c("This is a link"),
  link = c("https://eoda.de"),
  link2 = c("eoda.de")
)

tabulator(sample_data) |>
  set_link_formatter("link", label_field = "label") |>
  set_link_formatter("link2", url_prefix = "https://")

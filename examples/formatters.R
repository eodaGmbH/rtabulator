data_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"

tabulator(data_url) |>
  set_star_formatter("Pclass", number_of_stars = 3) |>
  set_tick_cross_formatter("Survived") |>
  set_progress_formatter("Fare", legend = TRUE)


# -----
sample_data <- data.frame(
  label = c("This is a link", "This is a link"),
  link = c("https://eoda.de", "https://eoda.de/data-science"),
  link2 = c("eoda.de", "eoda.de"),
  link3 = c("guinan", "data-science")
)

library(htmlwidgets)

tabulator(sample_data) |>
  set_link_formatter("link", label_field = "label") |>
  set_link_formatter("link2", url_prefix = "https://") |>
  set_link_formatter("link3", url = JS("function(cell) {return(`https://eoda.de/${cell.getValue()}`);}"), label_field = "label")

image_url <- "https://picsum.photos/"

image_data <- data.frame(
  image = c(88, 98),
  label = c("A pic", "Another pic")
)

tabulator(image_data) |>
  set_image_formatter("image", urlPrefix = image_url, urlSuffix = "", hoz_align = "left")

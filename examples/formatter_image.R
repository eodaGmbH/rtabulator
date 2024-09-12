image_url <- "https://picsum.photos/"

image_data <- data.frame(
  image = c(88, 98),
  label = c("A pic", "Another pic")
)

tabulator(image_data) |>
  set_formatter_image("image", url_prefix = image_url, hoz_align = "left")

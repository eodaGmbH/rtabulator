image_url <- "https://picsum.photos/id/"
image_size <- 100

image_data <- data.frame(
  image = c(88, 98, 102, 201),
  label = c("Pic No. 88", "Pic No. 98", "Pic No. 102", "Pic No 201")
)

tabulator(image_data, tabulator_options(height = "400px")) |>
  set_columns(
    columns = "image",
    formatter = formatter_image(
      height = image_size,
      width = image_size,
      url_prefix = image_url,
      url_suffix = glue::glue("/{image_size}")
    )
  )

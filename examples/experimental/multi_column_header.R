multi_columns <- list(
  Sepal = c("Sepal_Length", "Sepal_Width"),
  Petal = c("Petal_Length", "Petal_Width")
)

tabulator(iris) |>
  set_multi_column_header(multi_columns)

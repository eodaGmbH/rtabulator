numeric_cols <- c("Sepal_Length", "Sepal_Width", "Petal_Length", "Petal_Width")

tabulator(iris) |>
  for_each_col(numeric_cols, .f = set_header_filter, type = "number", func = "<=")

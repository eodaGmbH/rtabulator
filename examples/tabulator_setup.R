setup <- tabulator_options(
  group_by = "Species",
  pagination = TRUE,
  pagination_size = 10,
  pagination_size_selector = c(10, 20, 50),
  movable_columns = TRUE,
  movable_rows = TRUE
)
tabulator(iris, setup)

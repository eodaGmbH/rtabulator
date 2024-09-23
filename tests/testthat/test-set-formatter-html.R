test_that("set html formatter", {
  # Prepare
  col <- "html_value"
  df <- data.frame(
    x = c("<b>bold</b>")
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_formatter_html(column = col)

  # Assert
  expected_column_def <- list(
    field = "html_value",
    title = "html_value",
    formatter = "html",
    hozAlign = "left"
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
})

test_that("set columns", {
  t <- tabulator(
    data.frame(
      numbers = c(1, 11, 3),
      text = c("How", "are", "you"),
      colors = c("red", "green", "blue"),
      progress = c(10, 50, 100),
      johncena = c("can't", "see", "me")
    )
  )

  t <- t |>
    # set a title and formatter with default values
    set_columns("colors", title = "Colors", formatter = formatter_color())
  t$x$options$columns[[3]]
  expect_mapequal(
    t$x$options$columns[[3]],
    list(
      title = "Colors",
      field = "colors",
      hozAlign = "left",
      formatter = "color"
    )
  )
  t <- t |>
    # change horizontal alignment using hoz_align
    set_columns(c("numbers", "text"), hoz_align = "center")

  expected_vals <- list(
    list(title = "numbers", field = "numbers", hozAlign = "center"),
    list(title = "text", field = "text", hozAlign = "center")
  )
  actual_vals <- t$x$options$columns[c(1, 2)]
  expect_equal(actual_vals, expected_vals)
  t <- t |> set_columns("johncena", visible = FALSE) |>
    # set formatter params in the formatter function
    set_columns("progress", formatter = formatter_progress(min = 0, max = 50)) |>
    # use the ... argument to add parameters that might be implemented in the JS library
    set_columns("numbers", sorter = "string")

  actual_val <- t$x$options$columns
  expected_val <- list(
    list(title = "numbers", field = "numbers", hozAlign = "center", sorter = "string"),
    list(title = "text", field = "text", hozAlign = "center"),
    list(title = "Colors", field = "colors", hozAlign = "left", formatter = "color"),
    list(
      title = "progress", field = "progress", hozAlign = "left", formatter = "progress",
      formatterParams = list(
        min = 0, max = 50, color = c("yellow", "orange", "red"),
        legend = NA, legendColor = "#000000", legendAlign = "center"
      )
    ),
    list(title = "johncena", field = "johncena", hozAlign = "left", visible = FALSE)
  )

  expect_equal(actual_val, expected_val)

  # Assert

  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

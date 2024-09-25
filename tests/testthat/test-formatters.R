test_that("set html formatter", {
  # Prepare
  col <- "html_value"
  df <- data.frame(
    x = c("<b>bold</b>")
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(columns = col, formatter = formatter_html())

  # Assert
  expected_column_def <- list(
    field = "html_value",
    title = "html_value",
    formatter = "html",
    hozAlign = "left"
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})


test_that("set formatter plaintext", {
  # Prepare
  col <- "numeric_value"
  df <- data.frame(
    x = 1:10
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(columns = col, formatter = formatter_plaintext())

  # Assert
  expected_column_def <- list(
    field = "numeric_value",
    title = "numeric_value",
    formatter = "plaintext",
    hozAlign = "left"
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set formatter textarea", {
  # Prepare
  col <- "numeric_value"
  df <- data.frame(
    x = 1:10
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(columns = col, formatter = formatter_textarea())

  # Assert
  expected_column_def <- list(
    field = "numeric_value",
    title = "numeric_value",
    formatter = "textarea",
    hozAlign = "left"
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set formatter money", {
  # Prepare
  col <- "money_value"
  df <- data.frame(
    x = 1.27
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(column = col, formatter = formatter_money())

  # Assert
  expected_column_def <- list(
    title = "money_value",
    field = "money_value",
    hozAlign = "left",
    formatter = "money",
    formatterParams = list(
      decimal = ",",
      thousand = ".",
      symbol = "$ ",
      symbolAfter = "p",
      negativeSign = "-",
      precision = FALSE
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set formatter image", {
  skip_on_cran()
  # Prepare
  col <- "image"
  df <- data.frame(
    x = "https://picsum.photos/200/300"
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(column = col, formatter = formatter_image())

  # Assert
  expected_column_def <- list(
    title = "image",
    field = "image",
    hozAlign = "center",
    formatter = "image",
    formatterParams = list(
      height = "50px",
      width = "50px"
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set formatter link", {
  # Prepare
  col <- "link_value"
  df <- data.frame(
    x = "test@example.com"
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(columns = col, formatter = formatter_link())

  # Assert
  expected_column_def <- list(
    title = "link_value",
    field = "link_value",
    hozAlign = "left",
    formatter = "link",
    formatterParams = list(
      target = "_blank"
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set formatter star", {
  # Prepare
  col <- "star_value"
  df <- data.frame(
    x = c(1,2,3)
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(columns = col, formatter = formatter_star())

  # Assert
  expected_column_def <- list(
    title = "star_value",
    field = "star_value",
    hozAlign = "center",
    formatter = "star",
    formatterParams = list(
      stars = 3
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set formatter progress", {
  # Prepare
  col <- "progress_value"
  df <- data.frame(
    x = c(1,2,3)
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(columns = col, formatter = formatter_progress())

  # Assert
  expected_column_def <- list(
    title = "progress_value",
    field = "progress_value",
    hozAlign = "left",
    formatter = "progress",
    formatterParams = list(
      min = 1,
      max = 3,
      color = c("yellow", "orange", "red"),
      legend = NA,
      legendColor = "#000000",
      legendAlign = "center"
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set formatter tick cross", {
  # Prepare
  col <- "tick_value"
  df <- data.frame(
    x = c(T, F)
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(column = col, formatter = formatter_tick_cross())

  # Assert
  expected_column_def <- list(
    field = "tick_value",
    title = "tick_value",
    formatter = "tickCross",
    hozAlign = "center"
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set formatter toggle switch", {
  # Prepare
  col <- "toggle_val"
  df <- data.frame(
    x = c("on", "off")
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(column = col, formatter =
                  formatter_toggle_switch())

  # Assert
  expected_column_def <- list(
    title = "toggle_val",
    field = "toggle_val",
    hozAlign = "left",
    formatter = "toggle",
    formatterParams = list(
      size = 20,
      onValue = "on",
      offValue = "off",
      onTruthy = FALSE,
      onColor = "green",
      offColor = "red",
      clickable = TRUE
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})


test_that("set formatter datetime", {
  # Prepare
  col <- "date_val"
  df <- data.frame(
    x = c("2013-12-01 08:00:00")
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df, luxon = TRUE) |>
    set_columns(column = col, formatter = formatter_datetime())

  # Assert
  expected_column_def <- list(
    title = "date_val",
    field = "date_val",
    hozAlign = "left",
    formatter = "datetime",
    formatterParams = list(
      inputFormat = "yyyy-MM-dd hh:ss:mm",
      outputFormat = "yy/MM/dd",
      invalidPlaceholder = "(invalid datetime)",
      timezone = NA
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})


test_that("set formatter color", {
  # Prepare
  col <- "color_value"
  df <- data.frame(
    x = c("green", "#ff1312")
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(column = col, formatter = formatter_color())

  # Assert
  expected_column_def <- list(
    title = "color_value",
    field = "color_value",
    hozAlign = "left",
    formatter = "color"
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})


test_that("set formatter traffic light", {
  # Prepare
  col <- "traffic_value"
  df <- data.frame(
    x = c(0, 50, 100)
  ) |> stats::setNames(col)


  # Act
  t <- tabulator(df) |>
    set_columns(columns = col, formatter = formatter_traffic_light())

  # Assert
  expected_column_def <- list(
    title = "traffic_value",
    field = "traffic_value",
    hozAlign = "center",
    formatter = "traffic",
    formatterParams = list(
      min = 0,
      max = 100,
      color = c("green", "orange", "red")
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})


test_that("set editor input", {
  # Prepare
  col = "input_var"
  df <- data.frame(input_var = c("a","b","c"))


  # Act
  t <- tabulator(df) |>
    set_column_editor_input(col)

  # Assert
  expected_column_def <- list(
    title = "input_var",
    field = "input_var",
    hozAlign = "left",
    editor = "input",
    editorParams = list(
      search = TRUE,
      mask = "",
      selectContents = TRUE,
      elementAttributes = list(
        maxlength = 10
      )
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})

test_that("set editor area input", {
  # Prepare
  col = "input_var"
  df <- data.frame(input_var = c("a","b","c"))


  # Act
  t <- tabulator(df) |>
    set_column_editor_text_area(col)

  # Assert
  expected_column_def <- list(
    title = "input_var",
    field = "input_var",
    hozAlign = "left",
    editor = "textarea",
    editorParams = list(
      elementAttributes = list(
        maxlength = 10
      ),
      mask = "",
      selectContents = TRUE,
      verticalNavigation = "editor",
      shiftEnterSubmit = TRUE
    )
  )
  expect_mapequal(t$x$options$columns[[1]], expected_column_def)
  expect_s3_class(t, "rtabulator")
  expect_s3_class(t, "htmlwidget")
})



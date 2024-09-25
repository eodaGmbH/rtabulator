data <- data.frame(
  id = c(1, 2),
  txt = c(
    "This is text",
  )
)

tabulator(data, width = 200) |>
  set_columns(columns = "txt",
              formatter = formatter_plaintext())

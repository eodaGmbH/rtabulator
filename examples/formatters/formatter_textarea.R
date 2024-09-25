data <- data.frame(
  id = c(1, 2),
  txt = c(
    "This\nis\nsome\ntext\nwith\nmultiple\nline\nbreaks",
    "- R\n- Python\n- Julia"
  )
)

tabulator(data, width = 200) |>
  set_columns("txt", formatter = formatter_textarea())

data <- data.frame(
  id = c(1, 2, 3, 4, 5, 6, 7),
  text_style = c(
    "<i>Italic</i>",
    "<b>Bold</b>",
    "<span style='color: green'>Green</span>",
    "<del>Deleted</del>",
    "<small>Small</small>",
    "H<sub>2</sub>O",
    "x<sup>2</sup>"
  )
)

tabulator(data, width=200) |>
  set_formatter_html("text_style")

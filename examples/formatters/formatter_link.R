data <- data.frame(
  label = c("This is a link", "This is another link"),
  link = c("https://eoda.de", "https://eoda.de/data-science"),
  link2 = c("eoda.de", "github.com"),
  link3 = c("guinan", "data-science")
)

js_func <- "(cell) => `https://eoda.de/${cell.getValue()}`"

tabulator(data) |>
  set_formatter_link("link", label_field = "label") |>
  set_formatter_link("link2", url_prefix = "https://") |>
  set_formatter_link("link3", url = htmlwidgets::JS(js_func), label_field = "label")

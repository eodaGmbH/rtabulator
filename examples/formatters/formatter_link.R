data <- data.frame(
  label = c("This is a link", "This is another link"),
  link = c("https://eoda.de", "https://eoda.de/data-science"),
  link2 = c("eoda.de", "github.com"),
  link3 = c("posit-partner", "data-science")
)

js_func <- "(cell) => `https://eoda.de/${cell.getValue()}`"

tabulator(data) |>
  set_columns("link" , formatter= formatter_link(label_field = "label")) |>
  set_columns("link2", formatter= formatter_link(url_prefix = "https://"))|>
  set_columns("link3", formatter= formatter_link(url = htmlwidgets::JS(js_func),
                                                 label_field = "label"))

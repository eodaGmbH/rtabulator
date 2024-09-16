setup <- tabulator_options(edit_trigger_event = "click")

tabulator(iris[, c(2, 5)], setup) |>
  set_editor(
    column = "Species",
    editor = "list",
    values_lookup = "active",
    clearable = TRUE,
    autocomplete = TRUE
  ) |>
  set_editor(
    column = "Sepal_Width",
    editor = "number",
    min = 0,
    max = 10,
    step = 0.1,
    validator = c("min:0", "max:10")
  )

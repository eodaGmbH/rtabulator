library(shiny)

OUTPUT_ID <- "titanic"

data <- titanic(c("PassengerId", "Pclass", "Survived", "Fare"))
setup <- tabulator_options(
  selectable_rows = TRUE,
  edit_trigger_event = "focus"
)

ui <- fluidPage(
  titlePanel("Titanic Data"),
  tabulatorOutput(OUTPUT_ID),
  actionButton("download", "Download"),
  actionButton("submit", "Submit data to R")
)

server <- function(input, output) {
  output$titanic <- renderTabulator({
    tabulator(data, setup, editable = TRUE) |>
      set_header_filter("Pclass", "list") |>
      set_header_filter("Survived", "list") |>
      set_header_filter("Fare", "number", "<=", clearable = TRUE) |>
      set_options_pagination() |>
      set_formatter_money(
        "Fare",
        symbol = "\U00A3", symbol_after = FALSE, precision = 1, hoz_align = "right"
      ) |>
      set_tooltip("Fare") |>
      set_formatter_tick_cross("Survived") |>
      set_formatter_star("Pclass", number_of_stars = 3)
  })

  observeEvent(input$download, {
    tabulatorContext(OUTPUT_ID) |>
      trigger_download("csv")
  })

  observeEvent(input$titanic_row_clicked, {
    print(input$titanic_row_clicked)
  })

  observeEvent(input$titanic_rows_selected, {
    print("rows_selected")
    print(input$titanic_rows_selected)
  })

  observeEvent(input$titanic_cell_edited, {
    print("cell_edited")
    print(input$titanic_cell_edited)
  })

  observeEvent(input$titanic_data_filtered, {
    print("data_filtered")
    print(head(input$titanic_data_filtered))
  })

  observeEvent(input$submit, {
    print("Trigger get data")
    tabulatorContext(OUTPUT_ID) |>
      trigger_get_data()
  })

  observeEvent(input$titanic_data, {
    print("Got data. Thanx!")
    print(head(input$titanic_data))
  })
}

shinyApp(ui = ui, server = server)

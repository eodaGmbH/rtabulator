library(shiny)

TABULATOR_OUTPUT_ID <- "table"

ui <- fluidPage(
  titlePanel("Tabulator"),
  tabulatorOutput(TABULATOR_OUTPUT_ID),
  textOutput("row"),
  actionButton("download", "Download csv"),
  actionButton("delete", "Delete selected rows"),
  actionButton("add", "Add row"),
  actionButton("undo", "Undo"),
  actionButton("redo", "Redo")
)

options <- table_options(
  selectable_rows = TRUE,
  add_row_pos = "top",
  history = TRUE,
  columns = create_columns(iris) |> add_editor_to_columns()
)

server <- function(input, output) {
  output$table <- renderTabulator({
    tabulator(iris, options)
  })

  output$row <- renderText({
    print(input$table_row_clicked)
    input$table_row_clicked |>
      as.character() |>
      paste(collapse = ", ")
  })

  observeEvent(input$download, {
    print(input$download)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      trigger_download("csv", "data.csv") |>
      send_table_calls()
  })

  observeEvent(input$delete, {
    print(input$delete)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      delete_selected_rows() |>
      send_table_calls()
  })

  observeEvent(input$add, {
    print(input$add)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      add_row() |>
      send_table_calls()
  })

  observeEvent(input$undo, {
    print(input$undo)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      undo() |>
      send_table_calls()
  })

  observeEvent(input$redo, {
    print(input$redo)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      redo() |>
      send_table_calls()
  })
}

shinyApp(ui = ui, server = server)

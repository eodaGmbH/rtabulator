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
  actionButton("redo", "Redo"),
  actionButton("submit", "Submit data to R")
)

options <- tabulator_options(
  selectable_rows = TRUE,
  add_row_pos = "top",
  history = TRUE,
  columns = create_columns(iris, editor = TRUE, filter = TRUE)
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
      trigger_download("csv", "data.csv")
  })

  observeEvent(input$delete, {
    print(input$delete)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      delete_selected_rows()
  })

  # observeEvent(input$add, {
  #  print(input$add)
  #  tabulatorContext(TABULATOR_OUTPUT_ID) |>
  #    add_row()
  # })

  observe({
    print(input$add)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      add_row()
  }) |> bindEvent(input$add)

  observeEvent(input$undo, {
    print(input$undo)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      undo()
  })

  observeEvent(input$redo, {
    print(input$redo)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      redo()
  })

  observeEvent(input$submit, {
    print(input$submit)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      trigger_get_data()
  })

  observeEvent(input$table_data, {
    print(input$table_data)
  })
}

shinyApp(ui = ui, server = server)

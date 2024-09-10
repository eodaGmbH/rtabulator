library(shiny)

TABULATOR_OUTPUT_ID <- "spreadsheet"

ui <- fluidPage(
  titlePanel("Spreadsheet Data"),
  tabulatorOutput(TABULATOR_OUTPUT_ID),
  actionButton("submit", "Submit data to R")
)

server <- function(input, output) {
  output$spreadsheet <- renderTabulator({
    spreadsheet_data <- list(
      c(1, 2, 3),
      c(4, 5, 6)
    )
    tabulator(spreadsheet_data, tabulator_options(spreadsheet = TRUE))
  })

  observe({
    print(input$submit)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      trigger_get_spreadsheet_data()
  }) |> bindEvent(input$submit)


  observe({
    print(input$spreadsheet_spreadsheet_data)
  }) |> bindEvent(input$spreadsheet_spreadsheet_data)

}

shinyApp(ui = ui, server = server)

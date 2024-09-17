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
    # tabulator(spreadsheet_data, tabulator_options(spreadsheet = TRUE))
    tabulator(
      NULL,
      tabulator_options(
        spreadsheet = TRUE,
        spreadsheet_sheet_tabs = TRUE,
        spreadsheet_sheets = list(
          list(title = "First", data = spreadsheet_data),
          list(title = "Empty")
        )
      )
    )
  })

  observe({
    print(input$submit)
    tabulatorContext(TABULATOR_OUTPUT_ID) |>
      trigger_get_sheet_data() # |> trigger_get_data()
  }) |> bindEvent(input$submit)


  #observe({
  #  print("get_data")
  #  # print(head(input$spreadsheet_get_data) |> tibble::as_tibble())
  #}) |> bindEvent(input$spreadsheet_get_data)

  observe({
    print("get_sheet_data")
    print(input$spreadsheet_get_sheet_data)
  }) |> bindEvent(input$spreadsheet_get_sheet_data)
}

shinyApp(ui = ui, server = server)

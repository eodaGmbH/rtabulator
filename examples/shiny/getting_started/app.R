library(shiny)

ui <- fluidPage(
  titlePanel("Tabulator"),
  tabulatorOutput("table"),
  textOutput("row"),
  actionButton("download", "Download")
)

server <- function(input, output) {
  output$table <- renderTabulator({
    tabulator(iris, table_options())
  })

  output$row <- renderText({
    print(input$table_row_clicked)
    input$table_row_clicked$Sepal_Length
  })

  observeEvent(input$download, {
    print(input$download)
    tabulatorContext("table") |> trigger_download("csv", "data.csv") |> send_table_calls()
  })
}

shinyApp(ui = ui, server = server)

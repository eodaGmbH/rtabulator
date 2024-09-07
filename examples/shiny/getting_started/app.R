library(shiny)

ui <- fluidPage(
  titlePanel("Tabulator"),
  tabulatorOutput("table"),
  textOutput("row")
)

server <- function(input, output) {
  output$table <- renderTabulator({
    tabulator(iris, table_options())
  })

  output$row <- renderText({
    print(input$table_row_clicked)
    input$table_row_clicked$Sepal_Length
  })
}

shinyApp(ui = ui, server = server)

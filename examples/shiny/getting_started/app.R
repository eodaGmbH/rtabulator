library(shiny)

ui <- fluidPage(
  titlePanel("Tabulator"),
  tabulatorOutput("table")
)

server <- function(input, output) {
  output$table <- renderTabulator({
    tabulator(iris, table_options())
  })
}

shinyApp(ui = ui, server = server)

library(shiny)
library(rtabulator)

ui <- fluidPage(
  titlePanel("Titanic Data Set"),
  tabulatorOutput("titanic"),
  actionButton("submit", "Submit data to R")
)

server <- function(input, output) {
  output$titanic <- renderTabulator({
    tabulator(titanic(c("PassengerId", "Name", "Pclass", "Sex", "Fare", "Survived"))) |>
      set_formatter_progress("Fare") |>
      set_tooltip("Fare") |>
      set_formatter_tick_cross("Survived") |>
      set_formatter_star("Pclass", number_of_stars = 3)
  })

  observeEvent(input$submit, {
    print(input$submit)
    tabulatorContext("titanic") |>
      trigger_get_data()
  })

  observeEvent(input$titanic_get_data, {
    print(input$titanic_get_data)
    # print(head(tabulator_data_as_data_frame(input$titanic_get_data$data)))
    # print(list_to_data_frame(input$table_data$data))
  })
}

shinyApp(ui = ui, server = server)

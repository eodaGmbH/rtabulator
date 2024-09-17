library(shiny)

OUTPUT_ID <- "titanic"

data <- titanic(c("PassengerId", "Pclass", "Survived", "Fare"))
setup <- tabulator_options(selectable_rows = TRUE)

ui <- fluidPage(
  titlePanel("Titanic Data"),
  tabulatorOutput(OUTPUT_ID),
  actionButton("submit", "Submit data to R")
)

server <- function(input, output) {
  output$titanic <- renderTabulator({
    tabulator(data, setup, editable = TRUE) |>
      set_options_pagination() |>
      set_formatter_progress("Fare") |>
      set_tooltip("Fare") |>
      set_formatter_tick_cross("Survived") |>
      set_formatter_star("Pclass", number_of_stars = 3)
  })

  observeEvent(input$titanic_row_clicked, {
    print(input$titanic_row_clicked)
  })

  observeEvent(input$titanic_rows_selected, {
    print(input$titanic_rows_selected)
  })

  observeEvent(input$submit, {
    print("Trigger get data")
    tabulatorContext(OUTPUT_ID) |>
      trigger_get_data()
  })

  observeEvent(input$titanic_get_data, {
    print("Got data. Thanx!")
    print(head(input$titanic_get_data))
  })
}

shinyApp(ui = ui, server = server)

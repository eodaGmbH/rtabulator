library(shiny)
library(rtabulator)

ui <- fluidPage(
  titlePanel("Titanic Data Set"),
  tabulatorOutput("titanic")
)

server <- function(input, output) {
  output$titanic <- renderTabulator({
    tabulator(titanic()) |>
      set_formatter_progress("Fare") |>
      set_tooltip("Fare") |>
      set_formatter_tick_cross("Survived") |>
      set_formatter_star("Pclass", number_of_stars = 3)
  })
}

shinyApp(ui = ui, server = server)

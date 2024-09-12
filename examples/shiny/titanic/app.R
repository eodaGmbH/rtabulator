library(shiny)

data_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"

ui <- fluidPage(
  titlePanel("Titanic Data"),
  tabulatorOutput("titanic")
)

server <- function(input, output) {
  output$titanic <- renderTabulator({
    tabulator(data_url, editable = TRUE) |>
      set_formatter_progress("Fare") |>
      set_formatter_tick_cross("Survived") |>
      set_formatter_star("Pclass", number_of_stars = 3)
  })
}

shinyApp(ui = ui, server = server)

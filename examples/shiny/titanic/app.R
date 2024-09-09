library(shiny)

data_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"
titanic_tibble <- readr::read_csv(data_url)

ui <- fluidPage(
  titlePanel("Titanic Data"),
  tabulatorOutput("titanic")
)

server <- function(input, output) {
  output$titanic <- renderTabulator({
    tabulator(titanic_tibble, editable = TRUE) |>
      set_progress_formatter("Fare")
  })
}

shinyApp(ui = ui, server = server)

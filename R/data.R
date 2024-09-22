# Data ####

#' Titanic data set
#' @param col_select (character vector): Columns to select.
#' @returns data frame
#' @examples
#' \donttest{
#' titanic(c("PassengerId", "Age", "Pclass", "Fare")) |>
#'   head()
#' }
#'
#' @export
titanic <- function(col_select = NULL) {
  titanic_data_url <- "https://raw.githubusercontent.com/eodaGmbH/rtabulator/main/data-raw/titanic.csv"
  readr::read_csv(titanic_data_url, col_select = !!col_select, show_col_types = FALSE)
}

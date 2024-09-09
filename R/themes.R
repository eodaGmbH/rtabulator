read_tabulator_theme <- function(theme = c("midnight", "modern", "simple", "site")) {
  theme <- match.arg(theme)
  file_name <- system.file(
    glue::glue("htmlwidgets/libs/tabulator/tabulator_{theme}.min.css"),
    package = "rtabulator"
  )
  return(readr::read_file(file_name))
}

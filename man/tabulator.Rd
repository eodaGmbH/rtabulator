% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tabulator.R
\name{tabulator}
\alias{tabulator}
\title{HTML widget to work with tabular data}
\usage{
tabulator(
  data,
  options = tabulator_options(),
  editable = FALSE,
  luxon = FALSE,
  sheetjs = FALSE,
  theme = c("default", "midnight", "modern", "simple", "site", "bootstrap3",
    "bootstrap4", "bootstrap5", "bulma", "materialize", "semanticui"),
  col_select = NULL,
  width = NULL,
  height = NULL,
  element_id = NULL,
  ...
)
}
\arguments{
\item{data}{(data.frame, character or list): In spreadsheet mode data needs to be a list or \code{NULL}
for an empty spreadsheet.}

\item{options}{List of setup options. Defaults to \code{\link[=tabulator_options]{tabulator_options()}}.}

\item{editable}{Whether the table is editable.}

\item{luxon}{Whether to add \href{https://moment.github.io/luxon/}{luxon} HTML dependency,
which is required for \code{\link[=set_formatter_datetime]{set_formatter_datetime()}}.}

\item{sheetjs}{Whether to add \href{https://sheetjs.com/}{sheetjs} HTML dependency,
which is required for \code{\link[=trigger_download]{trigger_download()}} to support downloads of \code{xlsx} files.}

\item{theme}{Name of the theme to be applied to the table.}

\item{col_select}{Passed to \code{\link[readr:read_delim]{readr::read_csv()}} if \code{data} is a file name.}

\item{width, height}{Output size.}

\item{element_id}{Unique ID of the widget element.}

\item{...}{Named arguments that are appended to the \code{options} parameter.}
}
\value{
A HTML widget
}
\description{
HTML widget to work with tabular data
}
\details{
Dots in column names are replaced by underscores.
}
\examples{
setup <- tabulator_options(
  spreadsheet = TRUE,
  spreadsheet_sheets = list(
    spreadsheet_def(
      title = "First",
      data = list(c(1, 2, 3))
    ),
    spreadsheet_def(
      title = "Second",
      data = list(c(4, 5, 6))
    )
  ),
  spreadsheet_sheet_tabs = TRUE
)

tabulator(data = NULL, setup, theme = "midnight")
}
\seealso{
\code{\link[=tabulatorOutput]{tabulatorOutput()}} for use within Shiny apps
}

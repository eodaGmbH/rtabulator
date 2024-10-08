% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spreadsheet.R
\name{spreadsheet_def}
\alias{spreadsheet_def}
\title{Spreadsheet definition for \code{tabulator()} HTML widget}
\usage{
spreadsheet_def(title, key = NULL, data = NULL)
}
\arguments{
\item{title}{Name of the spreadsheet.}

\item{key}{Unique key of the spreadsheet.}

\item{data}{Initial data of the spreadsheet.
Set to \code{NULL} to create an empty spreadsheet.}
}
\value{
list with spreadsheet options to be used as a sheet of the
\code{spreadsheet_sheets} parameter in \code{\link[=tabulator_options]{tabulator_options()}}
}
\description{
Spreadsheet definition for \code{tabulator()} HTML widget
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


<!-- README.md is generated from README.Rmd. Please edit that file -->

# rtabulator

<!-- badges: start -->

[![R-CMD-check](https://github.com/eodaGmbH/rtabulator/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/eodaGmbH/rtabulator/actions/workflows/R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/rtabulator)](https://CRAN.R-project.org/package=rtabulator)
[![Tabulator](https://img.shields.io/badge/Tabulator-v6.2.5-blue.svg)](https://github.com/olifolkerd/tabulator/releases/tag/6.2.5)
<!-- badges: end -->

The goal of rtabulator is to make it a breeze creating beautiful and
interactive tables in markdown documents and Shiny application using
[Tabulator JS](https://tabulator.info/).

## Features

- Filtering
- Grouping
- Editing
- Input validation
- History with undo and redo actions
- Pagination
- Layout
- Column formatters
- Column calculations
- Multi column headers
- Packaged themes
- Spreadsheets supporting multiple sheets
- Download data
- Freeze data

## Installation

Once on CRAN you can install rtabulator with:

``` r
install.packages("rtabulator")
```

You can install the development version of rtabulator like so:

``` r
remotes::install_github("eodaGmbH/rtabulator")
```

## Basic Usage

``` r
library(rtabulator)

tabulator(mtcars)

# Set theme
tabulator(iris, theme = "midnight")

# Format columns
tabulator(airquality) |>
  set_formatter_progress(
    column = "Temp",
    legend = TRUE,
    legend_align = "left"
  )

# Spreadsheet mode
tabulator(data = list(), spreadsheet = TRUE)
```

## Documentation

[rtabulator docs](https://eodagmbh.github.io/rtabulator/)

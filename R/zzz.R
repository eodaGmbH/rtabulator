.onLoad <- function(libname, pkgname) {
  # For devtools::load_all() we need to remove to handler if it is already registered
  try(shiny::removeInputHandler("rtabulator.data"), silent = FALSE)
  try(shiny::removeInputHandler("rtabulator.sheet_data"), silent = FALSE)

  try(shiny::registerInputHandler("rtabulator.data", input_handler_data))
  try(shiny::registerInputHandler("rtabulator.sheet_data", input_handler_sheet_data))
}

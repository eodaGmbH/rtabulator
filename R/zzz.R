.onLoad <- function(libname, pkgname) {
  # For devtools::load_all() we need to remove to handler if it is already registered
  try(shiny::removeInputHandler("rtabulator.data"), silent = TRUE)

  try(shiny::registerInputHandler("rtabulator.data", input_handler_data))
}

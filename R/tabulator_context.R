is_tabulatorContext <- function(widget) {
  return(!is.null(widget$session))
}

invoke_method <- function(widget, method_name, ...) {
  index <- length(widget$x$calls) + 1
  args <- list(...)
  call <- list(method_name, args)
  widget$x$calls[[index]] <- call
  if (is_tabulatorContext(widget) && isFALSE(getOption("rtabulator.message_queque", FALSE))) {
    send_tabulator_calls(widget)
  }

  invisible(widget)
}

#' Create a tabulator context object
#'
#' @details
#' A \code{tabulatorContext} object makes it possible to update your widget in a Shiny application.
#' @param output_id (character): A tabulator output id.
#' @param session A shiny session object.
#' @export
tabulatorContext <- function(output_id, session = shiny::getDefaultReactiveDomain()) {
  ctx <- list(
    id = output_id,
    session = session,
    x = list(calls = list())
  )
  return(ctx)
}

send_tabulator_calls <- function(ctx) {
  handler_name <- glue::glue("tabulator-{id}", id = ctx$id)
  print(handler_name)
  payload <- list(
    id = ctx$id,
    calls = ctx$x$calls
  )
  ctx$session$sendCustomMessage(handler_name, payload)
  invisible(ctx)
}

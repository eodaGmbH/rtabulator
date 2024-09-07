invoke_method <- function(widget, method_name, ...) {
  index <- length(widget$x$calls) + 1
  args <- list(...)
  call <- list(method_name, args)
  widget$x$calls[[index]] <- call
  return(widget)
}

tabulatorContext <- function(output_id, session = shiny::getDefaultReactiveDomain()) {
  ctx <- list(
    id = output_id,
    session = session,
    x = list(calls = list())
  )
  return(ctx)
}

send_table_calls <- function(ctx) {
  handler_name <- glue::glue("tabulator-{id}", id = ctx$id)
  print(handler_name)
  payload <- list(
    id = ctx$id,
    calls = ctx$x$calls
  )
  ctx$session$sendCustomMessage(handler_name, payload)
}

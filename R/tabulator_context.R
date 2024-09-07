trigger_download <- function(ctx, type, file_name) {
  invoke_method(ctx, "download", type, file_name)
}

invoke_method <- function(widget, method_name, ...) {
  index <- length(widget$x$calls) + 1
  widget$x$calls[[index]] <- list(method_name, list(...))
  return(widget)
}

tabulatorContext <- function(output_id, session = shiny::getDefaultReactiveDomain()) {
  #if (!is.null(session$ns) &&
  #    nzchar(session$ns(NULL)) &&
  #    substring(tabulator_id, 1, nchar(session$ns(""))) != session$ns("")) {
  #  tabulator_id <- session$ns(tabulator_id)
  #}

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

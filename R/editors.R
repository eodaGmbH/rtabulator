#' The input editor allows entering of a single line of plain text
#'
#' @param widget A [tabulator()] HTML widget.
#' @param column The name of the column the formatter is applied to.
#' @param search Use search type input element with clear button
#' @param mask Apply a mask to the input to allow characters to be entered only in a certain order
#' @param select_contents When the editor is loaded select its text content
#' @param elementAttributes Set attributes directly on the input element
#'
#' @return The updated [tabulator()] HTML widget
#' @export
#'
#' @examples examples/editors/editor_input
set_column_editor_input <- function(widget,
                                    columns,
                                    search = TRUE,
                                    mask = "AAA-999",
                                    select_contents = TRUE,
                                    elementAttributes = list(
                                      maxlength = 10
                                    )){
  editor = "input"
  editorParams = list(
    search = search,
    mask = mask,
    selectContents = select_contents,
    elementAttributes = elementAttributes
  )

  set_column_editor(widget, columns, editor, editorParams)
}



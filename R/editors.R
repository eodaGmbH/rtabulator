#' The \strong{input} editor allows entering of a single line of plain text
#'
#' @param widget A [tabulator()] HTML widget.
#' @param columns The name of the column the formatter is applied to.
#' @param search Use search type input element with clear button
#' @param mask Apply a mask to the input to allow characters to be entered only in a certain order
#' @param select_contents When the editor is loaded select its text content
#' @param elementAttributes Set attributes directly on the input element
#'
#' @return The updated [tabulator()] HTML widget
#' @export
#'
#' @example examples/editors/editor_input.R
set_column_editor_input <- function(widget,
                                    columns,
                                    search = TRUE,
                                    mask = "",
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

#' The \strong{textarea} editor allows entering of multiple lines of plain text
#' @inherit set_column_editor_input params return
#' @param elementAttributes Set attributes directly on the textarea element
#' @param mask Apply a mask to the input to allow characters to be entered only in a certain order
#' @param select_contents When the editor is loaded select its text content
#' @param vertical_navigation Determine how use of the up/down arrow keys will affect the editor,
#' this can take three different types of value: *hybrid*, *editor* and *table*
#' @param shift_enter_submit Submit the cell value when the shift and enter keys are pressed
#'
#' @export
#'
set_column_editor_text_area <- function(widget,
                                        columns,
                                        elementAttributes = list(
                                          maxlength = 10
                                        ),
                                        mask = "",
                                        select_contents = TRUE,
                                        vertical_navigation = "editor",
                                        shift_enter_submit = TRUE
){
  editor = "textarea"
  editorParams = list(
    elementAttributes = elementAttributes,
    mask = mask,
    selectContents = select_contents,
    verticalNavigation = vertical_navigation,
    shiftEnterSubmit = shift_enter_submit
  )

  set_column_editor(widget, columns, editor, editorParams)
}

#' The \strong{numeric}  editor allows for numeric entry with a number type input element with increment and decrement buttons.
#' @inherit set_column_editor_input params return
#' @param min the maximum allowed value
#' @param max the minimum allowed value
#' @param step the step size when incrementing/decrementing the value (default 1)
#' @param elementAttributes Set attributes directly on the element
#' @param mask Apply a mask to the input to allow characters to be entered only in a certain order
#' @param select_contents When the editor is loaded select its text content
#' @param vertical_navigation determine how use of the up/down arrow keys will affect the editor,
#' this can take two different types of value: : *editor* and *table*
#' @export
#'
set_column_editor_numeric <- function(widget,
                                        columns,
                                        min = 0,
                                        max = 100,
                                        step = 1,
                                        elementAttributes = list(
                                          maxlength = 10
                                        ),
                                        mask = "",
                                        select_contents = TRUE,
                                        vertical_navigation = "table"
){
  editor = "number"
  editorParams = list(
    min = min,
    max = max,
    elementAttributes = elementAttributes,
    mask = mask,
    selectContents = select_contents,
    verticalNavigation = vertical_navigation
  )

  set_column_editor(widget, columns, editor, editorParams)
}



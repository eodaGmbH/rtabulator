SHEETJS_VERSION <- "0.20.1"

# Needed to support xlsx downloads
sheetjs_dependency <- htmltools::htmlDependency(
  name = "sheetjs",
  version = SHEETJS_VERSION,
  src = list(
    href = glue::glue("https://cdn.sheetjs.com/xlsx-{SHEETJS_VERSION}/package/dist/")
  ),
  script = "xlsx.mini.min.js",
  all_files = FALSE
)

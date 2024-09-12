SHEETJS_VERSION <- "0.20.1"
LUXON_VERSION <- "3.5.0"

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

# Needed for datetime formatter
luxon_dependency <- htmltools::htmlDependency(
  name = "luxon",
  version = LUXON_VERSION,
  src = list(
    href = glue::glue("https://cdn.jsdelivr.net/npm/luxon@{LUXON_VERSION}/build/global/")
  ),
  script = "luxon.min.js",
  all_files = FALSE
)

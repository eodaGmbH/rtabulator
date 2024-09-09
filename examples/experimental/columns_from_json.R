columns_json <- '[
  {"title": "PassengerId", "field": "PassengerId"}
]'

columns <- jsonlite::fromJSON(columns_json, simplifyDataFrame = FALSE)

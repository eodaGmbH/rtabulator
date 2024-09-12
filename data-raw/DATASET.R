## code to prepare `DATASET` dataset goes here

url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"
download.file(url, "data-raw/titanic.csv")

# usethis::use_data(DATASET, overwrite = TRUE)

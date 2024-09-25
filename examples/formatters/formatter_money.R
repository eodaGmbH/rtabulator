data <- data.frame(
  Account_Number = c(
    123456,
    345667,
    234567,
    234566
  ),
  Account_Balance = c(100, -50, 200.30, -21.5)
)

tabulator(data) |>
  set_columns(
    "Account_Balance",
    formatter = formatter_money(
      symbol = " \U20AC",
      symbol_after = TRUE
    )
  )

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
  set_formatter_money(
    "Account_Balance",
    symbol = "\U20AC",
    symbol_after = FALSE,
    hoz_align = "right"
  )

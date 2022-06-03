install.packages("ggchicklet", repos = "https://cinc.rud.is")
library("ggchicklet")

df_covid19_100_wide |>
  filter(is.na(location))

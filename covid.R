if(!require(readr)) {
  install.packages('readr')
  library(readr)
}

if(!require(lubridate)) {
  install.packages('lubridate')
  library(lubridate)
}

if(!require(tidyverse)) {
  install.packages('tidyverse')
  library(tidyverse)
}

library(readr)
library(lubridate)
library(tidyverse)

## covid19 데이터 로딩(온라인에서 바로 로딩할 경우)
df_covid19 <- read_csv(file = "https://covid.ourworldindata.org/data/owid-covid-data.csv",
                       col_types = cols(Date = col_date(format = "%Y-%m-%d")
                       )
)

df_covid19_test <- df_covid19 |> filter(iso_code == 'KOR', date >= as.Date('2022-01-01')) |>
  select(date, new_cases)


covid19.ts<-ts(df_covid19_test[,2], frequency = 365)

library(xts)
covid19.xts<-as.xts(df_covid19_test[,2], order.by = df_covid19_test$date)

library(tsibble)
covid19.tsibble<-as_tsibble(df_covid19_test, index = date)

library(forecast)

covid19.ts %>% nnetar() %>% forecast(h=60, PI = TRUE) %>%
  autoplot()+labs(title='코로나 확진자에 대한 신경망 모델 예측 결과', x='연도', y='확진자수')


library(prophet)

covid19.prophet<-data.frame(ds=df_covid19_test$date, y=df_covid19_test$new_cases)

model.covid19.prophet <- prophet::prophet(covid19.prophet, yearly.seasonality=TRUE, daily.seasonality=TRUE, weekly.seasonality=TRUE)
future.covid19.prophet <- make_future_dataframe(model.covid19.prophet, periods = 60, freq = 'day')

forecast.covid19.prophet <- predict(model.covid19.prophet, future.covid19.prophet)

plot(model.covid19.prophet, forecast.covid19.prophet)

split<-floor(nrow(covid19.tsibble)*0.95)
n <- nrow(covid19.tsibble)
covid19.tsibble.tr<-covid19.tsibble[1:split,]
covid19.tsibble.test<-covid19.tsibble[(split+1):n,]


library(fable)
library(fable.prophet)

model.covid19.fable <- covid19.tsibble.tr %>%
  model(ets = ETS(new_cases),
        arima = ARIMA(new_cases),
        naive = NAIVE(new_cases),
        tslm = TSLM(new_cases),
        rw = RW(new_cases),
        mean = MEAN(new_cases),
        nnetar = NNETAR(new_cases),
        prophet = prophet(new_cases)
  )

forecast.covid19.fable <- model.covid19.fable %>%
  forecast(h = 60)

forecast.covid19.fable |> autoplot(covid19.tsibble, level = NULL)

forecast.covid19.fable |> accuracy(covid19.tsibble.test) |> arrange(RMSE)

best.model.covid19.fable <- model.covid19.fable |> select(ets)

best.model.covid19.fable |> forecast(h = 60) |>
  autoplot(covid19.tsibble) +
  autolayer(fitted(best.model.covid19.fable))

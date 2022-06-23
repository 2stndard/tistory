library(MASS)
library(tidyverse)

x <- read.csv('clipboard', sep = '\t')

data <- x |> group_by(실험군) |>
  summarise_at(vars(starts_with('X')), mean) |>
  pivot_longer(-1, names_to = '회차', values_to = '측정값') |>
  pivot_wider(names_from = 실험군, values_from = 측정값) |>
  setNames(c('회차', 'before', 'after'))
  

shapiro.test(data$after)


wilcox.test(data$before, data$after, conf.int = TRUE, conf.level = 0.95, paired = TRUE)


t.test(data$before, data$after, conf.int = FALSE, conf.level = 0.95, paired = TRUE)

library(DescTools)
HodgesLehmann(data$before, data$after, conf.level = 0.95)


colname <- colnames(x)

time <- as.numeric(gsub('X', '', colname))[-c(1:4)]

car::dwt(car::durbinWatsonTest(lm(data$before ~ time)))

car::dwt(lm(data$before ~ time))

library(forecast)

x1 <- residuals(auto.arima(data$before))
x2 <- residuals(auto.arima(data$after))

shapiro.test(x1)
shapiro.test(x2)
qqnorm(x1)

wilcox.test(x1, x2)

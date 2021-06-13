library(readxl)
library(tidyverse)
library(lubridate)
library(zoo)
library(xts)
library(tsibble)
students.all <- read_excel("D:/R/Github/concept-of-time-series/students.xlsx", skip = 16, na = '-', sheet = 1, col_types
                           = c('text', 'text', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric','numeric', 'numeric', 'numeric'))

students <- students.all %>%
  filter(지역규모 == '계') %>% select(-지역규모)

head(students)

students$연도 <- as.Date(paste0(students$연도, '-01-01'))

students.ts <- ts(students, frequency = 1, start = 1999)

students.xts <- as.xts(students[,-1], order.by = students$연도)

students.tsibble <- students %>%
  mutate(연도 = yearmonth(paste0(students$연도, '-01-01')))

students.tsibble <- as_tsibble(students.tsibble, index = 연도)
?as_tsibble

###  2.3.2 CSV 파일

employees <- read.csv('D:/R/Github/concept-of-time-series/산업별_취업자_20210206234505.csv', header = TRUE, na = '-', strip.white = TRUE, stringsAsFactors = TRUE)

colnames(employees) <- c('time', 'total', 'employees.edu')

employees$time <- as.Date(paste0(employees$time, '. 01'), format = '%Y. %m. %d')

employees.ts <- ts(employees, start = c(2013, 01), frequency = 12)

employees.xts <- xts(employees[,2:3], order.by = employees[,1])

employees.tsibble <- as_tsibble(employees, index = time)




library(bsts)


students.ss <- AddLocalLinearTrend(list(), students.xts[, 1])
##students.ss <- AddSeasonal(students.ss, students.xts[, 1], nseasons = 1)
students.bayesian.model <- bsts(students.xts[, 1],
                                state.specification = students.ss,
                                niter = 1000)

students.burn <- SuggestBurn(0.1, students.bayesian.model)

students.horizon.pred <- 5

students.bayesian.pred <- predict.bsts(students.bayesian.model, 
                                       horizon = students.horizon.pred, 
                                       burn = students.burn, 
                                       quantiles = c(.025, .975))


students.bayesian.df <- data.frame(
  # fitted values and predictions
  c(time(students.xts[, 1]), seq(max(time(students.xts[, 1])) + years(1), by = 'years', length.out = students.horizon.pred)),
  c(as.numeric(students.xts[, 1]), rep(NA, students.horizon.pred)),
  c(as.numeric(-colMeans(students.bayesian.model$one.step.prediction.errors[-(1:burn),])+students.xts[, 1]),  
    as.numeric(students.bayesian.pred$mean))
)


names(students.bayesian.df) <- c('Date', 'Actual', "Fitted")

MAPE <- students.bayesian.df %>% 
  filter(is.na(Actual) == F) %>% 
  summarise(MAPE=mean(abs(Actual-Fitted)/Actual))


students.bayesian.posterior.interval <- data.frame(
  filter(students.bayesian.df, is.na(Actual) == T)[, 1],
  students.bayesian.pred$interval[1,],
  students.bayesian.pred$interval[2,]
)

names(students.bayesian.posterior.interval) <- c("Date", "LL", "UL")

students.bayesian.df.pred <- left_join(students.bayesian.df, students.bayesian.posterior.interval, by="Date")

students.bayesian.df.pred %>% 
  ggplot(aes(x=Date)) +
  geom_line(aes(y=Actual, colour = "Actual"), size=1.2) +
  geom_line(aes(y=Fitted, colour = "Fitted"), size=1.2, linetype=2) +
  theme_bw() + theme(legend.title = element_blank()) + ylab("") + xlab("") +
  geom_vline(xintercept=as.numeric(as.Date("2020-01-01")), linetype=2) + 
  geom_ribbon(aes(ymin=LL, ymax=UL), fill="grey", alpha=0.5) +
  ggtitle(paste0("BSTS -- Holdout MAPE = ", round(100*MAPE,2), "%")) +
  theme(axis.text.x=element_text(angle = -90, hjust = 0))

######### employees

employees.ss <- AddLocalLinearTrend(list(), employees$total)
employees.ss <- AddSeasonal(employees.ss, employees$total, nseasons = 12)
employees.bayesian.model <- bsts(employees$total,
                                state.specification = employees.ss,
                                niter = 1000)

employees.burn <- SuggestBurn(0.1, employees.bayesian.model)

employees.horizon.pred <- 12

employees.bayesian.pred <- predict.bsts(employees.bayesian.model, 
                                       horizon = employees.horizon.pred, 
                                       burn = employees.burn, 
                                       quantiles = c(.025, .975))


employees.bayesian.df <- data.frame(
  c(employees$time, seq(max(employees$time) + months(1), by = 'month', length.out = employees.horizon.pred)),
  c(as.numeric(employees$total), rep(NA, employees.horizon.pred)),
  c(as.numeric(-colMeans(employees.bayesian.model$one.step.prediction.errors[-(1:burn),])+employees$total),  
    as.numeric(employees.bayesian.pred$mean))
)


names(employees.bayesian.df) <- c('Date', 'Actual', "Fitted")

MAPE <- employees.bayesian.df %>% 
  filter(is.na(Actual) == F) %>% 
  summarise(MAPE=mean(abs(Actual-Fitted)/Actual))


employees.bayesian.posterior.interval <- data.frame(
  filter(employees.bayesian.df, is.na(Actual) == T)[, 1],
  employees.bayesian.pred$interval[1,],
  employees.bayesian.pred$interval[2,]
)

names(employees.bayesian.posterior.interval) <- c("Date", "LL", "UL")

employees.bayesian.df.pred <- left_join(employees.bayesian.df, employees.bayesian.posterior.interval, by="Date")

employees.bayesian.df.pred %>% 
  ggplot(aes(x=Date)) +
  geom_line(aes(y=Actual, colour = "Actual"), size=1.2) +
  geom_line(aes(y=Fitted, colour = "Fitted"), size=1.2, linetype=2) +
  theme_bw() + theme(legend.title = element_blank()) + ylab("") + xlab("") +
  geom_vline(xintercept=as.numeric(as.Date("2021-01-01")), linetype=2) + 
  geom_ribbon(aes(ymin=LL, ymax=UL), fill="grey", alpha=0.5) +
  ggtitle(paste0("BSTS -- Holdout MAPE = ", round(100*MAPE,2), "%")) +
  theme(axis.text.x=element_text(angle = -90, hjust = 0))








View(students.bayesian.model$one.step.prediction.errors[-(1:burn),])


-colMeans(students.bayesian.model$one.step.prediction.errors[-(1:burn),]) + students.xts[, 1]


glimpse(students.bayesian.model$one.step.prediction.errors[-(1:burn),])


c(as.numeric(-colMeans(students.bayesian.model$one.step.prediction.errors[-(1:burn),])+students.xts[, 1]),  
  as.numeric(students.bayesian.pred$mean))

,
  # actual data and dates 
  as.numeric(students.xts[, 1]),
  as.Date(time(students.xts[, 1])) + 0:5

seq(max(time(students.xts[, 1])) + years(1), by = 'years', length.out = 5)
max(time(students.xts[, 1]))

?seq.Date()    
names(d2) <- c("Fitted", "Actual", "Date")

plot(students.bayesian.model)
plot(students.bayesian.model, "components")  # plot(model1, "comp") works too!

students.bayesian.pred <- predict(students.bayesian.model, horizon = 3)
plot(students.bayesian.pred)
plot(students.bayesian.model, burn = 100)
plot(students.bayesian.model, "residuals", burn = 100)
plot(students.bayesian.model, "components", burn = 100)
plot(students.bayesian.model, "forecast.distribution", burn = 100)



employees.ss <- AddLocalLinearTrend(list(), employees.xts[, 1])
employees.ss <- AddSeasonal(employees.ss, employees.xts[, 1], nseasons = 12)
employees.ss <- AddSeasonal(employees.ss, employees.xts[, 1], nseasons = 4)

employees.bayesian.model <- bsts(employees.xts[, 1],
                                 state.specification = employees.ss,
                                 niter = 1000)

plot(employees.bayesian.model)
plot(employees.bayesian.model, "components")  # plot(model1, "comp") works too!

employees.bayesian.pred <- predict(employees.bayesian.model, horizon = 12)
plot(employees.bayesian.pred)
plot(employees.bayesian.model, burn = 100)
plot(employees.bayesian.model, "residuals", burn = 100)
plot(employees.bayesian.model, "components", burn = 100)
plot(employees.bayesian.model, "forecast.distribution", burn = 100)


covid19.ss <- AddLocalLinearTrend(list(), covid19.xts[, 1])
covid19.ss <- AddSeasonal(covid19.ss, covid19.xts[, 1], nseasons = 52, season.duration = 7)
covid19.bayesian.model <- bsts(covid19.xts[, 1],
                               state.specification = covid19.ss,
                               niter = 100)
plot(covid19.xts[, 1])

plot(covid19.bayesian.model)
plot(covid19.bayesian.model, "components")  # plot(model1, "comp") works too!

covid19.bayesian.pred <- predict(covid19.bayesian.model, horizon = 30)
plot(pred1)



class(AirPassengers)
data("AirPassengers")
Y <- window(AirPassengers, start=c(1949, 1), end=c(1959,12))
y <- log10(Y)

ss <- AddLocalLinearTrend(list(), y)
ss <- AddSeasonal(ss, y, nseasons = 12)
bsts.model <- bsts(y, state.specification = ss, niter = 500, ping=0, seed=2016)
View(bsts.model)
### Get a suggested number of burn-ins
burn <- SuggestBurn(0.1, bsts.model)

p <- predict.bsts(bsts.model, horizon = 12, burn = burn, quantiles = c(.025, .975))

d2 <- data.frame(
  # fitted values and predictions
  c(10^as.numeric(-colMeans(bsts.model$one.step.prediction.errors[-(1:burn),])+y),  
    10^as.numeric(p$mean)),
  # actual data and dates 
  as.numeric(AirPassengers),
  as.Date(time(AirPassengers)))
names(d2) <- c("Fitted", "Actual", "Date")

MAPE <- filter(d2, year(Date)>1959) %>% summarise(MAPE=mean(abs(Actual-Fitted)/Actual))

posterior.interval <- data.frame(
  10^as.numeric(p$interval[1,]),
  10^as.numeric(p$interval[2,]), 
  subset(d2, year(Date)>1959)$Date)

names(posterior.interval) <- c("LL", "UL", "Date")

d3 <- left_join(d2, posterior.interval, by="Date")

ggplot(data=d3, aes(x=Date)) +
  geom_line(aes(y=Actual, colour = "Actual"), size=1.2) +
  geom_line(aes(y=Fitted, colour = "Fitted"), size=1.2, linetype=2) +
  theme_bw() + theme(legend.title = element_blank()) + ylab("") + xlab("") +
  geom_vline(xintercept=as.numeric(as.Date("1959-12-01")), linetype=2) + 
  geom_ribbon(aes(ymin=LL, ymax=UL), fill="grey", alpha=0.5) +
  ggtitle(paste0("BSTS -- Holdout MAPE = ", round(100*MAPE,2), "%")) +
  theme(axis.text.x=element_text(angle = -90, hjust = 0))

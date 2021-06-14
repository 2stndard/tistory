library(readxl)
library(tidyverse)
library(lubridate)


students.all <- read_excel("D:/R/Github/concept-of-time-series/students.xlsx", skip = 16, na = '-', sheet = 1, col_types = c('text', 'text', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric','numeric', 'numeric', 'numeric'))

students <- students.all %>%
  filter(지역규모 == '계') %>% select(-지역규모)

head(students)

students$연도 <- as.Date(paste0(students$연도, '-01-01'))
students$year <- as.factor(year(students$연도))
View(students)

glimpse(students)
install.packages('randomForest')
library(randomForest)

split <- floor(nrow(students) * 0.8)

students.tr <- students[1:split, ]

students.test <- students[(split+1):nrow(students), ]


rf = randomForest(학생수계 ~ year, data = students.tr)
print(rf)

mape <- function(actual,pred){
  mape <- mean(abs((actual - pred)/actual))*100
  return (mape)
}

predictions = predict(rf, newdata = students.tr)
mape(students.tr$학생수계, predictions)

predictions = predict(rf, newdata = students.test)
mape(students.test$학생수계, predictions) 

varImpPlot(rf)


install.packages('rpart')
library(rpart)
install.packages('rpart.plot')
library(rpart.plot)

rf = rpart(학생수계 ~ year, data = students.tr)
rpart.plot(rf)

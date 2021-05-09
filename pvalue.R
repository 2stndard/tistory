install.packages('gtools')
library(gtools)
library(ggplot2)
library(tidyverse)
if(!require(randomForest)) {
  install.packages('randomForest')
  library(randomForest)  
}
if(!require(caret)) {
  install.packages('caret')
  library(caret)  
}
nrow(diamonds)*0.8
diamonds.train <- diamonds[1:(nrow(diamonds)*0.8),]
diamonds.test <- diamonds[(nrow(diamonds)*0.8+1):nrow(diamonds),]

model.lm <- lm(price ~ carat, diamonds)
model.rf <- randomForest(price ~ carat + cut + color + clarity, diamonds.train,na.action = na.pass)
predict.rf <- predict(model.rf, diamonds.test[c('carat', 'cut', 'color', 'clarity')], na.action = na.pass)
caret::confusionMatrix(factor(predict.rf, levels=min(diamonds.test$price):max(diamonds.test$price)), factor(diamonds.test$price, levels=min(diamonds.test$price):max(diamonds.test$price)))

class(summary(model.lm))
coefficients(summary(model.lm))[1,4]
stars.pval(coef(summary(model.lm))[1, 4])
scales::pvalue(coef(summary(lm(carat ~ price, diamonds)))[1, 4])
?stars.pval
class(broom::tidy(model.lm))
broom::glance(model.lm)$p.value

library(readxl)
library(dplyr)
library(xts)
students.all <- read_excel("d:/R/Github/concept-of-time-series/students.xlsx", skip = 16, na = '-', sheet = 1, col_types
                           = c('text', 'text', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric','numeric', 'numeric', 'numeric'))

students <- students.all %>%
  filter(지역규모 == '계') %>% select(-지역규모)

students$연도 <- as.Date(paste0(students$연도, '-01-01'))

employees <- read.csv('d:/R/Github/concept-of-time-series/산업별_취업자_20210206234505.csv', header = TRUE, na = '-', strip.white = TRUE, stringsAsFactors = TRUE)

colnames(employees) <- c('time', 'total', 'employees.edu')

employees$time <- as.Date(paste0(employees$time, '. 01'), format = '%Y. %m. %d')

employees.ts <- ts(employees, start = c(2013, 01), frequency = 12)

employees.xts <- xts(employees[,2:3], order.by = employees[,1])

employees.tsibble <- as_tsibble(employees, index = time)


###  2.3.3 추가 실습 데이터 생성
covid19 <- read.csv('d:/R/Github/concept-of-time-series/covid19.csv', header = TRUE, na = '-', strip.white = TRUE, stringsAsFactors = TRUE)

colnames(covid19) <- c('category', 'status', 'date', 'value')

covid19 <- covid19[, c(3, 1, 2, 4)]

covid19$date <- as.Date(covid19$date, "%Y. %m. %d")

covid19 <- covid19 %>%
  filter(grepl('세', category)) %>%
  filter(category != '세종')

covid19$value <- ifelse(is.na(covid19$value), 0, covid19$value)

covid19 <- tidyr::spread(covid19, category, value)

covid19.ts <- ts(covid19[, 2:10], frequency = 365)

covid19.xts <- as.xts(covid19[, 3:10], order.by = covid19$date)

covid19.tsibble <- as_tsibble(covid19, index = date)
covid19[,3]


install.packages('changepoint')
library(changepoint)
library(tidyverse)

## cpt.mean
cpmean.students <- cpt.mean(data = pull(students[, 2]), method = 'BinSeg')
ggplot(students, aes(연도, 학생수계)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = pull(students[cpmean.students@cpts, 1]), color = 'red')

cpmean.employees <- cpt.mean(data = employees[, 2], method = 'BinSeg')
ggplot(employees, aes(time, total)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = employees[cpmean.employees@cpts, 1], color = 'red')

cpmean.covid19 <- cpt.mean(data = covid19[,3], method = 'BinSeg')
ggplot(covid19, aes(date, `0-9세`)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = covid19[cpmean.covid19@cpts, 1], color = 'red')


## cpt.meanvar
cpmeanvar.students <- cpt.meanvar(data = pull(students[, 2]), method = 'BinSeg')
ggplot(students, aes(연도, 학생수계)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = pull(students[cpmeanvar.students@cpts, 1]), color = 'red')

cpmeanvar.employees <- cpt.meanvar(data = employees[, 2], method = 'BinSeg')
ggplot(employees, aes(time, total)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = employees[cpmeanvar.employees@cpts, 1], color = 'red')

cpmeanvar.covid19 <- cpt.meanvar(data = covid19[,3], method = 'BinSeg')
ggplot(covid19, aes(date, `0-9세`)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = covid19[cpmeanvar.covid19@cpts, 1], color = 'red')


## cpt.var
cpvar.students <- cpt.var(data = pull(students[, 2]), method = 'BinSeg')
ggplot(students, aes(연도, 학생수계)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = pull(students[cpvar.students@cpts, 1]), color = 'red')

cpvar.employees <- cpt.var(data = employees[, 2], method = 'BinSeg')
ggplot(employees, aes(time, total)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = employees[cpvar.employees@cpts, 1], color = 'red')

cpvar.covid19 <- cpt.var(data = covid19[,3], method = 'BinSeg')
ggplot(covid19, aes(date, `0-9세`)) + 
  geom_line(aes(group = 1)) + 
  geom_vline(xintercept = covid19[cpvar.covid19@cpts, 1], color = 'red')

library(bcp)

bcp(employees[, 2])

library(dtwclust)
cluster <- tsclust(employees[, 2], k=2, distance="dtw_basic", type="hierarchical") 


N = 300 

X = list() 
for (i in 1:N) { 
  n = 50  
  x = cumsum(sample(c(-1,1),n,TRUE)) 
  X = append(X, list(x)) 
} 

library(ggmap)

seoul <- get_map("Seoul, South Korea", zoom=13, maptype = "roadmap")

ggmap(seoul)
library(mcp)
model = list(employees[, 2]~1, 1~1, 1~1)
fit_mcp = mcp(model, data = employees[, 1:2], par_x = employees[, 1])


library(EnvCpt)

fit_envcpt = envcpt(pull(students[, 2]))
plot(fit_envcpt)

fit_envcpt = envcpt(employees[, 2])
plot(fit_envcpt)

fit_envcpt = envcpt(covid19[,3])
plot(fit_envcpt)

library(bcp)
fit_bcp = bcp(employees[, 2], d = 1000)

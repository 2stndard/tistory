library(readxl)
library(tidyverse)
library(lubridate)


students.all <- read_excel("C:/R/git/concept-of-time-series/students.xlsx", skip = 16, na = '-', sheet = 1, col_types = c('text', 'text', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric','numeric', 'numeric', 'numeric'))

students <- students.all %>%
  filter(지역규모 == '계') %>% select(-지역규모)

students$연도 <- as.factor(students$연도)


students %>%
  ggplot(aes(연도)) +
##  geom_line(aes(y = 학생수계, group = 1)) +
  geom_line(aes(y = 유치원, group = 1), color = 'dark grey') +
  geom_line(aes(y = 초등학교, group = 1), color = 'dark grey') +
  geom_line(aes(y = 중학교, group = 1), color = 'dark grey') +
  geom_line(aes(y = 고등학교계, group = 1), color = 'red')


students %>% 
  gather(category, values, -연도) %>%
  filter(category %in% c('유치원', '초등학교', '중학교', '고등학교계')) %>%
  ggplot(aes(x = 연도, y = values)) +
  geom_line(aes(group = category, color = category))

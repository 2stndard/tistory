library(MASS)
library(tidyverse)
library(readxl)

if (!require('DescTools')) {
  install.packages('DescTools')
  library(DescTools)
}

if (!require('robnptests')) {
  install.packages('robnptests')
  library(robnptests)
}

### 데이터 import
x <- read_excel('d:/R/data/2원본수집데이터 수술실미세먼지농도_210805.xlsx', sheet = 'rawData',
                ## 첫번째 행은 열 이름으로 설정
                col_names = TRUE, 
                ## 열의 타입을 설정, 처음 9개는 문자형으로 다음 79개는 수치형으로 설정
                col_types = c(rep('text', 5), rep('numeric', 85), 'text'
                              )
                )

### 데이터 전처리
x <- x[, -c(1, 87:91)]


data <- x |> filter(PM == '1.0', Location == 'Operator') |>
  group_by(실험군) |>
  summarise_at(vars(5:84), mean) |>
  pivot_longer(-1, names_to = '회차', values_to = '측정값') |>
  pivot_wider(names_from = 실험군, values_from = 측정값) |>
  setNames(c('회차', 'before', 'after'))
  
## 핫지스 레만 측정
HodgesLehmann(data$before, conf.level = 0.95)
HodgesLehmann(data$after, conf.level = 0.95)

## 윌콕스 검증
wilcox.test(data$before, data$after, conf.int = TRUE, conf.level = 0.95,  paired = TRUE)

hl2_test(data$before, data$after, alternative = "two.sided", method = "asymptotic")

hodges_lehmann_2sample(data$before, data$after)



install.packages('itsadug')
library(itsadug)

bam

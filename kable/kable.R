library(openxlsx)
library(knitr)
library(kableExtra)
library(tidyverse)
getwd()
setwd('./kable')
df <-read.xlsx(xlsxFile = './gt/21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', sheet = '학과별 주요 현황',  startRow = 13, na.string = '-', colNames = T)


##df <- read_excel('./trans/21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', skip = 12, na = '-', sheet = '학과별 주요 현황', col_names = T, col_types = c(rep('text', 8), rep('numeric', 56)))

df.kable <- df |>
  group_by(학제, 학위과정) |>
  summarise_at(vars(학과수_전체, 지원자_전체_계, 입학자_전체_계, 재적생_전체_계, 재학생_전체_계, 휴학생_전체_계), funs(sum, mean)) |>
  ungroup() |>
  filter(학과수_전체_sum > 100) |>
  arrange(학제)


kbl(df.kable)  %>%
  kable_styling(bootstrap_options = c("striped", "hover")) |>
  save_kable("./test.pdf")

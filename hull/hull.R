library(tidyverse)
library(readxl)
library(ggforce)
library(concaveman)

getwd()

df <- read_excel('./sankey/(직업계고) 시도.유형별 취업현황_2020.xlsx', skip = 2, na = '-', sheet = 1, col_types = c('text', 'text', rep('numeric', 18)), col_names = F)

colnames(df) <- c('지역', '종류', '졸업자.계', '졸업자.남', '졸업자.여', '취업자.계', '취업자.남', '취업자.여', '진학자.계', '진학자.남', '진학자.여', '입대자.계', '입대자.남', '입대자.여', '제외인정자.계', '제외인정자.남', '제외인정자.여', '미취업자.계', '미취업자.남', '미취업자.여')

View(df)

df |> 
  filter(is.na(지역) == FALSE, is.na(종류) == FALSE) |>
  ggplot(aes(취업자.계, 진학자.계)) +
  geom_point() +
  geom_mark_hull(aes(fill = 종류, label = 종류), concavity = 2.8)
  

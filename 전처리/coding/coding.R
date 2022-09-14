library(readxl)
library(tidyverse)
library(plotly)
if(!require(showtext)) {
  install.packages('showtext')
  library(showtext)
}

showtext_auto()

df <- read_excel('./legend/주요-01 유초 연도별 시도별 교육통계 모음(1999-2021)_210901.xlsx', skip = 3, na = '-', sheet = '01 개황', col_types = c('numeric', 'text', 'text', rep('numeric', 48)), col_names = F)

df_adj <- df |>
  select(1:3, 5, 11, 17, 21) |>
  rename('year' = '...1', 'province' = '...2', 'sch_class' = '...3', 'class_total' = '...5', 'stu_total' = '...11', 'teach_total' = '...17', 'teach_tmp_total' = '...21') |>
  filter(province != '전국', sch_class == c('유치원', '초등학교', '중학교', '고등학교'))

df_adj$province <- fct_relevel(df_adj$province, '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주')

glimpse(df_adj)

df_adj$province1 <- paste0('지역', as.integer(factor(df_adj$province)))
c(df_adj$province, df_adj$province1)
df_adj

sprintf('%03d', as.integer(factor(df_adj$province)))


head(df) %>%
  knitr::kable() %>%
  kableExtra::kable_styling(bootstrap_options = c("striped", 
                                      "hover",
                                      "condensed"))

install.packages('anonymizer')

devtools::install_github("paulhendricks/anonymizer")
library(anonymizer)


anonymize(df_adj$province,  .algo = "crc32")
?anonymize


install.packages('generator')

library(generator)
  
df_adj$province.fake <-  r_full_names(nrow(df_adj))

  nrow(df_adj)
  
library(readxl)
library(tidyverse)

df <- read_excel('./legend/주요-01 유초 연도별 시도별 교육통계 모음(1999-2021)_210901.xlsx', skip = 3, na = '-', sheet = '01 개황', col_types = c('numeric', 'text', 'text', rep('numeric', 48)), col_names = F)

df_adj <- df |>
  select(1:3, 5, 11, 17, 21) |>
  rename('year' = '...1', 'province' = '...2', 'sch_class' = '...3', 'class_total' = '...5', 'stu_total' = '...11', 'teach_total' = '...17', 'teach_tmp_total' = '...21') |>
  filter(province != '전국', sch_class == c('유치원', '초등학교', '중학교', '고등학교'))

df_adj$province <- fct_relevel(df_adj$province, '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주')

df_adj |>
  ggplot(aes(x = year, y = stu_total)) +
  geom_rect(aes(xmin=-Inf,xmax=Inf,ymin=-Inf,ymax=Inf, fill = teach_total)) +
  geom_line(aes(color = sch_class, group = sch_class)) + 
  facet_wrap(~province, ncol = 3) +
  labs(fill = '전체학교수') + 
  theme(panel.background = element_blank(), 
        panel.grid = element_line(color = 'grey90'))


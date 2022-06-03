##install.packages('ggalt')
library(ggalt)
library(readxl)
library(tidyverse)

getwd()

df <- read_excel('./dumbbell/대학 시도별 학생수.xlsx', na = '-', sheet = 'Sheet0', col_types = c(rep('numeric', 19)), col_names = T)

df <- df[-(42:49),]

rate.df <- df |> 
  filter(연도 >= 2019) |>
  gather(key = '지역', value = '학생수', 2:19) |>
  spread(key = 연도, value = 학생수) |>
  mutate(rate = (`2020`/`2019`)*100, rate1 = 100, pos = ifelse(rate >= 100, '증가', '감소')) |>
  select(1, 4, 5, 6)

colnames(rate.df) <- c('지역', '2020', '2019', 'pos')

rate.df$지역 <- fct_relevel(rate.df$지역, '합계', '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주')
  

rate.df |>
  ggplot(aes(x = `2020`, xend = `2019`, y = 지역, group = 지역)) +
  geom_dumbbell(aes(colour = as.factor(pos), colour_x = pos), colour_xend = 'black', size = 2.0) + 
  geom_text(aes(x = `2020`, label = ifelse(pos == '감소', round(`2020`, 1), NA)), vjust = 1.5) +
  geom_text(aes(x = `2020`, label = ifelse(pos == '증가', round(`2020`, 1), NA)), vjust = -1) +
  xlim(95, 100.5) +
  coord_flip() + 
  scale_color_manual(values = c('red', 'blue')) +
  labs(title = '2019년 대비 2020년 지역별 고등교육기관 학생수 비율', x = '비율(%)', color = '증감')

?geom_dumbbell

rate.df |>
  ggplot(aes(x = `2019`, xend = `2020`, y = 지역, yend = 지역)) +
  geom_segment(aes(group = 지역, colour = as.factor(pos)), size = 2, arrow = arrow(length = unit(0.03, "npc"))) + 
  geom_point(aes(colour = as.factor(pos))) +
  geom_text(aes(x = `2020`, label = ifelse(pos == '감소', round(`2020`, 1), NA)), vjust = 1.5) +
  geom_text(aes(x = `2020`, label = ifelse(pos == '증가', round(`2020`, 1), NA)), vjust = -1) +
  theme(legend.position="bottom") +
  xlim(95, 100.5) +
  coord_flip() + 
  labs(title = '2019년 대비 2020년 지역별 고등교육기관 학생수 비율', x = '비율(%)', color = '증감')

?geom_segment

rate.df |>
  gather(rate, value, 2, 3) |>
  ggplot(aes(x = value, y = 지역)) +
  geom_line(aes(group = 지역, colour = as.factor(pos)), size = 2) + 
  geom_point(aes(colour = as.factor(pos))) +
  theme(legend.position="top") +
  coord_flip() + 
  labs(title = '2019년 대비 2020년 지역별 고등교육기관 학생수 비율', x = '비율(%)', color = '증감')
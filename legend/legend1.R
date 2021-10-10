library(readxl)
library(tidyverse)

df <- read_excel('./legend/주요-01 유초 연도별 시도별 교육통계 모음(1999-2021)_210901.xlsx', skip = 3, na = '-', sheet = '01 개황', col_types = c('numeric', 'text', 'text', rep('numeric', 48)), col_names = F)

df_adj <- df |>
  select(1:3, 5, 11, 17, 21) |>
  rename('year' = '...1', 'province' = '...2', 'sch_class' = '...3', 'class_total' = '...5', 'stu_total' = '...11', 'teach_total' = '...17', 'teach_tmp_total' = '...21') |>
  filter(sch_class == '초등학교', year == 2021) |>
  mutate(stu_per_cls = round(stu_total / class_total, 2), 
         stu_per_teach = round(stu_total / teach_total, 2), 
         temp_per_teach = (teach_tmp_total / teach_total) * 100)

View(df_adj)

df_adj$province <- fct_relevel(df_adj$province, '전국', '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주')

## 기본 그래프
basic_plot <- df_adj |>
  ggplot(aes(x = province)) + 
  geom_point(aes(y = stu_per_cls, size = stu_per_teach, color = temp_per_teach)) +
  labs(x = '지역', y = '학급당 학생수')

basic_plot


basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) 


## 범례 위치 변경

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.position = 'bottom')

## 범례 제거

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.position = 'none')

## 범례 정렬

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.position = 'bottom', legend.justification = 'right') ## botttom, left, right


## 범례 방향

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.position = 'bottom', legend.direction = 'vertical') ## botttom, left, right


## 범례 배경

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.background = element_rect(fill = 'red')) ## botttom, left, right


## 범례 테두리

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.background = element_rect(color = 'blue', size = 2, fill = 'red')) ## botttom, left, right


## 범례 여백

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.background = element_rect(color = 'blue'), 
        legend.margin = margin(0, 0, 0, 0)) ## 위에서부터 시계방향 여백


## 범례 여백

basic_plot + 
  scale_color_continuous(##name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(##name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.background = element_rect(color = 'blue'), 
        legend.margin = margin(0, 0, 0, 0)) ## 위에서부터 시계방향 여백


## 범례 제목 꾸미기

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
    breaks = c(3, 5, 7), 
    labels = c('3%', '5%', '7%'), 
    guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
    breaks = c(11, 12, 13, 14, 15), 
    labels = c('11명', '12명', '13명', '14명', '15명'), 
    guide = guide_legend(order = 0)) +
  theme(legend.title = element_text(color = 'blue', size = 20, face = 2)) ## face 1-보통, 2-굵게, 3-기울임, 4-굵게 기울임


## 범례 제목 정렬

basic_plot + 
  scale_color_continuous(name = '비정규교원비율', 
                         breaks = c(3, 5, 7), 
                         labels = c('3%', '5%', '7%'), 
                         guide = guide_colorbar(reverse = TRUE, order = 1)) + 
  scale_size_continuous(name = '교원당 학생수', 
                        breaks = c(11, 12, 13, 14, 15), 
                        labels = c('11명', '12명', '13명', '14명', '15명'), 
                        guide = guide_legend(order = 0)) +
  theme(legend.background = element_rect(color = 'blue'),legend.title.align = 1)

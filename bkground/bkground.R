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
  geom_line(aes(color = sch_class, group = sch_class), size = 1) + 
  facet_wrap(~province, ncol = 3)


df_adj |>
  ggplot(aes(x = year, y = stu_total)) +
  geom_line(aes(color = sch_class, group = sch_class), size = 1) + 
  geom_rect(aes(xmin=-Inf,xmax=Inf,ymin=-Inf,ymax=Inf, fill = teach_total)) +
  facet_wrap(~province, ncol = 3)


df_adj |>
  ggplot(aes(x = year, y = stu_total)) +
  geom_rect(aes(xmin=-Inf,xmax=Inf,ymin=-Inf,ymax=Inf, fill = teach_total)) +
  geom_line(aes(color = sch_class, group = sch_class), size = 1) + 
  facet_wrap(~province, ncol = 3)


df_adj |>
  ggplot(aes(x = year, y = stu_total)) +
  geom_rect(aes(xmin=-Inf,xmax=Inf,ymin=-Inf,ymax=Inf, fill = teach_total), alpha = 0.05) +
  geom_line(aes(color = sch_class, group = sch_class), size = 1) + 
  facet_wrap(~province, ncol = 3) +
  theme(panel.background = element_blank(), 
        panel.grid = element_line(color = 'grey'))
  
df_adj |>
  group_by(province) |>
  summarise(n = sum(teach_total)) -> df_labelname

## named vector

nv_label_name <- setNames(paste0(unique(df_labelname$province), ':', unique(df_labelname$n)), unique(df_labelname$province))

df_adj |>
  ggplot(aes(x = year, y = stu_total)) +
  geom_rect(aes(xmin=-Inf,xmax=Inf,ymin=-Inf,ymax=Inf, fill = teach_total), alpha = 0.05) +
  geom_line(aes(color = sch_class, group = sch_class), size = 1) + 
  facet_wrap(~province, ncol = 3, labeller = as_labeller(nv_label_name)) +
  labs(fill = '전체학교수', color = '학교급') + 
  theme(panel.background = element_blank(), 
        panel.grid = element_line(color = 'grey')) +
  scale_fill_gradient(low = "lightblue", high = "darkblue")


##  function

fn_label_name <- function(x) paste0(x, ' : 교원수 ', unique(n), '명')


df_adj |>
  ggplot(aes(x = year, y = stu_total)) +
  geom_rect(aes(xmin=-Inf,xmax=Inf,ymin=-Inf,ymax=Inf, fill = teach_total), alpha = 0.05) +
  geom_line(aes(color = sch_class, group = sch_class), size = 1) + 
  facet_wrap(~province, ncol = 3, labeller = as_labeller(fn_label_name)) +
  labs(fill = '전체학교수', color = '학교급') + 
  theme(panel.background = element_blank(), 
        panel.grid = element_line(color = 'grey')) +
  scale_fill_gradient(low = "lightblue", high = "darkblue")


## inline function

df_adj |>
  ggplot(aes(x = year, y = stu_total)) +
  geom_rect(aes(xmin=-Inf,xmax=Inf,ymin=-Inf,ymax=Inf, fill = teach_total), alpha = 0.05) +
  geom_line(aes(color = sch_class, group = sch_class), size = 1) + 
  facet_wrap(~province, ncol = 3, labeller = as_labeller(
    function(x) paste0(x, ' : 교원수 ', unique(label_name$n), '명')
  )) +
  labs(fill = '전체학교수', color = '학교급') + 
  theme(panel.background = element_blank(), 
        panel.grid = element_line(color = 'grey')) +
  scale_fill_gradient(low = "lightblue", high = "darkblue")

df_adj |>
  ggplot(aes(x = year, y = stu_total)) +
  geom_rect(aes(xmin=-Inf,xmax=Inf,ymin=-Inf,ymax=Inf, fill = teach_total), alpha = 0.05) +
  geom_line(aes(color = sch_class, group = sch_class), size = 1) + 
  facet_wrap(~province, ncol = 3, labeller = label_context) +
  labs(fill = '전체학교수', color = '학교급') + 
  theme(panel.background = element_blank(), 
        panel.grid = element_line(color = 'grey')) +
  scale_fill_gradient(low = "lightblue", high = "darkblue")


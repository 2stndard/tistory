library(readxl)
library(tidyverse)

df <- read_excel('./legend/주요-01 유초 연도별 시도별 교육통계 모음(1999-2021)_210901.xlsx', skip = 3, na = '-', sheet = '03 연령별 학생수', col_types = c('numeric', 'text', 'text', rep('numeric', 42)), col_names = F)
df <- df |>
  select(1:5) |>
  rename('year' = '...1', 'province' = '...2', 'sch_class' = '...3', 'stu_total' = '...4', 'stu_female' = '...5') |>
  filter(sch_class == '(특목고)', province == '전국') |>
  mutate(stu_male = stu_total - stu_female)

df_longer <- gather(df, sex, value, 4:6)

## 기본 그래프
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수')

## 범례 제목 변경
## 범례 제목 변경 방법 1 - labs()를 이용
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수', color = '구분')

## 범례 제목 변경 방법 2 - scale_color_*()를 이용
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수') + 
  scale_color_discrete(name = '구분')

## 범례 제목 변경 방법 3 - guides()를 이용
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수') + 
  guides(color = guide_legend(title="구분"))



## 범례 라벨 변경
## 범례 라벨 변경 방법 1 - scale_color_*()를 이용
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수') + 
  scale_color_discrete(name = '구분', labels = c('남학생', '여학생'))


## 범례 위치 변경
## 범례 위치 변경 방법 1 - themes()를 이용 - 그래프 영역 밖에 범례를 두고자 할때
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수', color = '구분') + 
  scale_color_discrete(name = '구분', labels = c('남학생', '여학생')) + 
  theme(legend.position = "bottom") ## 

## 범례 위치 변경 방법 1 - themes()를 이용 - 그래프 영역 안에 범례를 두고자 할때
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수', color = '구분') + 
  scale_color_discrete(name = '구분', labels = c('남학생', '여학생')) + 
  theme(legend.position = c(0.9, 0.8))



## 범례 세부 조정 - guides()를 이용 - 범례 제목 위치 설정
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수') + 
  scale_color_discrete(labels = c('남학생', '여학생')) + 
  guides(color = guide_legend(title="구분", title.position = 'top'))


## 범례 세부 조정 - guides()를 이용 - 범례 제목 정렬 위치 설정
df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수') + 
  scale_color_discrete(labels = c('남학생', '여학생')) + 
  guides(color = guide_legend(title="구분", title.position = 'top', title.hjust = 0.5))

df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수') + 
  scale_color_discrete(labels = c('남학생', '여학생')) + 
  guides(color = guide_legend(title="구분", title.position = 'left', title.vjust = 0.5, label = F))

df_longer |>
  filter(sex != 'stu_total') |>
  ggplot(aes(x = as.factor(year))) + 
  geom_line(aes(y = value, group = sex, color = sex)) +
  labs(x = '연도', y = '학생수') + 
  scale_color_discrete(labels = c('남학생', '여학생')) + 
  guides(color = guide_legend(title="구분", title.position = 'top', title.hjust = 0.5, direction = 'horizontal'))


df |> ggplot(aes(x = as.factor(year))) +
  geom_line(aes(y = stu_male, group = 1, color = 'male')) +
  geom_point(aes(y = stu_male, color = 'male')) +
  geom_text(aes(y = stu_male, label = stu_male), vjust = -1) +
  geom_line(aes(y = stu_female, group = 1, color = 'female')) + 
  geom_point(aes(y = stu_female, color = 'female')) +
  geom_text(aes(y = stu_female, label = stu_female), vjust = -1) +
  labs(x = '연도', y = '학생수') +
  scale_color_manual(name = '구분', values = c('male' = 'blue', 'female' = 'red'), labels = c('남학생', '여학생'))
  
df |> ggplot(aes(x = as.factor(year))) +
  geom_line(aes(y = stu_male, group = 1, color = 'male')) +
  geom_point(aes(y = stu_male, color = 'male')) +
  geom_text(aes(y = stu_male, label = stu_male), vjust = -1) +
  geom_line(aes(y = stu_female, group = 1, color = 'female')) + 
  geom_point(aes(y = stu_female, color = 'female')) +
  geom_text(aes(y = stu_female, label = stu_female), vjust = -1) +
  labs(x = '연도', y = '학생수') +
  scale_color_manual(name = '구분', values = c('male' = 'blue', 'female' = 'red'), labels = c('남학생', '여학생')) + 
  theme(legend.position = "right")

df |> ggplot(aes(x = as.factor(year))) +
  geom_line(aes(y = stu_male, group = 1, color = 'male')) +
  geom_point(aes(y = stu_male, color = 'male')) +
  geom_text(aes(y = stu_male, label = stu_male), vjust = -1) +
  geom_line(aes(y = stu_female, group = 1, color = 'female')) + 
  geom_point(aes(y = stu_female, color = 'female')) +
  geom_text(aes(y = stu_female, label = stu_female), vjust = -1) +
  labs(x = '연도', y = '학생수') +
  scale_color_manual(name = '구분', values = c('male' = 'blue', 'female' = 'red'), labels = c('남학생', '여학생')) + 
  theme(legend.position = c(0.6, 0.3))

df |> ggplot(aes(x = as.factor(year))) +
  geom_line(aes(y = stu_male, group = 1, color = 'male')) +
  geom_point(aes(y = stu_male, color = 'male')) +
  geom_text(aes(y = stu_male, label = stu_male), vjust = -1) +
  geom_line(aes(y = stu_female, group = 1, color = 'female')) + 
  geom_point(aes(y = stu_female, color = 'female')) +
  geom_text(aes(y = stu_female, label = stu_female), vjust = -1) +
  labs(x = '연도', y = '학생수') +
  scale_color_manual(name = '구분', values = c('male' = 'blue', 'female' = 'red'), labels = c('남학생', '여학생')) + 
  theme(legend.position = 'none')

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
  labs(x = '지역', y = '학급당 학생수') + 
  theme(legend.background = element_rect(fill="lightblue",size= 1, linetype="solid", colour ="blue"))

basic_plot

## 범례 제목 변경
## 범례 제목 변경 방법 1 - labs()를 이용

basic_plot +
  labs(size = '교원당 학생수', color = '비정규교원비율')



## 범례 제목 변경 방법 2 - scale_*()를 이용
basic_plot + 
  scale_color_continuous(name = '비정규교원비율') + 
  scale_size_continuous(name = '교원당 학생수')



## 범례 제목 변경 방법 3 - guides()를 이용
basic_plot + 
  guides(color = guide_legend(title = '비정규교원비율'), 
         size = guide_legend(title = '교원당 학생수'))

basic_plot + 
  scale_color_continuous(guide = guide_legend(title = '비정규교원비율')) + 
  scale_size_continuous(guide = guide_legend(title = '교원당 학생수'))

basic_plot + 
  guides(color = guide_legend(title = '비정규교원비율'), 
         size = guide_legend(title = '교원당 학생수'))




## 범례 라벨 변경
## 범례 라벨 변경 방법 1 - scale_*()를 이용
basic_plot + 
  scale_color_continuous(name = '비정규교원비율', breaks = c(2, 4, 6, 8), labels = c('2%', '4%', '6%', '8%')) + 
  scale_size_continuous(name = '교원당 학생수', breaks = c(10:16), labels = c('10명', '11명', '12명', '13명', '14명', '15명', '16명'))

## 범례 위치 변경
## 범례 위치 변경 방법 1 - themes()를 이용 - 그래프 영역 밖에 범례를 두고자 할때
basic_plot + 
  scale_color_continuous(name = '비정규교원비율', breaks = c(2, 4, 6, 8), labels = c('2%', '4%', '6%', '8%')) + 
  scale_size_continuous(name = '교원당 학생수', breaks = c(10:16), labels = c('10명', '11명', '12명', '13명', '14명', '15명', '16명')) + 
  theme(legend.position = "bottom") 


## 범례 세부 조정 - guides()를 이용 - 범례 제목 위치 설정
basic_plot + 
  scale_color_continuous(name = '비정규교원비율', breaks = c(2, 4, 6, 8), labels = c('2%', '4%', '6%', '8%')) + 
  scale_size_continuous(name = '교원당 학생수', breaks = c(10:16), labels = c('10명', '11명', '12명', '13명', '14명', '15명', '16명')) + 
  guides(color = guide_legend(title.position = 'bottom'),
         size = guide_legend(title.position = 'left'))


## 범례 세부 조정 - guides()를 이용 - 범례 제목 정렬 위치 설정
basic_plot + 
  scale_color_continuous(name = '비정규교원비율', breaks = c(2, 4, 6, 8), labels = c('2%', '4%', '6%', '8%')) + 
  scale_size_continuous(name = '교원당 학생수', breaks = c(10:16), labels = c('10명', '11명', '12명', '13명', '14명', '15명', '16명')) + 
  guides(color = guide_legend(title.position = 'top'), 
         size = guide_legend(title.position = 'top'))

remove.packages('bookdown')
install.packages('bookdown')

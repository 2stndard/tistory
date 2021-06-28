library(patchwork)
library(forcats)
library(readxl)
library(tidyverse)
library(ggbreak)

data <- read_xlsx('D:/R/Git/tistory/tidyverse_select1/주요 교육통계자료 행정구역별 2010-2020(탑재용)_201124.xlsx', sheet = '2020', skip = 5, col_types = c(rep('text', 4), rep('numeric', 33)), col_names = FALSE)

names(data) <- c('기준일', '시도', '시군구', '학교급', '학교수', '학급수_계', '학급수_1학년', '학급수_2학년', '학급수_3학년', '학급수_4학년', '학급수_5학년', '학급수_6학년', '학생수_계_계', '학생수_계_여', '학생수_1학년_계', '학생수_1학년_여', '학생수_2학년_계', '학생수_2학년_여', '학생수_3학년_계', '학생수_3학년_여', '학생수_4학년_계', '학생수_4학년_여', '학생수_5학년_계', '학생수_5학년_여', '학생수_6학년_계', '학생수_6학년_여', '교원수_계', '교원수_여', '다문화_계', '다문화_여', '학업중단자_계', '학업중단자_여', '학업중단자_유예', '학업중단자_면제', '학업중단자_자퇴', '학업중단자_퇴학', '학업중단자_제적')


ggplot(data, aes(x = as.factor(학교급))) + 
  geom_bar()


data %>% group_by(학교급) %>%
  summarise(학교수 = sum(학교수)) %>%
  ggplot(aes(x = fct_relevel(학교급, '계', '유치원', '초등학교', '중학교', '고등학교', '(일반고)', '(자율고)', '(특목고)', '(특성화고)', '고등공민학교', '고등기술학교', '각종학교'))) + 
  geom_col(aes(y = 학교수)) + 
  xlab('학교급') + 
  scale_y_break(c(17000, 40000), ticklabels = c(40000, 41000))


data %>%
  filter(학교급 %in% c('초등학교', '중학교', '고등학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  ggplot(aes(x = 학급당학생수, fill = fct_relevel(학교급, '계', '유치원', '초등학교', '중학교', '고등학교', '(일반고)', '(자율고)', '(특목고)', '(특성화고)', '고등공민학교', '고등기술학교', '각종학교'))) + 
  geom_density(alpha = 0.3) + 
  labs(x = '학급당학생수', fill = '학교급') -> p_전체

data %>%
  filter(학교급 %in% c('초등학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  ggplot(aes(x = 학급당학생수, fill = 학교급)) + 
  geom_density(alpha = 0.3) + 
  labs(y = '밀도분포') + 
  theme(legend.position = 'none', 
        axis.title.x=element_blank()) -> density_초등학교

data %>%
  filter(학교급 %in% c('중학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  ggplot(aes(x = 학급당학생수, fill = 학교급)) + 
  geom_density(alpha = 0.3) + 
  labs(x = '중학교', y = '') + 
  theme(legend.position = 'none', 
        axis.title.y=element_blank(), 
        axis.title.x=element_blank())  -> p_중학교

data %>%
  filter(학교급 %in% c('고등학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  ggplot(aes(x = 학급당학생수, fill = 학교급)) + 
  geom_density(alpha = 0.3) + 
  labs(x = '고등학교', y = '') + 
  theme(legend.position = 'none', 
        axis.title.y=element_blank(), 
        axis.title.x=element_blank())  -> p_고등학교


p_전체 / (p_초등학교 + p_중학교 + p_고등학교)



data %>%
  filter(학교급 %in% c('초등학교', '중학교', '고등학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  group_by(시도) %>%
  summarise(평균.학급당학생수 = mean(학급당학생수)) %>%
  ggplot(aes(x = 평균.학급당학생수, y = fct_relevel(시도, '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주'))) + 
  geom_col(fill = 'dark blue') + 
  geom_text(aes(label = round(평균.학급당학생수, 2), x = 평균.학급당학생수-0.7), color = 'white') +
  labs(x = '학급당학생수', y = '시도') + 
  scale_y_discrete(limits=rev)



data %>%
  filter(학교급 %in% c('초등학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  group_by(시도) %>%
  summarise(평균.학급당학생수 = mean(학급당학생수)) %>%
  ggplot(aes(x = 평균.학급당학생수, y = fct_relevel(시도, '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주'))) + 
  geom_col(fill = 'dark blue') + 
  geom_text(aes(label = round(평균.학급당학생수, 2), x = 평균.학급당학생수-2.5), color = 'white', size = 2.5) +
  labs(x = '초등학교 학급당학생수', y = '시도') + 
  scale_y_discrete(limits=rev) -> p_시도_초등학교

data %>%
  filter(학교급 %in% c('중학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  group_by(시도) %>%
  summarise(평균.학급당학생수 = mean(학급당학생수)) %>%
  ggplot(aes(x = 평균.학급당학생수, y = fct_relevel(시도, '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주'))) + 
  geom_col(fill = 'dark blue') + 
  geom_text(aes(label = round(평균.학급당학생수, 2), x = 평균.학급당학생수-2.5), color = 'white', size = 2.5) +
  labs(x = '중학교 학급당학생수', y = '시도') + 
  scale_y_discrete(limits=rev) +
  theme(axis.title.y=element_blank()) -> p_시도_중학교

data %>%
  filter(학교급 %in% c('고등학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  group_by(시도) %>%
  summarise(평균.학급당학생수 = mean(학급당학생수)) %>%
  ggplot(aes(x = 평균.학급당학생수, y = fct_relevel(시도, '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주'))) + 
  geom_col(fill = 'dark blue') + 
  geom_text(aes(label = round(평균.학급당학생수, 2), x = 평균.학급당학생수-2.5), color = 'white', size = 2.5) +
  labs(x = '고등학교 학급당학생수', y = '시도') + 
  scale_y_discrete(limits=rev) +
  theme(axis.title.y=element_blank()) -> p_시도_고등학교

((p_초등학교 + p_중학교 + p_고등학교) / (p_시도_초등학교 + p_시도_중학교 + p_시도_고등학교)) + 
  plot_annotation(title = '학교급별 학급당 학생수', tag_levels = 'a', tag_prefix = '학생수', tag_sep = '|', caption = '(데이터 출처 : 교육통계 서비스 홈페이지)', theme = theme(plot.title = element_text(size = 16, hjust = 0.5)))

?plot_annotation

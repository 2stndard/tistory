install.packages('patchwork')
library(patchwork)
library(forcats)

data
ggplot(data, aes(x = as.factor(학교급))) + 
  geom_bar()

data %>% group_by(학교급) %>%
  summarise(학교수 = sum(학교수)) %>%
  ggplot(aes(x = fct_relevel(학교급, '계', '유치원', '초등학교', '중학교', '고등학교', '(일반고)', '(자율고)', '(특목고)', '(특성화고)', '고등공민학교', '고등기술학교', '각종학교'))) + 
  geom_col(aes(y = 학교수)) + 
  xlab('학교급')


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
  labs(x = '초등학교') + 
  theme(legend.position = 'none')   -> p_초등학교

data %>%
  filter(학교급 %in% c('중학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  ggplot(aes(x = 학급당학생수, fill = 학교급)) + 
  geom_density(alpha = 0.3) + 
  labs(x = '중학교', y = '') + 
  theme(legend.position = 'none', 
        axis.title.y=element_blank())  -> p_중학교

data %>%
  filter(학교급 %in% c('고등학교')) %>%
  mutate(학급당학생수 = 학생수_계_계 / 학급수_계) %>%
  ggplot(aes(x = 학급당학생수, fill = 학교급)) + 
  geom_density(alpha = 0.3) + 
  labs(x = '고등학교', y = '') + 
  theme(legend.position = 'none', 
        axis.title.y=element_blank())  -> p_고등학교


p_전체 / (p_초등학교 + p_중학교 + p_고등학교)

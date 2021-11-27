library(readxl)
library(tidyverse)
if(!require(showtext)) {
  install.packages('showtext')
  library(showtext)
}

showtext_auto()

df <- read_excel('./spagetti/연도별 신입생 충원율 현황.xlsx', skip = 2, na = '-', col_names = F, col_types = c(rep('numeric', 13)))

df.충원률 <- df |> select(1, 4, 7, 10, 13)

names(df.충원률) <- c('연도', '전체충원률', '전문대충원률', '대학충원률', '대학원충원률')

df.충원률 <- df.충원률 |>
  filter(연도 >= 1999)

df.충원률 <- pivot_longer(df.충원률, 2:5, names_to = '구분')

df.충원률$구분 <- fct_relevel(df.충원률$구분, c('전체충원률', '전문대충원률', '대학충원률', '대학원충원률') )

df.충원률 |> 
  ggplot(aes(x = as.factor(연도), y = value)) +
  geom_line(aes(group = 구분, color = 구분)) +
  labs(x = '연도', y = '충원률') +
  scale_y_continuous(labels = scales::number_format(suffix = '%')) +
  theme(axis.text.x = element_text(angle = -90))


df.충원률 |> 
  ggplot(aes(x = as.factor(연도), y = value)) +
  geom_line(aes(group = 구분)) +
  labs(x = '연도', y = '충원률') +
  scale_y_continuous(labels = scales::number_format(suffix = '%')) +
  theme(axis.text.x = element_text(angle = -90)) +
  facet_wrap(~구분)

#df.충원률.temp <- df.충원률 |> mutate(구분1 = 구분) |> group_by(구분) |> ungroup() |> select(-구분)

df.충원률.temp <- df.충원률 |> mutate(구분1 = 구분) |> select(-구분)


df.충원률 |> 
  ggplot(aes(x = as.factor(연도), y = value)) +
  geom_line(data = df.충원률.temp, aes(group = 구분1), color = 'grey75') +
  geom_line(aes(group = 구분)) +
  labs(x = '연도', y = '충원률') +
  scale_y_continuous(labels = scales::number_format(suffix = '%')) +
  theme(axis.text.x = element_text(angle = -90)) +
  facet_wrap(~구분)


df.충원률 |> 
  ggplot(aes(x = as.factor(연도), y = value)) +
  geom_line(aes(group = 구분), color = 'grey80') +
  geom_line(data = df.충원률 |> filter(구분 == '대학충원률'), aes(group = 구분, color = 구분)) +
  labs(x = '연도', y = '충원률') +
  scale_y_continuous(labels = scales::number_format(suffix = '%')) +
  theme(axis.text.x = element_text(angle = -90)) +
  scale_color_manual(values = c('대학충원률' = 'red'))

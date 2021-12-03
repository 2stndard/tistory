library(readxl)
library(tidyverse)
library(showtext)
library(patchwork)
showtext_auto()


library(readxl)
library(tidyverse)

setwd('./trans')

df <- read_excel('./21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', skip = 12, na = '-', sheet = '학과별 주요 현황', col_names = T, col_types = c(rep('text', 8), rep('numeric', 56)))


df.전처리 <- df |>
  filter(학제 %in% c('대학교'))

df.전처리$대계열 <- fct_relevel(df.전처리$대계열, c('인문계열', '사회계열', '자연계열', '공학계열', '예체능계열', '교육계열', '의약계열'))


install.packages('moments')
library(moments)

skewness(df.전처리$재적생_전체_계)
?skewness

n.sample <- rnorm(n = 10000, mean = 55, sd = 4.5)

sim <- data.frame(n.sample)

str(sim)

skewness(sim$n.sample)

ggplot(data = sim, aes(x = n.sample)) + geom_histogram()

n.sample <- rbeta(10000,5,2)

n.sample <- rbeta(10000,2,5)

sim <- data.frame(n.sample)

df.전처리 |>
  filter(입학자_전체_계 != 0) |>
  ggplot(aes(x = 입학자_전체_계)) +
  geom_bar() +
  geom_text(aes(label = ..count..), stat = "count", vjust = -.2) +
  scale_x_binned(n.breaks = 40, right = T)
  

df.전처리 |>
  filter(입학자_전체_계 != 0) |>
  ggplot(aes(x = 입학자_전체_계)) +
  geom_histogram(bins = 3) +
  stat_bin(aes(y=..count.., label=..count..), bins = 3, geom="text", vjust=-.5) +
  labs(x = '재적학생수', y = '학과수') + 
  geom_vline(xintercept = 0, color = 'red') + 
  geom_vline(xintercept = max(df.전처리$입학자_전체_계)/2, color = 'red') +
  geom_vline(xintercept = max(df.전처리$입학자_전체_계), color = 'red') +
  geom_vline(xintercept = (max(df.전처리$입학자_전체_계)/2)/2, color = 'blue', linetype = 2) +
  geom_vline(xintercept = (max(df.전처리$입학자_전체_계)/2)/2*3, color = 'blue', linetype = 2) + 
  scale_x_continuous(breaks = c(0, 
                                (max(df.전처리$입학자_전체_계)/2)/2,
                     max(df.전처리$입학자_전체_계)/2, 
                     (max(df.전처리$입학자_전체_계)/2)/2*3, 
                     max(df.전처리$입학자_전체_계)
                     )
)
  


max(df.전처리$입학자_전체_계)

df.전처리 |>
  filter(입학자_전체_계 != 0) |>
  ggplot(aes(x = 입학자_전체_계)) +
  geom_histogram(binwidth = 1000, center = FALSE) +
  stat_bin(aes(y=..count.., label=..count..), binwidth = 1000, geom="text", vjust=-.5) +
  labs(x = '재적학생수', y = '학과수') + 
  scale_x_continuous(breaks = seq(from = 0, to = 11000, by = 1000))



df.전처리 |>
  filter(입학자_전체_계 != 0, 입학자_전체_계 <= 2603) |>
  count()

df.전처리 |>
  filter(입학자_전체_계 != 0, 입학자_전체_계 <= 2603) |>
  group_by(입학자_전체_계) |>
  tally() |>
  arrange(desc(입학자_전체_계)) |>
  select(입학자_전체_계)
  
seq(from = 174, to )
(10590/30)

178

bin60<- df.전처리 |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_histogram(bins = 60) +
  labs(title = 'bin = 60', x = '재적학생수', y = '학과수')

bin120<- df.전처리 |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_histogram(bins = 120) +
  labs(title = 'bin = 120', x = '재적학생수', y = '학과수')


binwidth500 <- df.전처리 |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_histogram(binwidth = 500) +
  labs(title = 'binwidth = 500', x = '재적학생수', y = '학과수')

binwidth1000 <- df.전처리 |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_histogram(binwidth = 1000) +
  labs(title = 'binwidth = 1000', x = '재적학생수', y = '학과수')

(bin60 + bin120) / (binwidth1000 + binwidth500)

df.전처리 |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_histogram(bins = 60) +
  labs(x = '재적학생수', y = '학과수') + 
  #  scale_y_continuous(trans = 'log',
  #                    breaks = c(1, 10, 100, 1000), minor_breaks = NULL) +
  scale_x_continuous(trans = 'log',
                     breaks = c(1:5, 10, 100, 1000, 10000, 50000), minor_breaks = NULL)

df.전처리 |>
  filter(재적생_전체_계 > 0) |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_histogram(bins = 60, fill="green", col="dark green") +
  labs(x = '재적학생수', y = '학과수')

df.전처리 |>
  filter(재적생_전체_계 < 100, 재적생_전체_계 >= 1) |>
  group_by(재적생_전체_계) |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_histogram(binwidth = 1, fill="green", col="dark green") +
  labs(x = '재적학생수', y = '학과수')


df.전처리 |>
  filter(재적생_전체_계 < 100) |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_histogram(binwidth = 1, fill="green", col="dark green") +
  labs(x = '재적학생수', y = '학과수')

+ 
  scale_y_continuous(trans = 'log10',
                     breaks = c(1:5, 10, 100, 1000)) +
  scale_x_continuous(trans = 'log10',
                     breaks = c(1:5, 10, 100, 1000, 10000, 50000), minor_breaks = NULL)


df.전처리 |>
  ggplot(aes(x = 재적생_전체_계)) +
  geom_density() +
  labs(x = '재적학생수', y = '학과수') + 
  scale_y_continuous(trans = 'sqrt',
                     breaks = c(1:5, 10, 100, 1000)) +
  scale_x_continuous(trans = 'log2',
                     breaks = c(1:5, 10, 100, 1000, 10000, 50000), minor_breaks = NULL)

df.전처리 |>
  group_by(재적생_전체_계) |>
  count() |>
  arrange(desc(n))|>
  head(100) |>
  View()


df.전처리 |>
  filter(입학자_전체_계 != 0) |>
  group_by(입학자_전체_계) |>
  summarise(sum = n()) |>
  ungroup() |>
  mutate(구간 = cut_number(입학자_전체_계, 30)) |>
  group_by(구간) |>
  summarise(sum = sum(sum))


log10(5)
log10(10)

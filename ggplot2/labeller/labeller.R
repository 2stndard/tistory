library(tidyverse)
library(showtext)
showtext_auto()

tran_label <- function(string) {
  string <- paste0(string, '(n=', map_int(unique(df_high$학위과정), n_label), ')')
#  string <- map_int(unique(df_high$학위과정), n_label)
}

df_high |> 
  filter(정원대비입학생 < 3) |> 
  ggplot(aes(x = 대계열, y = 정원대비입학생)) +
  geom_boxplot() +
  geom_hline(aes(yintercept = 1), col = 'red') +
  facet_wrap(~학위과정, labeller = labeller(학위과정 = tran_label)) +
  theme(axis.text.x = element_text(angle= 90))

n_label <- function(string) {
  df_high |> 
    filter(학위과정 == string) |>
    summarise(n = n()) |> pull()
}

df_high |> 
  filter(학위과정 == '대학과정') |>
  summarise(n = n()) |> pull()


df_high |> 
  filter(정원대비입학생 < 3) |> 
  ggplot(aes(x = 대계열, y = 정원대비입학생)) +
  geom_boxplot() +
  geom_hline(aes(yintercept = 1), col = 'red') +
  facet_wrap(~학위과정, labeller = labeller(학위과정 = label_wrap_gen(50))) +
  theme(axis.text.x = element_text(angle= 90))

library(tidyverse)
library(readxl)
library(plotly)
library(networkD3)

df <- read_excel('./sankey/(직업계고) 시도.유형별 취업현황_2020.xlsx', skip = 2, na = '-', sheet = 1, col_types = c('text', 'text', rep('numeric', 18)), col_names = F)

colnames(df) <- c('지역', '종류', '졸업자.계', '졸업자.남', '졸업자.여', '취업자.계', '취업자.남', '취업자.여', '진학자.계', '진학자.남', '진학자.여', '입대자.계', '입대자.남', '입대자.여', '제외인정자.계', '제외인정자.남', '제외인정자.여', '미취업자.계', '미취업자.남', '미취업자.여')


sankey <- df |> 
  filter(is.na(지역) == FALSE, is.na(종류) == FALSE) |>
  select(-c(지역, 졸업자.계, ends_with('남'), ends_with('여'))) |> 
  group_by(종류) |>
  summarise_all(sum) |>
  rename(c('취업자' = '취업자.계', '진학자' = '진학자.계', '입대자' = '입대자.계', '제외인정자' = '제외인정자.계', '미취업자' = '미취업자.계')) |>
  gather('구분', '학생수', -1) |>
  mutate(종류 = fct_relevel(종류, '마이스터고', '특성화고', '일반고_직업반'), 
         구분 = fct_relevel(구분, '취업자', '진학자', '입대자', '제외인정자', '미취업자')) |>
  arrange(종류, 구분)



from <- unique(as.character(sankey$종류))
to <- unique(as.character(sankey$구분))

plot_ly(type = 'sankey', 
        orientation = 'h',
        node = list(
          label = c(from, to),
          pad = 5, 
          thickness = 30, 
##          valueformat = ".0f",
##          valuesuffix = "%",
          line = list(color = 'black', width = 0.5)
        ), 
        link = list(
          source = c(rep(0, 5), rep(1, 5), rep(2, 5)),
          target = c(rep(3:7, 3)),
          ##          label = c(rep('a', 35)),
          value = sankey$학생수
        ), 
        textfont = list(size = 12)
)

links <- data.frame(
  source = c(rep(0, 5), rep(1, 5), rep(2, 5)),
  target = c(rep(3:7, 3)),
  value = sankey$학생수
)

nodes <- data.frame(
  name = c(from, to)
)

sankeyNetwork(Links = links, Nodes = nodes,
              Source = "source", Target = "target",
              Value = "value", NodeID = "name", 
              sinksRight=FALSE, fontSize = 12, nodeWidth = 20)


library(showtext)
showtext_auto()
library(tidyverse)
library(readxl)
library(patchwork)
library(plotly)


p_pie <- df_취업률_2000 |> group_by(대계열) |>
  summarise(졸업자수 = sum(졸업자수)) |> 
  plot_ly()


fig <- p_pie |>
  ## value와 labels를 매핑한 파이 trace 추가
  add_trace(type = 'pie', values = ~졸업자수, labels = ~대계열) |> 
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'use1.json')


fig <- p_pie |>
  add_trace(type = 'pie', values = ~졸업자수, labels = ~대계열, 
            ## textinfo를 value로 설정
            textinfo = 'value') |> 
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'use2.json')


fig <- p_pie |>
  add_trace(type = 'pie', values = ~졸업자수, labels = ~대계열, 
            ## textinfo를 percent로 설정
            textinfo = 'percent') |> 
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))




fig <- plotly_json(fig, FALSE)
write(fig,'use3.json')


fig <- p_pie |>
  add_trace(type = 'pie', values = ~졸업자수, labels = ~대계열, 
            ## textinfo를 label+percent로 설정
            textinfo = 'label+percent') |> 
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)



fig <- plotly_json(fig, FALSE)
write(fig,'use4.json')


fig <- p_pie |>
  add_trace(type = 'pie', values = ~졸업자수, labels = ~대계열, 
            ## textinfo를 label+value로 설정
            textinfo = 'label+value') |> 
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)



fig <- plotly_json(fig, FALSE)
write(fig,'use5.json')


fig <- p_pie |>
  add_trace(type = 'pie', values = ~졸업자수, labels = ~대계열, 
            textinfo = 'label+percent', 
            ## hole을 0.4로 설정
            hole = 0.4) |> 
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))


fig <- plotly_json(fig, FALSE)
write(fig,'use6.json')

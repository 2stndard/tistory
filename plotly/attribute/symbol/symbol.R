library(showtext)
showtext_auto()
library(tidyverse)
library(readxl)
library(patchwork)
library(plotly)

df_취업률_symbol <- df_취업률_2000 |> 
  ## 심볼 설정을 위한 열 생성
  mutate(symbol = case_when(
    대계열 == '인문계열' ~ 1, 
    대계열 == '사회계열' ~ 2,
    대계열 == '교육계열' ~ 3,
    대계열 == '자연계열' ~ 4,
    대계열 == '공학계열' ~ 5,
    대계열 == '의약계열' ~ 6,
    대계열 == '예체능계열' ~ 7)
  ) 

## 심볼 설정을 위한 열이 추가된 데이터프레임에서
fig <- df_취업률_symbol |> 
  plot_ly(x = ~졸업자수, y = ~취업자수, 
          ## symbol을 연속형 수치 변수에 매핑
          symbol = ~symbol) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'symbol1.json')


fig <- df_취업률_symbol |> 
  plot_ly(x = ~졸업자수, y = ~취업자수, 
          ## symbol을 팩터형 변수에 매핑
          symbol = ~factor(symbol)) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'symbol2.json')

fig <- df_취업률_symbol |> 
  plot_ly(x = ~졸업자수, y = ~취업자수, 
          symbol = ~factor(symbol), 
          ## symbols를 심볼 이름으로 설정
          symbols = c('circle', 'circle-open', 'circle-dot', "circle-open-dot", 
                      "square", "square-open", "square-dot")) |>
  layout(title = '졸업자 대비 취업자수', margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))

fig <- plotly_json(fig, FALSE)
write(fig,'symbol3.json')

fig <- df_취업률_symbol |>
  ## symbol을 심볼 이름으로 설정
  plot_ly(x = ~졸업자수, y = ~취업자수, symbol = 'circle-open') |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'symbol4.json')

fig <- df_취업률_symbol |> 
  ## symbol을 I()를 사용하여 심볼 이름으로 설정
  plot_ly(x = ~졸업자수, y = ~취업자수, symbol = I('circle-open')) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'symbol5.json')

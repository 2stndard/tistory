library(tidyverse)
library(readxl)
library(patchwork)
library(plotly)


p_box <- 
  ## 취업률 데이터를 사용하여 plotly 객체 생성
  df_취업률_2000 |> 
  plot_ly()

fig <- p_box |> 
  ## 박스 trace 추가
  add_trace(type = 'box', 
            ## X, Y축 변수 매핑
            x = ~대계열, y = ~취업률) |>
  ## 제목, 여백 설정
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'use1.json')


fig <- p_box |> 
  ## boxmean을 TRUE로 설정한 박스 trace 추가
  add_trace(type = 'box', boxmean = TRUE, 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)




fig <- plotly_json(fig, FALSE)
write(fig,'use7.json')

fig <- p_box |> 
  ## boxmean을 sd로 설정한 박스 trace 추가
  add_trace(type = 'box', boxmean = 'sd', 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))






fig <- plotly_json(fig, FALSE)
write(fig,'use8.json')

fig <- p_box |> 
  ## boxpoint을 all로 설정한 박스 trace 추가
  add_trace(type = 'box', boxpoints = 'all', 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)




fig <- plotly_json(fig, FALSE)
write(fig,'use9.json')

fig <- p_box |> 
  ## boxpoint을 outliers로 설정한 박스 trace 추가
  add_trace(type = 'box', boxpoints = 'outliers' 
            , x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)





fig <- plotly_json(fig, FALSE)
write(fig,'use10.json')

fig <- p_box |> 
  ## boxpoint을 suspectedoutliers로 설정한 박스 trace 추가
  add_trace(type = 'box', boxpoints = 'suspectedoutliers', 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)




fig <- plotly_json(fig, FALSE)
write(fig,'use11.json')

fig <- p_box |> 
  ## boxpoint을 FALSE로 설정한 박스 trace 추가
  add_trace(type = 'box', boxpoints = FALSE, 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)


fig <- plotly_json(fig, FALSE)
write(fig,'use12.json')


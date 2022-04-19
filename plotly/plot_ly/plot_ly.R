library(plotly)

fig <- covid19_df_100 |> 
  plot_ly()


fig <- plotly_json(fig, FALSE)
write(fig,'plot_ly_1.json')


fig <- covid19_df_100 |> 
  ## 한국 데이터만을 필터링 
  filter(iso_code == 'KOR') |>
  ## X축에 data, Y축에 new_cases를 매핑하여 plot_ly()로 시각화 생성
  plot_ly(x = ~date, y = ~new_cases)

fig <- plotly_json(fig, FALSE)
write(fig,'plot_ly_2.json')


fig <- covid19_df_100 |> 
  filter(iso_code == 'KOR') |> 
  ## plot_ly()로 시각화를 초기화
  plot_ly() |>
  ## 스캐터 trace 타입으로 X축에 date, Y축에 new_cases를 매핑한 시각화 생성
  add_trace(type = 'scatter', x = ~date, y = ~new_cases) |>
  config(toImageButtonOptions = list(format = 'svg'))


fig <- plotly_json(fig, FALSE)
write(fig,'plot_ly_3.json')

fig <- subplot(
  p1 |> 
    layout(annotations = list(
      x = 0.5 , y = 1.02, text = "한국",
      showarrow = F, 
      xref='paper', yref='paper',
      xanchor = 'center')),
  p2 |> 
    layout(annotations = list(
      x = 0.5 , y = 1.02, text = "아시아",
      showarrow = F, xref='paper', yref='paper',
      xanchor = 'center')),
  p3 |> 
    layout(annotations = list(
      x = 0.5 , y = 1.02, text = "유럽",
      showarrow = F, xref='paper', yref='paper',
      xanchor = 'center')),
  p4 |> 
    layout(annotations = list(
      x = 0.5 , y = 1.02, text = "북미", 
      showarrow = F, xref='paper', yref='paper',
      xanchor = 'center')),
  p5 |> 
    layout(annotations = list(
      x = 0.5 , y = 1.02, text = "남미",
      showarrow = F, xref='paper', yref='paper',
      xanchor = 'center')),
  p6 |> 
    layout(annotations = list(
      x = 0.5 , y = 1.02, text = "오세아니아",
      showarrow = F, xref='paper', yref='paper',
      xanchor = 'center')),
  p7 |> 
    layout(annotations = list(
      x = 0.5 , y = 1.02, text = "아프리카", 
      showarrow = F, xref='paper', yref='paper',
      xanchor = 'center')),
  nrows = 3,
  margin = 0.04) |> 
  layout(showlegend = FALSE,
         title = '최근 100일간 코로나19 확진자수',
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))

fig <- plotly_json(fig, FALSE)
write(fig,'subplot1_1.json')


fig <- df_covid19_100 |>
  ## 국가명으로 그룹화
  group_by(location) |>
  ## 그룹화한 각각의 데이터 그룹들에 적용할 코드 설정
  do(
    ## 각 그룹화한 데이터를 사용해 plotly 객체 생성    
    p = plot_ly(.) |> 
      ## line 모드의 스캐터 trace 추가
      add_trace(type = 'scatter', mode = 'lines',
                ## X, Y축에 변수 매핑, color를 설정
                x = ~date, y = ~new_cases, color = I('#1f77b4')) |>
      ## layout으로 X, Y축을 설정
      layout(title = list(title = NULL),
             xaxis = list(tickfont = list(size = 10)),  
             yaxis = list(title = list(text = '확진자수')),
             ## 국가명을 주석으로 표시
             annotations = list(x = 0.5 , y = 1.02, text = ~location, 
                                showarrow = F, xref='paper', 
                                yref='paper', xanchor = 'center'))
  ) |>
  ## 생성된 plotly 객체들을 subplot 생성
  subplot(nrows = 3, shareX = TRUE, shareY = TRUE) |>
  ## 생성된 subplot의 layout 설정
  layout(showlegend = FALSE, 
         title = '최근 100일간 코로나19 확진자수',
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'subplot1_2.json')


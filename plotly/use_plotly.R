fig <- df_취업률_2000 |> 
  plot_ly() |> 
  add_trace(type = 'box', data = df_취업률_2000 |> filter(과정구분 == '대학과정'),
            x = ~대계열, y = ~취업률, name = '대학') |> 
  add_trace(type = 'box', data = df_취업률_2000 |> filter(과정구분 == '전문대학과정'), 
            x = ~대계열, y = ~취업률, name = '전문대학') |> 
  layout(boxmode = "group", 
         title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins) |>
  ## 마우스 휠을 줌으로 사용하기 위해 속성 설정
  config(scrollZoom = TRUE)

fig <- plotly_json(fig, FALSE)
write(fig,'use.json')

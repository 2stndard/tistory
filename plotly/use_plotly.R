fig <- left_join(USD_KRW, EUR_KRW, by = 'date') |>
  plot_ly() |>
  add_lines(x = ~date, y = ~one_USD_equivalent_to_x_KRW, name = 'USD') |>
  add_lines(x = ~date, y = ~one_EUR_equivalent_to_x_KRW, name = 'EUR') |>
  layout(title = '2022년 원화의 달러와 유로 환율', 
         xaxis = list(title = '날짜'), 
         yaxis = list(title = '원'), 
         margin =  list(t = 50, b = 25, l = 25, r = 25))

fig <- plotly_json(fig, FALSE)
write(fig,'use.json')



fig <- df_취업률_2000 |> 
  plot_ly() |> 
  add_trace(type = 'box', data = df_취업률_2000 |> filter(과정구분 == '대학과정'),
            x = ~대계열, y = ~취업률, name = '대학') |> 
  add_trace(type = 'box', data = df_취업률_2000 |> filter(과정구분 == '전문대학과정'), 
            x = ~대계열, y = ~취업률, name = '전문대학') |> 
  layout(boxmode = "group", 
         title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'use1.json')


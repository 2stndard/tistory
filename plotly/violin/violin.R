p_violin <- 
  df_취업률_2000 |> plot_ly()

fig <- p_violin |> 
  ## 바이올린 trace 추가
  add_trace(type = 'violin', x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'violin.json')


fig <- p_violin |> 
  add_trace(data = df_취업률_2000 |> filter(과정구분 == '대학과정'),
            type = 'violin', x = ~대계열, y = ~취업률, name = '대학', 
            side = 'positive', box = list(visible = TRUE, width = 0.5), 
            meanline = list(visible = TRUE, color = 'red', width = 1)) |>
  add_trace(data = df_취업률_2000 |> filter(과정구분 == '전문대학과정'), 
            type = 'violin', x = ~대계열, y = ~취업률, name = '전문대학', 
            side = 'negative', box = list(visible = TRUE, width = 0.5), 
            meanline = list(visible = TRUE, color = 'red', width = 1)) |> 
  layout(violinmode = "overlay", 
         title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'violin_side.json')

fig <- df_취업률_2000 |>
  plot_ly(x = ~졸업자수, y = ~취업자수, name = ~대계열,
          ## hovertext를 학과명으로 매핑
          hovertext = ~학과명) |>
  ## 제목과 여백의 설정
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'hovertext.json')


fig <- df_취업률_2000 |>
  plot_ly(x = ~졸업자수, y = ~취업자수, name = ~대계열,
          ## hovertext, hoverinfo의 설정
          hovertext = ~학과명, hoverinfo = 'x+y+text') |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'hoverinfo1.json')


fig <- df_취업률_2000 |> 
  plot_ly(x = ~졸업자수, y = ~취업자수, name = ~대계열,
          ## hoverinfo를 설정하고 hovertext를 중계열로 매핑
          hoverinfo = 'x+y+text', hovertext = ~중계열) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'hoverinfo2.json')


fig <- df_취업률_2000 |> 
  plot_ly(x = ~졸업자수, y = ~취업자수, name = ~대계열,
          ## hoverinfo를 설정없이 hovertext를 중계열로 매핑
          hovertext = ~중계열) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'hoverinfo3.json')


fig <- df_취업률_2000 |> 
  plot_ly(x = ~졸업자수, y = ~취업자수, name = ~대계열, 
          hoverinfo = 'x+y+text', text = ~대계열, 
          ## hovertamplate의 설정
          hovertemplate = ' 졸업자:%{x}, 취업자:%{y}, 대계열:%{text}') |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'hovertemplate.json')
